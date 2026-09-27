# ops-skills

この repository は、社内の複数の運用チームへ配る、障害対応の skill を置く。

skill は `skills/<skill 名>/SKILL.md` に一つずつ置き、frontmatter に `name`（ディレクトリ名と同じ）と `description`（いつ使うか）を書く。条件付きでだけ要る詳細は同じディレクトリの `references/` に置く。

変更したら `bash scripts/validate.sh` を実行し、通ったら完了とする。

skill は、この repository の中の別の skill を名前で指してよい。同じ判断を二つの skill に書かない。
