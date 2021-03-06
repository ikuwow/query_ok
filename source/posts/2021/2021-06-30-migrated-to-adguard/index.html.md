---

# title: migrated-to-adguard
title: 広告ブロックの仕組みをAdGuardに一本化した
date: 2021-06-30 15:32 JST
tags:
thumbnail:

---

（一本化したのは少し前の話）

この大インターネット時代、穏やかな心を保つために必須の広告ブロック。今まで広告ブロックは以下の3つを併用していた。

* [1Blocker](https://1blocker.com)
* [NextDNS](https://nextdns.io)
* [AdBlock Plus](http://adblockplus.org/)

1BlockerはmacOS/iOS/iPadOSのSafariでのみ機能する。自分のメインブラウザがSafariで、かつ色々とiCloud同期をしてくれる点を買って採用していた。AppleのネイティブAPIを使うのでSafari以外のブラウザはサポートしていない。ChromeやFirefoxではとりあえずAdBlock Plusを入れて最低限のブロックを実現していた。

NextDNSは広告配信やトラッキングに関するリクエストを名前解決の段階でブロックしてくれる。アプリ内広告のリクエストもブロックの対象になり、トラッキングに関係するリクエストもブロックしてくれるので単純にブラウジングが早くなる。しばらく使っていたが副作用が非常に多かった。デフォルトのルールだとGoogle AnalyticsやNew Relicの管理画面にすらアクセスできなくなったり、Google shoppingのリンク（googleadservices.comなど）も全てが効かなくなるなど不便で、これらを許可するために手動で例外を追加していた。

いろんなツールを採用してあっちの欠点をこっちの利点で補って・・・などとしているのが億劫になり、代替を探すとAdGuardがよさそうだったのでこれに一本化した。

[AdGuard — 最先端の広告ブロッカー！](https://adguard.com/ja/welcome.html)

OSに最適化されているよ！と謳っており、ブラウザごとの設定は不要で1つ入れて有効化しておけばそのデバイス全体で広告がブロックされる。どういう仕組みかはわからない。もちろんYouTubeの広告もブロックしてくれる（YouTubeプレミアムを契約しているので恩恵を感じることはないけれども）。 当然Windows版やAndroid版もある。

日本語で [公式ブログ](https://adguard.com/ja/blog/index.html) が定期的に更新されている点も高評価。努力が感じられる。

パーソナルライセンスだとデバイス数が3台と少ないので、広告をブロックしようという発想を思いつく程度の人であれば基本的にファミリー版を推奨。ライセンスは安売りされているところで買うのがよいと思う。自分が買ったVectorではファミリーの永続ライセンスが83%OFFになっていた。安い・・・。

AdGuard DNSというのもあるが用意されているのはDNSサーバだけで、設定がクライアントごとにDNSサーバのIPアドレスを入れて設定するというなんとも複数デバイスに配布しにくいスタイル。今のところAdGuard単体の機能で満足していて、まだ必要性を感じていないので使っていない。

1Blockerとは違って、エレメントの削除等のカスタマイズの同期の機能はないのが欠点か。直近必要だと感じていたTwitterのトレンド欄の削除は [Simplified for Twitter on the Mac App Store](https://apps.apple.com/us/app/simplified-for-twitter/id1479307973?mt=12) を入れて我慢することにした（まあ要素の削除を広告ブロッカーに任せるのがいいのかという話はありつつも）。[mas](https://github.com/mas-cli/mas) + Brewfileで他のMacに配布できるのでよしとする。[Twitter Blue](https://japanese.engadget.com/twitter-blue-subscription-023013976.html)に広告やTrendを消せる機能が追加された上で日本展開来てくれ〜。
