---
name: feature-flag-cleanup
description: "フラグの片付け"
metadata:
  type: feedback
  modified: 2026-06-30
---

機能フラグは、全員に公開してから2週間で、フラグの分岐ごと消す。

**Why:** 6月に、半年前のフラグが残っていて、設定の読み違いで古い決済画面が一部の顧客に出た。使い終わったフラグの分岐は、誰も覚えていない経路として残る。
