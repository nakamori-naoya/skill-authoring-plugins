# shop-web

通販サイトの web アプリである。

## 道具

依存は pnpm で入れる。2026年7月に yarn から移り、lockfile は pnpm-lock.yaml である。

画面は Next.js の App Router で作る。

## API

外部に公開する API のエラーは、RFC 9457 の problem details（`application/problem+json`）の形で返す。取引先の連携の仕様がこの形を求めているからである。

## データベース

列の名前を変えるときは、新しい列を足して両方に書く版を先に出し、読み手が移ってから古い列を消す、の二段階で行う。6月に一度に名前を変えたとき、古い版のアプリがまだ動いていて、注文の登録が失敗した。
