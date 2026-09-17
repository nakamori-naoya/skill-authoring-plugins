#!/usr/bin/env bash
# Scenario: skill-authoringが単体配布でき、旧モノレポ固有前提を持たない
# Given: 両runtime向けmanifest、単一skill入口、判断referenceがある
# When: identity、到達性、配布root検査の正常系と負例を実行する
# Then: 不整合、旧構造への依存、設定解決runtime、禁止参照形が一つでもあれば非0で終了する
set -uo pipefail

ROOT=$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)
PLUGIN="$ROOT/plugins/skill-authoring"
TMP_ROOT=$(mktemp -d "${TMPDIR:-/tmp}/skill-authoring-validation.XXXXXX") || exit 2
trap 'rm -rf "$TMP_ROOT"' EXIT
passed=0 failed=0
pass() { printf 'PASS: %s\n' "$1"; passed=$((passed + 1)); }
fail() { printf 'FAIL: %s\n' "$1"; failed=$((failed + 1)); }
skill_frontmatter_name() {
  awk 'NR==1 { if ($0 != "---") exit 2; next } $0=="---" { found=1; exit } { print } END { if (!found) exit 2 }' "$1" \
    | yq -er '.name | select(tag == "!!str" and length > 0)' -
}

for cmd in bash find jq python3 rg yq; do
  command -v "$cmd" >/dev/null 2>&1 && pass "command $cmd" || fail "command $cmd が無い"
done

printf '%s\n' '---' "name: 'fixture-skill' # comment" '---' 'name: body-only' > "$TMP_ROOT/frontmatter-valid.md"
printf '%s\n' '---' 'description: no name' '---' 'name: body-only' > "$TMP_ROOT/frontmatter-invalid.md"
if [ "$(skill_frontmatter_name "$TMP_ROOT/frontmatter-valid.md")" = "fixture-skill" ] \
  && ! skill_frontmatter_name "$TMP_ROOT/frontmatter-invalid.md" >/dev/null 2>&1; then
  pass "frontmatter YAML identity境界"
else
  fail "frontmatter YAML identity境界"
fi

# root契約（配置・manifest・隣接playbook.yml・禁止参照形）の正本は兄弟checkout harness-tools だけ。無ければ止まる（fixtureで代用しない）。repository固有のvalidate-marketplace.shはroot契約を置き換えない。
TOOLS="$ROOT/../harness-tools/tools"
[ -d "$TOOLS" ] || { echo "[error] 兄弟 checkout harness-tools が無い: $TOOLS" >&2; exit 2; }
python3 "$TOOLS/validate-plugin-repository.py" "$ROOT" >"$TMP_ROOT/root-contract.out" 2>&1 && pass "root契約（配置・manifest・隣接playbook.yml・禁止参照形）" || { cat "$TMP_ROOT/root-contract.out"; fail "root契約"; }

bash "$ROOT/scripts/validate-marketplace.sh" "$ROOT" && pass "marketplace配布契約" || fail "marketplace配布契約"
bash "$ROOT/scripts/test-marketplace-validation.sh" && pass "marketplace配布契約の負例" || fail "marketplace配布契約の負例"

if jq -e '.name=="skill-authoring" and (.plugins|length==1) and .plugins[0].name=="skill-authoring" and .plugins[0].version=="2.1.0" and .plugins[0].source.path=="./plugins/skill-authoring"' "$ROOT/.agents/plugins/marketplace.json" >/dev/null \
  && jq -e '.name=="skill-authoring" and (.plugins|length==1) and .plugins[0].name=="skill-authoring" and .plugins[0].version=="2.1.0" and .plugins[0].source=="./plugins/skill-authoring"' "$ROOT/.claude-plugin/marketplace.json" >/dev/null; then
  pass "marketplace identity"
else
  fail "marketplace identity"
fi

if jq -e '.name=="skill-authoring" and .version=="2.1.0" and .skills==["./skills/author-skill"] and .interface.capabilities==["Skills"] and .metadata.harness=={"marketplace":"skill-authoring","contractVersion":1}' "$PLUGIN/.codex-plugin/plugin.json" >/dev/null \
  && jq -e '.name=="skill-authoring" and .version=="2.1.0" and .skills==["./skills/author-skill"] and .metadata.harness=={"marketplace":"skill-authoring","contractVersion":1}' "$PLUGIN/.claude-plugin/plugin.json" >/dev/null; then
  pass "runtime manifest identity"
else
  fail "runtime manifest identity"
fi

if [ -f "$PLUGIN/skills/author-skill/SKILL.md" ] \
  && [ "$(find "$PLUGIN" -type f -name SKILL.md | wc -l | tr -d ' ')" = "1" ] \
  && [ ! -e "$PLUGIN/playbooks" ] && [ ! -e "$PLUGIN/internal" ] \
  && [ "$(find "$PLUGIN" -type d \( -name .claude-plugin -o -name .codex-plugin \) | wc -l | tr -d ' ')" = "2" ]; then
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
  && [ ! -e "$PLUGIN/scripts" ] \
  && ! rg -n 'developer/(principles|product-definition|harness-authoring)\.md|plugins/(skills|playbooks)/<theme>|allowed_themes|max_skill_lines|required_repository_files|shared/(skill/resolve|prepare)\.sh' "$PLUGIN" >/dev/null; then
  pass "旧モノレポ固有設定と設定解決runtimeへ非依存"
else
  fail "旧モノレポ固有設定または設定解決runtimeが残存"
fi

# 禁止参照形（root validatorと同じ4 token）。README.mdは対象外
if ! rg -nF -e '${.' -e '<!-- BEGIN shared:' -e 'CLAUDE_PLUGIN_ROOT' -e 'BUNDLE_ROOT' \
    "$PLUGIN/skills/author-skill/SKILL.md" "$PLUGIN/skills/author-skill/references" >/dev/null; then
  pass "禁止参照形の不在"
else
  fail "禁止参照形が残存"
fi

if [ "$(skill_frontmatter_name "$PLUGIN/skills/author-skill/SKILL.md")" = "author-skill" ]; then
  pass "manifestから自己完結skillへの直接接続"
else
  fail "manifestと自己完結skillのidentity不整合"
fi

syntax_failed=0
while IFS= read -r script; do bash -n "$script" || syntax_failed=1; done < <(find "$ROOT/scripts" -type f -name '*.sh' | sort)
[ "$syntax_failed" -eq 0 ] && pass "shell構文" || fail "shell構文"

printf '\nValidation: %d passed, %d failed\n' "$passed" "$failed"
[ "$failed" -eq 0 ]
