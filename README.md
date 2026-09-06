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

インストールするのは`skill-authoring@skill-authoring`です。外部プラグインの追加は不要です。

内部のスキルは同梱されています。個別にインストールせず、公開入口から利用してください。

### Codex

利用するCodexと同じ設定環境で実行してください。

```bash
codex plugin marketplace add nakamori-naoya/skill-authoring-plugins
codex plugin add skill-authoring@skill-authoring
codex plugin list
```

一覧で導入先を確認し、新しい会話で利用してください。

### Claude Code

次は自分の全プロジェクトで使う例です。このプロジェクトのチームで共有する場合は`project`、このプロジェクトで自分だけが使う場合は`local`に変更し、利用先のディレクトリで実行してください。

```bash
CLAUDE_PLUGIN_SCOPE=user
claude plugin marketplace add nakamori-naoya/skill-authoring-plugins --scope "$CLAUDE_PLUGIN_SCOPE"
claude plugin install skill-authoring@skill-authoring --scope "$CLAUDE_PLUGIN_SCOPE"
claude plugin list
```

一覧で導入を確認し、Claude Codeを再起動してください。すでに導入しているパッケージは、次の更新手順を使ってください。

## 更新する

GitHubから登録したmarketplaceを更新し、その公開パッケージを更新します。新規インストールと同じCodexの設定環境、Claude Codeの適用範囲を使ってください。

### Codex

```bash
codex plugin marketplace upgrade skill-authoring
codex plugin add skill-authoring@skill-authoring
codex plugin list
```

更新後は新しい会話で確認してください。ローカルのパスからmarketplaceを登録した場合は、Git版の更新コマンドではなく、その登録先のソースを更新してから追加し直します。

### Claude Code

```bash
# インストール時に合わせてuser / project / localを選ぶ
CLAUDE_PLUGIN_SCOPE=user
claude plugin marketplace update skill-authoring
claude plugin update skill-authoring@skill-authoring --scope "$CLAUDE_PLUGIN_SCOPE"
claude plugin list
```

更新後はClaude Codeを再起動してください。

marketplaceの取得と、インストール済みパッケージの更新は分けて確認します。同じバージョンとして公開された変更は、更新コマンドだけでは反映されない場合があります。「最新」と表示された場合は公開バージョンを確認し、キャッシュ内のファイルを直接編集しないでください。

コマンドは2026-09-06時点のCLIヘルプと、[Codexのmarketplace管理](https://developers.openai.com/plugins/build/plugins)、[Claude Codeの更新仕様](https://code.claude.com/docs/en/plugins-reference#plugin-update)を確認しています。

## 配布するplugin

- `skill-authoring`: 一つの再利用可能な仕事を完了する自己完結skillを作成・更新する

利用契約は[plugin README](plugins/skill-authoring/README.md)、検証方法は[VALIDATION.md](VALIDATION.md)を参照してください。
