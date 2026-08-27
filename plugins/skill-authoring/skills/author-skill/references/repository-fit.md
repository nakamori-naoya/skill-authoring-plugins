# 対象repositoryへ適合させる

最初に、対象pathへ適用される指示書、既存の隣接plugin、marketplace、manifest、検証入口を読む。旧sourceの構造や、このpluginを開発したrepositoryの規約を対象へ移植しない。

既存skillの更新では、発見名、呼び出し方、対応runtime、resource配置、version方針を保ち、依頼が変更を求めるfileとsectionだけを変える。構造変更が責務境界を変える場合は、変更前にその影響を示す。

新規作成で対象repositoryに規約がない場合は、次の最小原則を使う。

- 配布単位とskill入口を明確にする
- 公開skillが一つなら入口を一つだけにする
- `SKILL.md`には発見用description、end-to-end workflow、停止条件、報告を置く
- 条件付きの詳しい判断だけを`references/`へ置き、入口から読む時点を示す
- 決定的処理を繰り返し実行する必要がある場合だけ`scripts/`へ置く
- 配布先で使えないrepository外pathや、未宣言の外部skillを前提にしない
- 空directory、将来用placeholder、重複するREADMEやreferenceを作らない

行数、theme名、固定directory階層、必読文書名を普遍規則にしない。それらは対象repositoryが明示した場合だけ従う。規約がないことを、独自規約を大量に追加する許可として扱わない。
