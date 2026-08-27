# Skill Authoring Plugins

自己完結したskillを、利用場面と境界事例から設計・作成・更新するClaude Code/Codex両対応marketplaceです。

旧`harness-plugins`の`skill-authoring`が持っていた判断規律を引き継ぎつつ、旧モノレポ固有のtheme一覧、配置root、必読文書、行数上限、設定resolverには依存しません。対象repositoryに規約があればそれに従い、なければ配布単位の中で閉じる最小構成を選びます。

## インストール

### Codex

```bash
codex plugin marketplace add nakamori-naoya/skill-authoring-plugins
codex plugin add skill-authoring@skill-authoring
```

### Claude Code

```bash
claude plugin marketplace add nakamori-naoya/skill-authoring-plugins
claude plugin install skill-authoring@skill-authoring
```

## 配布するplugin

- `skill-authoring`: 一つの再利用可能な仕事を完了する自己完結skillを作成・更新する

利用契約は[plugin README](plugins/skill-authoring/README.md)、検証方法は[VALIDATION.md](VALIDATION.md)を参照してください。
