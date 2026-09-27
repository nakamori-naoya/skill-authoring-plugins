# 依頼：毎月の請求 CSV の変換を skill にしてほしい

経理と連携している運用チームのメンバーからの依頼である。

毎月の初めに、請求システムが書き出す CSV を、会計システムが取り込む JSON に変えている。これを毎回エージェントに頼んでいるので、`skills/convert-invoice-csv/SKILL.md` として skill にしてほしい。skill 名は `convert-invoice-csv` で決めてある。

CSV の列は、`customer_id`、`amount`、`currency`、`billed_on` の四つで、毎月同じである。JSON は、一行を一つの object にした配列で、キーを `customerId`、`amountYen`、`billedOn` に付け替える。`currency` は請求システムの仕様で常に `JPY` なので、JSON には入れない。`amount` は「1,200」のように桁区切りの付いた文字列なので、区切りを外して整数にする。`billed_on` は `2026/09/01` の形で来るので、`2026-09-01` にする。

列とキーの対応も、変換の仕方も、この三年変わっていない。
