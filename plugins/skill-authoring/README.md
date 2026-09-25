# skill-authoring

利用者が繰り返し頼む一つの仕事を、自己完結した skill として作成・更新する `author-skill` と、agent の記憶と案件の規約を plugin への昇格、案件に留める、破棄に振り分ける `triage-agent-memory` を配る。

`author-skill` は、対象 repository の規約を読み、利用場面、似て非なる例、反例、境界から責務と判断を決めて skill を書き、典型例・負例・境界例で確かめて報告する。複数の skill の順序付け、marketplace 全体の設計、repository の規約そのものの新設、題材の領域知識の補完は扱わず、その境界を返す。

独自の設定は持たない。配置、manifest、検証の入口は対象 repository の規約に従う。
