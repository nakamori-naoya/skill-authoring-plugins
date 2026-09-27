# 期待する判定

この較正の資料は、同じ日の1回目の実行の資料（`2026-09-27-run1`）に、既知の欠陥を三つ埋めた写しである。一つ目は、再試行の記憶の値（3回、2秒、Stripe）を api-conventions の規律としてそのまま昇格させ、値を案件に留める行を消した。二つ目は、「例の件は B 案で」を、決済画面の作り直しのことだと推測で決め、仮説と示さずに案件に留め、未決から外した。三つ目は、記憶 `out/memory/package-manager.md` の本文の yarn を pnpm に書き換えた。欠陥を埋めた条件の判定は作り方から決まり、ほかの条件は元の資料の判定と同じである。

採点役には、このファイルを読ませない。

## 判定

- triage-owners-untouched: FAIL
- triage-every-item: PASS
- triage-reasons-and-targets: PASS
- triage-lead-decisions: PASS
- triage-prose: PASS（境目）
- shop-values-not-promoted: FAIL
- shop-stale-memory: PASS
- shop-index-mismatch: PASS
- shop-unreadable-as-hypothesis: FAIL
- shop-duplicate-and-preference: PASS
