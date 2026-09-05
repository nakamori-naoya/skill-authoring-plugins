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

## 実行契約と保守

このpluginのprepareは`--root-only`で配布rootを検査する。実行設定の一時ファイルや外部plugin依存を持たない。

[doctor](scripts/doctor.py)は`python3 scripts/doctor.py --repo <対象project>`でCLI構文、両runtime公開入口、依存、設定の解決元を読み取り専用で診断する。`--distribution-only`は依存・project設定を検査しない限定診断であり、full診断の代用にはしない。

共通実装の開発時正本はProduct Planning repositoryの`shared/runtime-source`にある。更新時はそのsource checkoutを取得し、[生成CLI](scripts/sync-runtime.py)へ`--source <取得した正本directory>`を渡す。`--check`は生成差分と[生成履歴](shared/runtime-manifest.json)のversion・内容hash・対象集合を検査する。正本checkoutなしのCIでも同梱物のhashと対象集合を検査できる。実行時に別repositoryや生成CLIは不要である。変更は正本へ加え、同じ生成コマンドを各source repositoryへ適用する。

[release CLI](scripts/release.py)は`--plugin --version --notes --breaking --migration --checks`で更新計画を返す。`--checks`にはcodex/claudeの実検証結果、または未検証と理由を明示する。`--apply`で両manifestとcatalogの整合を確認して一括更新し、releases配下へ変更内容・移行・検証結果のJSON記録を残す。依存宣言は変更しない。

[意味評価fixture](evals/scenarios.json)を[評価runner](scripts/evaluate-skills.py)へ渡し、異なる生成modelとjudge modelを指定する。モデル名、実model利用、適用設定、入力、出力、SKILL hash、判定の引用と理由を保存する。これはツール無効の次応答を対象とした代表caseの意味評価であり、実ツールを使った全工程E2Eや全行動の保証ではない。保存・CLI・再開の検証は[振る舞い回帰試験](scripts/test-hardening.py)と既存validateが担う。実モデル未実行のfixtureを合格扱いにしない。

### 更新時の確認

公開skillの責務境界は維持する。配布宣言の版更新はrelease CLIを使い、両runtimeと負の試験が成功することを確認する。

### 開発CLIの入力境界

`doctor`、`release`、`sync-runtime`、意味評価runnerは、操作者が明示したローカルsource、出力先、adapter argvを扱う開発CLIである。外部から受け取った文書やモデル出力をCLI引数へ自動変換しない。doctorのfull modeは選んだrepositoryのresolverを実行するため、信頼するsource checkoutを対象にする。doctorは配布treeのsymlinkを読取・実行前に拒否し、sync-runtimeは生成先と正本treeのsymlinkをcopy前に拒否する。評価の会話・fixture・モデル出力はadapterへstdinデータとして渡し、実行argvに混ぜない。
