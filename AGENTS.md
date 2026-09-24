> 作業を始める前に、workspace規約入口 `/Users/naoya-nakamoriq/Documents/Github/harness-pluginsv2/AGENTS.md` を読み、そこから指定される共通規約とこのrepository固有の規則を適用する。

# AGENTS.md

このrepositoryは、自己完結したskillを設計・作成・更新する能力だけを配布するsourceである。

skill作成・更新の共通規律の基準資料は、`/Users/naoya-nakamoriq/Documents/Github/harness-pluginsv2/skill-authoring-plugins/plugins/skill-authoring/skills/author-skill/references/harness-plugin-authoring.md`である。このrepositoryの変更では全文を読み、以下にはrepository固有の配布境界だけを置く。共通規律をこのfileへ複製しない。

- 一つのpluginは`skill-authoring`だけを配布する。
- marketplaceへ公開するインストール対象は`skill-authoring`だけにする。公開入口は、skillの設計から検査までを完了させる`author-skill`と、agentの記憶と案件の規約を昇格・留置・破棄に振り分ける`triage-agent-memory`の二つである。どちらも内部工程を別の入口へ分解しない。
- 題材固有のdomain、data model、BDD、文書表現、運用、特定repositoryの分類を同梱規律へ持ち込まない。
- 旧モノレポのtheme一覧、固定配置、必読文書、行数上限、shared fileとのbyte一致を前提にしない。
- pluginは外部skillやpluginの存在を前提にせず、単体で利用できるようにする。
- 変更後は`bash scripts/validate.sh`を実行し、正常系と意図的に壊した負の試験を確認する。
- install cacheは編集せず、このsourceだけを変更する。
