# Skill Authoring Plugins

自己完結したskillを、利用場面と境界事例から設計・作成・更新するClaude Code/Codex両対応marketplaceです。

旧`harness-plugins`の`skill-authoring`が持っていた判断規律を引き継ぎつつ、旧モノレポ固有のtheme一覧、配置root、必読文書、行数上限、設定resolverには依存しません。対象repositoryに規約があればそれに従い、なければ配布単位の中で閉じる最小構成を選びます。

## こんなときに使う

**繰り返し依頼する一つの仕事を、Claude CodeとCodexが再利用できる自己完結skillへ変えたいときに使う。** 利用場面、入力、必須行動、成功条件、停止条件、境界事例から責務を決める。

- 同じ手順を毎回長いpromptで説明している
- 既存skillの責務が広がり、何を完了すればよいか曖昧になった
- 正常系だけでなく、入力不足や境界条件で停止できるskillを作りたい
- Claude CodeとCodexの両方へ同じ能力を配布したい

複数の独立能力を順番に呼ぶ仕事は、一つのskillへ詰め込まない。その場合は各能力をskillへ分け、別のplaybookで順序を組み立てる。

## 利用例

```text
指定日の監査ログを集め、欠落を検査して保存する自己完結skillを作って。
```

```text
この既存skillを、利用場面と失敗時の停止条件が一意になるよう更新して。
```

```text
この処理は一つのskillか複数skillかを境界事例から判定して、最小構成で作って。
```

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
