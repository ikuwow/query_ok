---
title: このブログをHTTPS対応しました
# title: https-support
date: 2018-02-11 20:27 JST
tags:
---


HTTPS対応しました。ついでにHTTP/2対応もされました。

こういうニュースがあって、そろそろやるこかと


やったことは、これぐらい

ACMで取得
`Client ==HTTP=> S3`になっていたのを`Client ==HTTPS=> CloudFront ==HTTP=> S3`


感想

cloudfrontにはoriginの指定方法がS3 OriginとCustom Originの2種類ある。

なので、本来やりたかったことができなかった。
違いはこちらがわかりやすい。

あとCloudFrontにはregionの区別がない（デフォルトで全リージョンに配信）なので、
ap-northeast-\*でなくus-east-1で証明書を発行することぐらい。

ここをみるとわかりやすい。

なので実は
