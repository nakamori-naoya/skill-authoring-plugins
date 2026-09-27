# 期待する判定

この較正の資料は、2026-09-27 の1回目の実行（claude plugin eval、`--runs 1 --ablation none`）で作られた `out/triage.md` と、実行の担当が手を付けなかった記憶、案件、plugin の写し（案件の `.git` は除いた）と、最後の報告（`out/trace.jsonl`）である。下の判定は、eval を組んだ担当が資料と元の写しを読んで出したもので、採点役がこれを再現できるかで採点の形を確かめる。境目と書いた条件は、読み方で判定が分かれうるので、一致の数を別に数える。

採点役には、このファイルを読ませない。

## 判定

- triage-owners-untouched: PASS
- triage-every-item: PASS
- triage-reasons-and-targets: PASS
- triage-lead-decisions: PASS
- triage-prose: PASS（境目）
- shop-values-not-promoted: PASS
- shop-stale-memory: PASS
- shop-index-mismatch: PASS
- shop-unreadable-as-hypothesis: PASS
- shop-duplicate-and-preference: PASS

## 理由

記憶の七件と、案件の AGENTS.md の四つの判断と docs のテストの決まりが、すべて振り分けられている。再試行の記憶は、原則を api-conventions の判断例へ、Stripe と3回と2秒を案件に留める、と分けている。yarn の記憶は、AGENTS.md の7行目と 2026-07-15 の commit を根拠に破棄にしている。「例の件」は破棄を仮説とし、採らなかった振り分けと確かめる方法を未決の4に書いている。

triage-prose は、昇格の節の一件目が六つの問いを箇条書きで並べ、留める件を表にしているが、表のセルは根拠の種類の短い語で、振り分けの理由は表の後の文章にあるので PASS とした。箇条書きの多さを重く見れば FAIL になりうるので、境目とした。
