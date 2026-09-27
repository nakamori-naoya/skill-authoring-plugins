#!/usr/bin/env bash
# Scenario: skill-authoringの各入口が自分のreferenceへ直接届き、marketplace配布契約を守る
# 配置と manifest は兄弟checkout harness-tools の validate-plugin-repository.py が判定する。
# ここで足すのは、marketplace配布契約とその負例、referenceの到達性、shell構文である。
set -uo pipefail

ROOT=$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)
PLUGIN="$ROOT/plugins/skill-authoring"
TMP_ROOT=$(mktemp -d "${TMPDIR:-/tmp}/skill-authoring-validation.XXXXXX") || exit 2
trap 'rm -rf "$TMP_ROOT"' EXIT
passed=0 failed=0
pass() { printf 'PASS: %s\n' "$1"; passed=$((passed + 1)); }
fail() { printf 'FAIL: %s\n' "$1"; failed=$((failed + 1)); }
for cmd in bash find jq python3 rg yq; do
  command -v "$cmd" >/dev/null 2>&1 && pass "command $cmd" || fail "command $cmd が無い"
done

# root契約（配置・manifest）の基準資料は兄弟checkout harness-tools だけ。無ければ止まる（fixtureで代用しない）。repository固有のvalidate-marketplace.shはroot契約を置き換えない。
TOOLS="$ROOT/../harness-tools/tools"
[ -d "$TOOLS" ] || { echo "[error] 兄弟 checkout harness-tools が無い: $TOOLS" >&2; exit 2; }
python3 "$TOOLS/validate-plugin-repository.py" "$ROOT" >"$TMP_ROOT/root-contract.out" 2>&1 && pass "root契約（配置・manifest）" || { cat "$TMP_ROOT/root-contract.out"; fail "root契約"; }

bash "$ROOT/scripts/validate-marketplace.sh" "$ROOT" && pass "marketplace配布契約" || fail "marketplace配布契約"
bash "$ROOT/scripts/test-marketplace-validation.sh" && pass "marketplace配布契約の負例" || fail "marketplace配布契約の負例"

if python3 - "$PLUGIN" <<'PY'
from pathlib import Path
import re
import sys

for root in sorted(p for p in (Path(sys.argv[1]) / "skills").iterdir() if p.is_dir()):
    skill = (root / "SKILL.md").read_text()
    links = sorted(set(re.findall(r"\[[^]]+\]\((references/[^)]+\.md)\)", skill)))
    expected = sorted(str(path.relative_to(root)) for path in (root / "references").glob("*.md"))
    if links != expected or any(not (root / link).is_file() for link in links):
        raise SystemExit(1)
PY
then
  pass "referenceは入口から直接到達"
else
  fail "reference到達性"
fi

syntax_failed=0
while IFS= read -r script; do bash -n "$script" || syntax_failed=1; done < <(find "$ROOT/scripts" -type f -name '*.sh' | sort)
[ "$syntax_failed" -eq 0 ] && pass "shell構文" || fail "shell構文"

printf '\nValidation: %d passed, %d failed\n' "$passed" "$failed"
[ "$failed" -eq 0 ]
