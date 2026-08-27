#!/usr/bin/env bash
# skill-authoringの配布rootだけを検証する。
set -eu

SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
PLUGIN_ROOT=$(cd "$SCRIPT_DIR/.." && pwd)

[ "${1:-}" = "--root-only" ] && [ "$#" -eq 1 ] || {
  echo "usage: prepare.sh --root-only" >&2
  exit 2
}

for manifest in .codex-plugin/plugin.json .claude-plugin/plugin.json; do
  path="$PLUGIN_ROOT/$manifest"
  [ -f "$path" ] || { echo "[error] manifestが無い: $path" >&2; exit 2; }
  jq -e '.name == "skill-authoring" and (.version | type == "string" and length > 0)' "$path" >/dev/null \
    || { echo "[error] manifest identityが不正: $path" >&2; exit 2; }
done

[ -f "$PLUGIN_ROOT/skills/author-skill/SKILL.md" ] \
  || { echo "[error] author-skill入口が無い: $PLUGIN_ROOT" >&2; exit 2; }
printf '%s\n' "$PLUGIN_ROOT"
