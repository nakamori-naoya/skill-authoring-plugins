---
name: author-skill
description: 利用者が単独で完了させたい一つの仕事を、対象repositoryの規約に沿う自己完結skillとして作成・更新する。実際の利用場面、似て非なるもの、反例、境界事例から責務と判断規律を定める。「skillを作って」「SKILL.mdを直して」「この仕事をskillに切り出して」と依頼されたときに使う。複数skillの順序付けやrepository規約そのものの設計は対象外として境界を返す。
---

# author-skill

これは、一つの再利用可能な仕事を単独で完了できるskillを作る能力である。複数能力の順序、marketplace全体、対象domainの知識、repository規約を作る能力ではない。

## 1. 配布rootと対象規約を確かめる

```bash
PLUGIN_ROOT="${CLAUDE_PLUGIN_ROOT:-/absolute/path/to/this/plugin}"
bash "${PLUGIN_ROOT}/scripts/prepare.sh" --root-only >/dev/null || exit 2
```

対象pathへ適用される指示書をすべて読み、既存plugin / skillから構造、命名、manifest、検証commandを特定する。規約があれば従う。規約がなければ`skills/<skill-name>/SKILL.md`を入口にし、条件付き詳細があるときだけ`references/`、反復する決定的処理があるときだけ`scripts/`を作る。完了条件は、適用規約と採用構造を列挙できることである。

## 2. 一つの責務へ絞る

[責務と構成の境界](references/responsibility-and-composition.md)を読み、「何を受け取り、何を完了状態として返すか」を一文にする。「これは何か」と「これは何ではないか」を隣接して書く。独立利用できる成果が複数残る場合は実装せず、今回の対象と別作業を返して停止する。完了条件は、責務一文の成果が一つで、肯定例と非該当例を一件ずつ説明できることである。

## 3. 使用から意味を固定する

[意味と境界](references/meaning-and-boundaries.md)を読む。典型的な使用、似て非なるもの、反例、条件を一つ変えた境界例を比べる。各概念は名称や定義だけでなく、どの場面でどの判断と行動を変えるかまで書く。特定事例の関心を普遍規則にしない。完了条件は、すべての中核概念で該当条件と非該当条件から異なる行動を導けることである。

## 4. 解釈を収束させる指示を書く

[曖昧さを排除する指示構造](references/instruction-clarity.md)を読む。各指示を「適用条件、必須行動、成功判定、失敗時の停止と返却」に分ける。二人の実行者が別の行動を正当化できる語を残さない。利用者の情報がなければ推測せず、その回答で分岐が一つに決まる一問を返して停止する。完了条件は、全分岐の条件と、条件不成立時の行動が書かれていることである。

## 5. repositoryへ適合させて実装する

[repositoryへの適合](references/repository-fit.md)を読む。descriptionには完了状態と利用条件を書く。本文には入口から完了までの順序、分岐条件、停止条件、報告を置く。条件付き詳細だけを直接到達できるreferenceへ分け、繰り返す決定的処理だけをscriptにする。完了条件は、入口から全resourceへ読む条件付きで到達でき、配布directory外の未宣言fileを必要としないことである。

## 6. 振る舞いを検証する

[検証](references/verification.md)を読み、典型例、負例、境界例で判断と停止を実行する。対象repositoryの全検証を実行する。構文や語の存在だけで完了にしない。完了条件は、期待した分岐と実際の結果が三種類のfixtureで一致し、全検証commandが成功することである。

## 7. 報告する

変更したskill、責務一文、何であるか／何ではないか、判断を一意にした条件、resourcesを分けた理由、検証結果、停止理由または未確認事項を報告する。
