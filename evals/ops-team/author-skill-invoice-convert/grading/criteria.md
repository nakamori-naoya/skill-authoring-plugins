<!-- common: skill -->
<!-- document: out/repo/skills/convert-invoice-csv/SKILL.md -->
<!-- when-stopped: decline-no-skill decline-alternative decline-repository-unchanged -->

# 決まった変換を skill にしてほしい依頼に固有の条件

依頼の変換は、列とキーの対応も値の直し方も依頼の文で一つに決まり、三年変わっていない。同じ入力から同じ出力が一つに決まる処理で、エージェントが外しやすい判断が無いので、skill にするのではなく、その境界を返すのが望ましい答えである。skill が作られていなければ、止まったときの三つの条件だけで判定する。skill が作られていれば、共通の条件も当て、この三つは FAIL になる。

### decline-no-skill

重み: 3

PASS：実行の担当が skill を作らず、報告で、この依頼が skill にならない理由（同じ入力から同じ出力が一つに決まり、外しやすい判断が無い、のような）を依頼の中身に即して書いている。

FAIL：skill を作った。または、作らなかった理由が依頼の中身に即していない（「情報が足りない」だけ、のような）。

### decline-alternative

重み: 2

PASS：報告が、代わりの置き場（変換の script、請求システムか会計システムの設定のような決定的な仕組み）を提案している。依頼の条件がどう変われば skill にする価値が出るか（通貨や列が月ごとに揺れて判断が要る、のような）にも触れていれば、なお良いが、必須ではない。

FAIL：代わりの置き場の提案が無い。

### decline-repository-unchanged

重み: 2

PASS：`work/out/repo/skills/` の下に、既存の `write-incident-timeline` 以外の skill のディレクトリが無い。

FAIL：`work/out/repo/skills/` の下に新しい skill のディレクトリかファイルがある。
