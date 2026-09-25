# Validation

受入検査は次で実行します。

```bash
bash scripts/validate.sh
```

検査は、両marketplaceと両runtime manifestのidentity一致（`skills`のlist宣言と`metadata.harness`）、manifestから単一skill入口への直接接続、referenceの到達性、旧モノレポ固有設定と設定解決runtimeの不在、禁止参照形（`${.`、`<!-- BEGIN shared:`、`CLAUDE_PLUGIN_ROOT`、`BUNDLE_ROOT`）の不在、shell構文を確認します。

`scripts/validate.sh`は先に兄弟checkout `../harness-tools/tools/validate-plugin-repository.py`（保守toolの唯一の基準資料。無ければ止まり、fixtureで代用しません）でroot契約（配置・manifest・隣接`playbook.yml`・禁止参照形）を検査します。workspace rootの`bash scripts/validate.sh /Users/naoya-nakamoriq/Documents/Github/harness-pluginsv2/skill-authoring-plugins`は規約入口の検査と同じroot契約を掛けます。CIは`.github/workflows/validate.yml`で`harness-tools`を兄弟checkoutし、`harness-tools/ci/validate.sh`でlocalと同じcommandを実行します。

skill 本体が判断を外さずに済むかは、検査ではなく、典型例・負例・境界例で使ってみて読んで確かめる。
