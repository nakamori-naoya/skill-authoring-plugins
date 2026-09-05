# AGENTS.md

このrepositoryは、自己完結したskillを設計・作成・更新する能力だけを配布するsourceである。

- 一つのpluginは`skill-authoring`だけを配布する。
- marketplaceへ公開するインストール対象は、skillの設計から検査までを完了させる`skill-authoring`だけにする。内部工程を別entryへ分解しない。
- skillの責務は、利用者が単独で完了させたい一つの仕事で区切る。複数の独立能力の順序付けは作成対象に含めない。
- 題材固有のdomain、data model、BDD、文書表現、運用、特定repositoryの分類を同梱規律へ持ち込まない。
- 旧モノレポのtheme一覧、固定配置、必読文書、行数上限、shared fileとのbyte一致を前提にしない。
- 「何であるか」と「何ではないか」を隣り合わせに書き、境界によって責務を明確にする。
- 指示は条件、必須行動、成功判定、停止時の返却を特定し、読み手の補完へ依存する曖昧語を残さない。
- 対象repositoryに規約がある場合はそれを優先し、規約がない場合だけ最小の標準構造を選ぶ。
- pluginは外部skillやpluginの存在を前提にせず、単体で利用できるようにする。
- 変更後は`bash scripts/validate.sh`を実行し、正常系と意図的に壊した負の試験を確認する。
- install cacheは編集せず、このsourceを正本として変更する。
