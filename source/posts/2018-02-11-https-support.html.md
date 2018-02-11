---
title: このブログをHTTPS対応しました
# title: https-support
date: 2018-02-11 20:27 JST
tags:
---

ずっとやろうと思っていたこのブログのHTTPS対応をしました。
ついでにHTTP/2対応もされました。

[Chrome 68からHTTPSでないサイトはNot Secureと表示されるようになる](https://japan.cnet.com/article/35114501/)
のが意外ともうすぐだったので、これを期にやってみた。

今まで普通だったHTTPがITの巨人Googleによって「安全でない」と明確に表示されるようになるのはなんだか時代の流れを感じる。

やったのは主には
`Client ==HTTP=> S3`になっていたのを`Client ==HTTPS=> CloudFront ==HTTP=> S3`
にすること。
CloudFrontとACM (Amazon Certificate Manger)を今回新しく使ってやってみた。

CloudFrontでだいぶハマった。

Origin（配信コンテンツが置いてある場所）の指定方法がS3 OriginとCustom Originの2種類あって、
前者はS3の方でwebsite関連の設定を何もしない状態で配信の設定をする方法だが、
CloudFrontだと`/hogehoge/`に対して`/hogehoge/index.html`を返すことができない。
S3のレイヤーでやるとできるのに・・・。
後者はEC2やAWS外のリソースなどS3以外を配信する際の設定だが、
origin access identityを使ってS3でCloudFront以外からのリクエストを弾く設定ができない。
違いは[ここ](https://dev.classmethod.jp/cloud/aws/difference-between-cf-origin/)がわかりやすい。

結局S3への直接アクセスを弾くことを諦めて後者のCustom Originで設定した。
地味に指定URLも違っていてややこしい。
ただ結局理解してみるとシンプルなので、Terraformで書きながら模索していくのでも十分やり遂げられた。

あと注意としてはCloudFrontにはregionの区別がないためか
ap-northeast-\*でなくus-east-1で証明書を発行する必要があることぐらい。
ACMの証明書は自動更新なので、Let's Encryptみたいに自分でcron設定して気づいたらanacronがLockされてて止まってて・・・という事故も起きない。
意外とTerraformだけでも証明書の取得と設定ができるのもよい。

HTTP/2対応が自動でされるのも地味に嬉しい。
前に流行った[dev.io](dev.io)ほどではないが静的ファイルの配信だけだとやっぱりレスポンスが早くて良い。

Not Secureと表示されるようになる、の次はその文字が赤くなるらしい。
自分にとってこのSSL化みたいな作業は、高まった安全基準に合わせる作業だから世界のよりよくなっていく流れの一部になれて嫌いじゃない。
ただ地味に面倒でもあるので、これからどれぐらいSSL化が進んでいくか。
