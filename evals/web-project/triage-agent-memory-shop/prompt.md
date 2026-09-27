---
description: 偽の通販サイトの案件の記憶と規約と plugin の README を手元に置き、triage-agent-memory で振り分けの資料を作らせる。記憶と規約を変えないか、案件の値を昇格させないか、読み取れない件で止まらないかを見る。
tags: [triage-agent-memory, memory-triage]
max_turns: 150
timeout_seconds: 2400
plugins: ["../../../plugins/skill-authoring"]
allowed_tools: [Read, Glob, Grep, Skill, TodoWrite, Write, Edit, Bash]
---

通販サイトの案件の記憶と規約を棚卸しして、振り分けの資料を作ってください。依頼の文は、この作業場所の直下の `request.md` にあります。

## 入力

依頼の文にある三つのディレクトリと保存先は、この作業場所（カレントディレクトリ）からの相対の場所で書いてあります。skill が絶対パスを求めたら、`pwd` で作業場所の絶対パスを得て、その下のパスを渡してください。`out/project/` は手元だけの git repository です。GitHub などの外部には何も送らないでください。

## ほかの package のファイル

この環境には write-doc の skill が入っていません。代わりに、その最新のファイルを `harness/write-doc/` に写してあります。skill が write-doc の書くときの規範を読むよう求めたら、`harness/write-doc/references/writing-norms.md` を読んでください。

## 利用者への確認

この実行には、問いに答える利用者がいません。skill の停止条件に当たったら止まり、何が分からないかを報告してください。

## 報告

最後に、日本語で、保存した資料のパス、振り分けの件数、今の規約と逆を言っている記憶の一覧、未決の件数、記憶と規約と plugin を変えていないことを短く書いてください。
