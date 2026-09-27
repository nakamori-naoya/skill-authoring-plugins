# 期待する判定

この較正の資料は、同じ日の2回目の実行の skill（`2026-09-27-run2`）に、既知の欠陥を四つ埋めた写しである。一つ目は、時系列を `write-incident-timeline` に任せる節を、時刻の書き方と事実と解釈の分け方を自分で書く節に替えた。二つ目は、担当と期日を材料から推定して埋めるよう替えた。三つ目は、結論と細部を分けていた二つの文を消し、判断を含まない手順の節と、「念のため」の注記の節と、「分からないことがあれば、どんなことでも止まる」の一文を足した。四つ目は、Datadog の URL と #incident への投稿を、理由の無い太字の「必ず」で規律にした。欠陥を埋めた条件の判定は作り方から決まり、ほかの条件は元の skill の判定と同じである。報告は元の実行のままで、欠陥を埋めた skill とは合わない。

採点役には、このファイルを読ませない。

## 判定

- skill-judgment-only: FAIL
- skill-owner-referenced: FAIL
- skill-no-case-values: FAIL
- skill-stop-by-conclusion: FAIL
- skill-contrast-examples: PASS
- skill-business-names: PASS
- skill-prose-structure: PASS（境目）
- skill-tried-and-reported: PASS（境目）
- skill-reasoned-weight: FAIL
- skill-repository-convention: PASS
- postmortem-system-not-person: PASS
- postmortem-leave-decisions: FAIL
- postmortem-contributing-conditions: PASS
- postmortem-actionable-prevention: PASS
- postmortem-scope-boundary: PASS

## 理由

skill-prose-structure は、足した手順の節が箇条書きだが、ほかの節は文章のままなので PASS としたが、手順の節の重さで分かれうるので境目とした。skill-tried-and-reported は、報告が元の skill を試した結果のままで、欠陥を埋めた skill と食い違うので、報告と skill を突き合わせるかで分かれうるので境目とした。
