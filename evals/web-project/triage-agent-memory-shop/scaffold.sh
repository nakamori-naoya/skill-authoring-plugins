#!/usr/bin/env bash
# 依頼の文と write-doc の規範を置き、通販サイトの案件の記憶、案件の repository、plugin の workspace を out/ に写す。
# 案件の repository には、依存の入れ方を yarn から pnpm へ移した履歴を付ける（記憶と規約のどちらが新しいかを確かめられるように）。
# 採点役は materials/ の元の写しと out/ を比べて、記憶と規約が変えられていないかを見る。
set -euo pipefail
CASE_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
M="$CASE_DIR/materials"
bash "$CASE_DIR/../../scaffold.sh" "$CASE_DIR"
cp -R "$M/memory" out/memory
cp -R "$M/plugins-ws" out/plugins-ws
cp -R "$M/project" out/project
commit() {
  GIT_AUTHOR_DATE=$1 GIT_COMMITTER_DATE=$1 \
    git -C out/project -c user.name=fixture -c user.email=fixture@example.invalid commit -q -m "$2"
}
git -C out/project init -q -b main
sed -e 's/^依存は pnpm で入れる。.*$/依存は yarn で入れる。/' "$M/project/AGENTS.md" > out/project/AGENTS.md
git -C out/project add -A
commit 2026-01-20T10:00:00+09:00 "案件の規約を置く"
cp "$M/project/AGENTS.md" out/project/AGENTS.md
git -C out/project add -A
commit 2026-07-15T10:00:00+09:00 "依存の管理を yarn から pnpm へ移す"
