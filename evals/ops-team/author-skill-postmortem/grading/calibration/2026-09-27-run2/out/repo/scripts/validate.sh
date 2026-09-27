#!/usr/bin/env bash
# skills/*/SKILL.md の frontmatter に、ディレクトリ名と同じ name と、空でない description があるかを確かめる。
set -uo pipefail
ROOT=$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)
status=0
for file in "$ROOT"/skills/*/SKILL.md; do
  dir=$(basename "$(dirname "$file")")
  front=$(awk 'NR==1 { if ($0 != "---") exit; next } $0 == "---" { exit } { print }' "$file")
  name=$(printf '%s\n' "$front" | sed -n 's/^name: *//p')
  [ "$name" = "$dir" ] || { echo "name がディレクトリ名と違う: $file"; status=1; }
  printf '%s\n' "$front" | grep -q '^description: .' || { echo "description が無い: $file"; status=1; }
done
[ "$status" -eq 0 ] && echo "validate: ok"
exit "$status"
