#!/usr/bin/env bash
# ケースが共有する準備。空の作業場所へ、依頼の文（ケースの materials/request.md）を request.md として置き、
# skill が従う write-doc の書くときの規範を harness/write-doc/ へ写す。
# write-doc は隔離環境に入らないので、兄弟 checkout の最新のファイルを写し、無ければ代用せずに止まる。
# 手元に置く repository は、`fixture_repo <元> <置き先>` で git の履歴つきに作る。
set -euo pipefail

[ $# -eq 1 ] || { echo "使い方: bash scaffold.sh <ケースのディレクトリ>" >&2; exit 2; }
CASE_DIR=$(cd "$1" && pwd)
EVALS_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
REPOSITORY=$(cd "$EVALS_DIR/.." && pwd)
WORKSPACE=$(cd "$(dirname "$REPOSITORY")" && pwd)
WRITE_DOC="$WORKSPACE/write-doc-plugins/plugins/write-doc/skills/write-doc"
[ -f "$WRITE_DOC/references/writing-norms.md" ] || { echo "兄弟 checkout の write-doc が無い: $WRITE_DOC" >&2; exit 2; }

mkdir -p out harness
cp "$CASE_DIR/materials/request.md" request.md
cp -R "$WRITE_DOC" harness/write-doc
