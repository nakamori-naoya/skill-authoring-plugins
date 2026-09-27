---
description: 社内の運用チームへ skill を配る手元の repository と、障害の振り返りの叩き台を作る仕事の依頼だけを渡し、author-skill で skill を作らせる。既存の skill が関連する判断を持っている。
tags: [author-skill, skill]
max_turns: 150
timeout_seconds: 2400
plugins: ["../../../plugins/skill-authoring"]
allowed_tools: [Read, Glob, Grep, Skill, TodoWrite, Write, Edit, Bash]
---

運用チームの依頼を、skill にしてください。依頼の文は、この作業場所の直下の `request.md` にあります。

## 対象の repository

対象の repository は、この作業場所の `out/repo/` にある手元だけの git repository です。skill はその中に作り、repository の規約に従ってください。GitHub などの外部には何も送らず、push も PR もしないでください。commit もしなくて構いません。

## ほかの package のファイル

この環境には write-doc の skill が入っていません。代わりに、その最新のファイルを `harness/write-doc/` に写してあります。skill が write-doc の書くときの規範を読むよう求めたら、`harness/write-doc/references/writing-norms.md` を読んでください。

## 利用者への確認

この実行には、問いに答える利用者がいません。依頼の文で答えが決まらず結論が変わる点があれば、skill の指示どおりに止まり、何が分からないかを報告してください。結論が変わらない点は、仮説であることを報告に書いて進めてください。

## 報告

最後に、日本語で、作ったか変えたファイル、skill が持つ判断、試した例と結果、採らなかった案、確かめられなかったことを短く書いてください。止まったなら、その理由を書いてください。
