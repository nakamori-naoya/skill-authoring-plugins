# Validation

受入検査は次で実行します。

```bash
bash scripts/validate.sh
```

`scripts/validate.sh`は、兄弟checkout `../harness-tools/tools/validate-plugin-repository.py`（保守toolの唯一の基準資料。無ければ止まり、fixtureで代用しません）で配置とmanifestを検査し、そのうえでこのrepositoryに固有の、marketplace配布契約とその負例、各入口からreferenceへの直接の到達、shell構文を確認します。workspace rootの`bash scripts/validate.sh /Users/naoya-nakamoriq/Documents/Github/harness-pluginsv2/skill-authoring-plugins`は規約入口の検査と同じroot契約を掛けます。CIは`.github/workflows/validate.yml`で`harness-tools`を兄弟checkoutし、`harness-tools/ci/validate.sh`でlocalと同じcommandを実行します。

skill 本体が判断を外さずに済むかは、検査ではなく、典型例・負例・境界例で使ってみて読んで確かめる。
