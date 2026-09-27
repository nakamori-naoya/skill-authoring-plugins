# Validation

受入検査は次で実行します。

```bash
bash scripts/validate.sh
```

`scripts/validate.sh`は、兄弟checkout `../harness-tools/tools/validate-plugin-repository.py`（保守toolの唯一の基準資料。無ければ止まり、fixtureで代用しません）で配置とmanifestを検査し、そのうえでこのrepositoryに固有の、marketplace配布契約とその負例、各入口からreferenceへの直接の到達、shell構文を確認します。workspace rootの`bash scripts/validate.sh /Users/naoya-nakamoriq/Documents/Github/harness-pluginsv2/skill-authoring-plugins`は規約入口の検査と同じroot契約を掛けます。CIは`.github/workflows/validate.yml`で`harness-tools`を兄弟checkoutし、`harness-tools/ci/validate.sh`でlocalと同じcommandを実行します。

skill 本体が判断を外さずに済むかは、検査ではなく、典型例・負例・境界例で使ってみて読んで確かめる。

## 検証の eval

二つの入口が、利用者の原則に沿った成果を出せるかは、repository の root の `evals/` の下のケースで確かめる。実行は `claude plugin eval` が受け持ち、成果の出来は、作業したエージェントとは別の Claude（採点役）が、条件ごとに判定と根拠を書いて受け持つ。plugin eval の `graders/` には、読まずに判定できること（skill を使ったか、成果のファイルができたか、手元の repository の検査を実行したか）だけを置く。

ケースは三つある。`evals/ops-team/author-skill-postmortem` は、複数の運用チームへ配る手元の repository に、障害の振り返りの叩き台を作る skill を作らせる。既存の skill が時系列の判断を持ち、依頼には一つのチームだけの道具の決まりが混ざっている。`evals/ops-team/author-skill-invoice-convert` は、同じ入力から同じ出力が一つに決まる変換を skill にしてほしいという依頼で、skill にせずに境界を返すかを見る。`evals/web-project/triage-agent-memory-shop` は、偽の通販サイトの案件の記憶、規約、plugin の README を手元に置き、振り分けの資料を作らせる。手元の材料は各ケースの `materials/` と `evals/ops-team/fixture/` にあり、外部のサービスには触れない。

共通の条件は `evals/criteria/` の `skill.md` と `memory-triage.md`、採点役への指示は `brief.md`、ケースに固有の条件は `<ケース>/grading/criteria.md` にある。重みは、利用者の原則の芯を 3、成果の骨組みを 2、細部を 1 とし、85 点以上を「実用に足る」、70 点以上を「手直しで使える」、70 点未満を「作り直しが要る」とする。条件か採点役への指示を変えたら、`<ケース>/grading/calibration/` の二本（実際の成果と、既知の欠陥を埋めた写し）に採点役をかけ、`expected.md` の判定を再現できるかを先に確かめる。

実行と採点は次のとおりである。`--scaffold` は、ケースの `scaffold.sh` をあなたの権限で実行するので、この repository のケースにだけ使う。scaffold は兄弟 checkout の `../write-doc-plugins/` から書くときの規範を写し、無ければ止まる。採点の道具は harness-tools の `tools/grade-eval.sh` で、引数はすべて絶対パスで渡す。

```bash
claude plugin eval . --case author-skill-postmortem \
  --runs 1 --ablation none --keep-temp \
  --scaffold --allow-tools Write Edit Bash \
  --max-cost-usd 5 --no-publish
bash /Users/naoya-nakamoriq/Documents/Github/harness-pluginsv2/harness-tools/tools/grade-eval.sh \
  "$(pwd)/evals/ops-team/author-skill-postmortem" /private/tmp/e-XXXXXX
```

採点の結果は `evals/results/` に書かれ、git の管理から外してある。同じ秒に二つの採点を始めると結果の名前が重なるので、採点は一つずつ動かす。
