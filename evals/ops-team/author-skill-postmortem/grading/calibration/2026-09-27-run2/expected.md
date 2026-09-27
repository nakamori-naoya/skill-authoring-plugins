# 期待する判定

この較正の資料は、2026-09-27 の2回目の実行（claude plugin eval、`--runs 1 --ablation none`。手元の repository を複数のチームへ配る置き場に直した後）で作られた `out/repo/skills/write-postmortem/SKILL.md` と、手元の repository の写し（`.git` は除いた）と、最後の報告（`out/trace.jsonl`）である。下の判定は、eval を組んだ担当が skill、repository、依頼の文を読んで出したもので、採点役がこれを再現できるかで採点の形を確かめる。境目と書いた条件は、読み方で判定が分かれうるので、一致の数を別に数える。

採点役には、このファイルを読ませない。

## 判定

- skill-judgment-only: PASS
- skill-owner-referenced: PASS
- skill-no-case-values: PASS
- skill-stop-by-conclusion: PASS（境目）
- skill-contrast-examples: PASS
- skill-business-names: PASS
- skill-prose-structure: PASS
- skill-tried-and-reported: PASS
- skill-reasoned-weight: PASS
- skill-repository-convention: PASS
- postmortem-system-not-person: PASS
- postmortem-leave-decisions: PASS
- postmortem-contributing-conditions: PASS
- postmortem-actionable-prevention: PASS
- postmortem-scope-boundary: PASS

## 理由

時系列の書き方は `write-incident-timeline` を名前で指して決め直さず、Datadog と #incident は「チームごとに違う」として規律にしていない。振り返るかどうかの境目は、ステージングと手元の開発環境の対で示している。

skill-stop-by-conclusion は、止まる節を立てず、振り返るかどうかが分からないときは止まり、言い切れない要因は推定と書いて進む、と節ごとに書いている。結論と細部の区別は読み取れるので PASS としたが、止まる基準がまとまって書かれていないことを重く見れば FAIL になりうるので、境目とした。
