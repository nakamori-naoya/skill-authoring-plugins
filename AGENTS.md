> 作業を始める前に、workspace正本入口 `/Users/naoya-nakamoriq/Documents/Github/harness-pluginsv2/AGENTS.md` を読み、そこから指定される共通規約とこのrepository固有の規則を適用する。

# AGENTS.md

このrepositoryは、自己完結したskillを設計・作成・更新する能力だけを配布するsourceである。

- 一つのpluginは`skill-authoring`だけを配布する。
- marketplaceへ公開するインストール対象は、skillの設計から検査までを完了させる`skill-authoring`だけにする。内部工程を別entryへ分解しない。
- skillの責務は、利用者が単独で完了させたい一つの仕事で区切る。複数の独立能力の順序付けは作成対象に含めない。
- 題材固有のdomain、data model、BDD、文書表現、運用、特定repositoryの分類を同梱規律へ持ち込まない。
- 旧モノレポのtheme一覧、固定配置、必読文書、行数上限、shared fileとのbyte一致を前提にしない。
- 「何であるか」と「何ではないか」を隣り合わせに書き、境界によって責務を明確にする。
- 指示は目的、入力契約、判断基準（観察対象と二者択一の述語）、手順、停止条件、出力契約を内容として持ち、読み手の補完へ依存する曖昧語を残さない。否定文の連打は判断基準と停止条件へ畳む。
- 配布物に設定解決やroot解決のruntime script、環境変数によるroot解決block、マクロ参照を置かない。skillが使うtoolは入口相対pathと入力・出力・失敗観測・停止/回復の契約で示す。
- 対象repositoryに規約がある場合はそれを優先し、規約がない場合だけ最小の標準構造を選ぶ。
- pluginは外部skillやpluginの存在を前提にせず、単体で利用できるようにする。
- 変更後は`bash scripts/validate.sh`を実行し、正常系と意図的に壊した負の試験を確認する。
- install cacheは編集せず、このsourceを正本として変更する。
