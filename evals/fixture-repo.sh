#!/usr/bin/env bash
# fixture を写して、手元だけの git repository を作る。作者と日時を固定するので、commit の番号も毎回同じになる。
#
#   bash fixture-repo.sh <fixture のディレクトリ> <置き先>
set -euo pipefail
[ $# -eq 2 ] || { echo "使い方: bash fixture-repo.sh <fixture> <置き先>" >&2; exit 2; }
SRC=$(cd "$1" && pwd)
DEST=$2
DATE=2026-09-01T10:00:00+09:00
mkdir -p "$DEST"
cp -R "$SRC/." "$DEST/"
git -C "$DEST" init -q -b main
git -C "$DEST" add -A
GIT_AUTHOR_DATE=$DATE GIT_COMMITTER_DATE=$DATE \
  git -C "$DEST" -c user.name=fixture -c user.email=fixture@example.invalid commit -q -m "初期状態"
