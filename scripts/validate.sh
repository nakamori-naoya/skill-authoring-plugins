#!/usr/bin/env bash
# Scenario: skill-authoringが単体配布でき、旧モノレポ固有前提を持たない
# Given: 両runtime向けmanifest、単一skill入口、判断referenceがある
# When: identity、到達性、配布root検査の正常系と負例を実行する
# Then: 不整合または旧構造への依存が一つでもあれば非0で終了する
set -uo pipefail

ROOT=$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)
python3 "$ROOT/scripts/test-hardening.py" || exit 1
PLUGIN="$ROOT/plugins/skill-authoring"
TMP_ROOT=$(mktemp -d "${TMPDIR:-/tmp}/skill-authoring-validation.XXXXXX") || exit 2
export TMPDIR="$TMP_ROOT"
trap 'rm -rf "$TMP_ROOT"' EXIT
passed=0 failed=0
pass() { printf 'PASS: %s\n' "$1"; passed=$((passed + 1)); }
fail() { printf 'FAIL: %s\n' "$1"; failed=$((failed + 1)); }

for cmd in bash find jq python3 rg; do
  command -v "$cmd" >/dev/null 2>&1 && pass "command $cmd" || fail "command $cmd が無い"
done

bash "$ROOT/scripts/validate-marketplace.sh" "$ROOT" && pass "marketplace配布契約" || fail "marketplace配布契約"
bash "$ROOT/scripts/test-marketplace-validation.sh" && pass "marketplace配布契約の負例" || fail "marketplace配布契約の負例"

if jq -e '.name=="skill-authoring" and (.plugins|length==1) and .plugins[0].name=="skill-authoring" and (.plugins[0].version|type=="string" and length>0) and .plugins[0].source.path=="./plugins/skill-authoring"' "$ROOT/.agents/plugins/marketplace.json" >/dev/null \
  && jq -e '.name=="skill-authoring" and (.plugins|length==1) and .plugins[0].name=="skill-authoring" and (.plugins[0].version|type=="string" and length>0) and .plugins[0].source=="./plugins/skill-authoring"' "$ROOT/.claude-plugin/marketplace.json" >/dev/null; then
  pass "marketplace identity"
else
  fail "marketplace identity"
fi

if jq -e '.name=="skill-authoring" and (.version|type=="string" and length>0) and .skills=="./skills/" and .interface.capabilities==["Skills"]' "$PLUGIN/.codex-plugin/plugin.json" >/dev/null \
  && jq -e '.name=="skill-authoring" and (.version|type=="string" and length>0) and .skills=="./skills/"' "$PLUGIN/.claude-plugin/plugin.json" >/dev/null; then
  pass "runtime manifest identity"
else
  fail "runtime manifest identity"
fi

if [ -f "$PLUGIN/skills/author-skill/SKILL.md" ] \
  && [ "$(find "$PLUGIN/skills" -type f -name SKILL.md | wc -l | tr -d ' ')" = "1" ] \
  && [ ! -f "$PLUGIN/SKILL.md" ]; then
  pass "単一skill入口"
else
  fail "単一skill入口"
fi

if python3 - "$PLUGIN" <<'PY'
from pathlib import Path
import re
import sys

root = Path(sys.argv[1]) / "skills" / "author-skill"
skill = (root / "SKILL.md").read_text()
links = re.findall(r"\[[^]]+\]\((references/[^)]+\.md)\)", skill)
expected = sorted(str(path.relative_to(root)) for path in (root / "references").glob("*.md"))
if sorted(links) != expected or any(not (root / link).is_file() for link in links):
    raise SystemExit(1)
PY
then
  pass "referenceは入口から直接到達"
else
  fail "reference到達性"
fi

if [ ! -e "$PLUGIN/config" ] \
  && [ ! -e "$PLUGIN/scripts/resolve.sh" ] \
  && [ ! -e "$PLUGIN/scripts/finalize.sh" ] \
  && ! rg -n 'developer/(principles|product-definition|harness-authoring)\.md|plugins/(skills|playbooks)/<theme>|allowed_themes|max_skill_lines|required_repository_files|shared/(skill/resolve|prepare)\.sh' "$PLUGIN" >/dev/null; then
  pass "旧モノレポ固有設定へ非依存"
else
  fail "旧モノレポ固有設定が残存"
fi

if rg -n 'これは何か|何ではないか' "$PLUGIN/skills/author-skill/SKILL.md" "$PLUGIN/README.md" "$PLUGIN/skills/author-skill/references/responsibility-and-composition.md" >/dev/null \
  && rg -n '適用条件|必須行動|成功判定|失敗時' "$PLUGIN/skills/author-skill/references/instruction-clarity.md" >/dev/null; then
  pass "肯定と否定の境界および指示構造"
else
  fail "責務境界または指示構造"
fi

if bash "$PLUGIN/scripts/prepare.sh" --root-only >"$TMP_ROOT/root" 2>"$TMP_ROOT/root.err" \
  && [ "$(cat "$TMP_ROOT/root")" = "$PLUGIN" ] && [ ! -s "$TMP_ROOT/root.err" ]; then
  pass "配布root正常系"
else
  fail "配布root正常系"
fi

cp -R "$PLUGIN" "$TMP_ROOT/missing-manifest"
rm "$TMP_ROOT/missing-manifest/.claude-plugin/plugin.json"
if bash "$TMP_ROOT/missing-manifest/scripts/prepare.sh" --root-only >/dev/null 2>&1; then
  fail "manifest欠落を許可"
else
  pass "manifest欠落を拒否"
fi

cp -R "$PLUGIN" "$TMP_ROOT/wrong-name"
python3 - "$TMP_ROOT/wrong-name/.codex-plugin/plugin.json" <<'PY'
import json
from pathlib import Path
import sys

path = Path(sys.argv[1])
data = json.loads(path.read_text())
data["name"] = "wrong-name"
path.write_text(json.dumps(data))
PY
if bash "$TMP_ROOT/wrong-name/scripts/prepare.sh" --root-only >/dev/null 2>&1; then
  fail "manifest名不一致を許可"
else
  pass "manifest名不一致を拒否"
fi

syntax_failed=0
while IFS= read -r script; do bash -n "$script" || syntax_failed=1; done < <(find "$ROOT/plugins" "$ROOT/scripts" -type f -name '*.sh' | sort)
[ "$syntax_failed" -eq 0 ] && pass "shell構文" || fail "shell構文"

printf '\nValidation: %d passed, %d failed\n' "$passed" "$failed"
[ "$failed" -eq 0 ]
