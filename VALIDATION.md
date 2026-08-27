# Validation

受入検査は次で実行します。

```bash
bash scripts/validate.sh
```

検査は、両marketplaceと両runtime manifestのidentity一致、単一skill入口、reference到達性、旧モノレポ固有設定の不在、shell構文を確認します。

`prepare.sh`については、正しい配布rootを受理する正常系と、manifest欠落・plugin名不一致を拒否する負の試験を実行します。skill本体は、典型例だけでなく、似て非なるものと境界事例から責務を判定できるか、同じ入力から複数の解釈が生じる曖昧な指示が残っていないかを目視確認します。
