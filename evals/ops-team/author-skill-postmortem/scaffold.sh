#!/usr/bin/env bash
# 依頼の文と write-doc の規範を置き、運用チームの手元の repository を out/repo に作る。
set -euo pipefail
CASE_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
bash "$CASE_DIR/../../scaffold.sh" "$CASE_DIR"
bash "$CASE_DIR/../../fixture-repo.sh" "$CASE_DIR/../fixture/repo" out/repo
