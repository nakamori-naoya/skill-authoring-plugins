# Validation

受入検査は次で実行します。

```bash
bash scripts/validate.sh
```

検査は、両marketplaceと両runtime manifestのidentity一致（`skills`のlist宣言と`metadata.harness`）、manifestから単一skill入口への直接接続、referenceの到達性、旧モノレポ固有設定と設定解決runtimeの不在、禁止参照形（`${.`、`<!-- BEGIN shared:`、`CLAUDE_PLUGIN_ROOT`、`BUNDLE_ROOT`）の不在、shell構文を確認します。

workspace rootの`bash scripts/validate.sh /Users/naoya-nakamoriq/Documents/Github/harness-pluginsv2/skill-authoring-plugins`も実行し、配置とmanifestの構造契約を同じ正本で検査します。

skill本体は、主要な利用場面で責務と判断基準が機能するか、目的・入力・判断基準・手順・停止条件・出力が本文に揃っているか、否定文の連打や配管の説明が残っていないか、停止条件が止まる条件（必須入力の欠落・公開契約違反・許可が要る変更・toolの失敗・保存先が確認できない）と仮説を明示して進む条件に分かれているか、問う場面が対話の作法をgrillへ委ねて問いの選び方と結果の扱いだけを持つか、妥当な裁量を定型へ押し込めていないかを目視確認します。この意味評価を語句の存在検査や文長で代理しません。
