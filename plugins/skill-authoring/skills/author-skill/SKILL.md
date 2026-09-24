---
name: author-skill
description: 利用者が単独で完了させたい一つの仕事を、対象repositoryの規約に沿う自己完結skillとして作成・更新する。実際の利用場面、似て非なるもの、反例、境界事例から責務と判断規律を定める。「skillを作って」「SKILL.mdを直して」「この仕事をskillに切り出して」と依頼されたときに使う。複数skillの順序付けやrepository規約そのものの設計は対象外として境界を返す。
---

# author-skill

これは、一つの再利用可能な仕事を単独で完了できるskillを作る能力である。読み終えると、依頼された仕事を一つの責務へ絞り、実行agentが判断と行動を選べる`SKILL.md`と必要な`references/`・`scripts/`を書き、対象repositoryの検証を通して報告できる。複数能力の順序、marketplace全体、対象domainの知識、repository規約を作る能力ではない。

## 入力

作成または更新したい仕事と期待する完了状態、対象repositoryの絶対pathと既存のplugin / skill source、利用者が明示した制約と対象repositoryに既にある規約（AGENTS.md、CLAUDE.md、`.agents/rules/`など）を受け取る。任意の `references` は追加で従う資料の絶対path配列で、手順の最初に読む。プロジェクト固有の規約や文脈は、対象repositoryのAGENTS.md / CLAUDE.mdとこの入力で渡される。

## このskillが作るものと、分からないときの振る舞い

このskillは、他人のrepositoryにあるskillというコードを変える。だから、依頼の意図、対象、守るべき規約のどれかが分からなければ、推測で書かずに止まり、何が分からないかと提案を返す。一方で、作るskillの中の判断基準をどう書くかのように、書いた後で利用者が読んで直せる設計上の選択は、最も筋の良い案を採り、採らなかった案とともに報告で示して進む。

## 手順

1. **対象と適用規約を確かめる。** 変更対象のrepositoryとskillを特定し、そのpathへ適用される指示書をすべて読む。既存plugin / skillから構造、命名、manifest、検証commandを調べる。対象repositoryが`harness-pluginsv2` workspaceのplugin repositoryなら、[harness pluginのskillを作成・更新する共通規律](references/harness-plugin-authoring.md)を全文読み、以降のすべての手順へ適用する。規約がなければ`skills/<skill-name>/SKILL.md`を入口にし、条件付き詳細があるときだけ`references/`、反復する決定的処理があるときだけ`scripts/`を作る。
2. **一つの責務へ絞り、判断の持ち主を確かめる。** [責務と構成の境界](references/responsibility-and-composition.md)を読み、利用者が単独で完了させたい仕事と、その仕事に含めない責務を明らかにする。独立利用できる成果が複数残る場合は、今回の対象と別作業を分ける。次に、このskillが持つ判断を列挙し、共通規律の「判断の持ち主を一つにする」に従って、同じ判断を持つskillが無いかを各repositoryのREADMEの「このpackageが持つ判断」で確かめる。
3. **使用から意味を固定する。** [意味と境界](references/meaning-and-boundaries.md)を読む。主要な利用場面と、責務を取り違えやすい場面を比べ、判断や行動を実際に変える概念だけを書く。利用者の個別の指示や一つの案件の設計を取り込むときは、共通規律の「あるべき形だけを書く」に従って一段抽象化する。
4. **判断と行動が伝わる指示を書く。** workspaceのplugin repositoryでは、共通規律の「分からないことを推測で埋めない」「指示の内容」に従い、文の書き方は `write-doc` が公開の資料として宣言している「書くときの規範」（公開入口 `write-doc` の `references/writing-norms.md`）を読んで従い、本文を書く。workspaceの外のrepositoryでは、[判断と行動を明確にする方法](references/instruction-clarity.md)に従う。どちらでも、root解決の環境変数、設定展開script、「解決済みYAMLを読め」型の指示が残っていれば、skillが実際に使うtoolを入口directory相対のpathで示し、入力、出力、失敗の観測方法、失敗時に止まるか回復するかを一か所に書いたtool契約へ置き換える。
5. **repositoryへ適合させて実装する。** [repositoryへの適合](references/repository-fit.md)を読み、descriptionに完了状態と主要な利用場面を書く。条件付き詳細だけを直接到達できるreferenceへ分け、繰り返す決定的処理だけをscriptにする。持つ判断を変えたら、repositoryのREADMEの「このpackageが持つ判断」も同じ変更で直す。
6. **振る舞いを検証する。** [検証](references/verification.md)を読み、主要な利用場面と変更のリスクを代表するfixtureで判断と停止を確かめ、対象repositoryの全検証を実行する。構造検査が言うのは構文、識別子、配置、参照の実在だけである。判断基準が観察できるか、分からないときの振る舞いがskillの種類に合っているか、同じ判断を別のskillが持っていないか、返し先が実在するか、本文が `write-doc` の「書くときの規範」に沿っているかは、実行agentとして読んで判定する。
7. **報告する。** 変更したskill、守る責務と主要な判断、resourcesを分けた理由、実行した検証とその結果、目視評価、採った設計上の選択と採らなかった案、未確認事項を報告する。

## 停止条件

止まるのは、対象repository、対象skill、変更権限のどれかを特定できないとき、更新対象が存在せず別のskillを推測で変えることになるとき、依頼の意図や守るべき規約が分からないとき、対象repositoryの規約と依頼が両立しないとき、対象repositoryの検証commandが失敗して直せないときである。止まるときは、分からない点、両立しない規約と依頼の箇所、または失敗した検証とその出力に、提案を添えて返す。

## 出力

作成または更新した自己完結skill、「何を受け取り、何を完了状態として返すか」という責務一文、「何であるか」と「何ではないか」を並べた責務境界、各判断の条件と行動と成功判定、止まる条件と返すもの、実行した典型例・負例・境界例の検証結果、未確認事項または停止理由を返す。
