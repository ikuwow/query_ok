---
title: 書籍「ウェブオペレーション」のデータベース戦略の話が面白かった
# title: read-weboperation
date: 2016-10-16 18:28 JST
tags: 本
---

O'Reillyのウェブオペレーションという本を読んだ。

<!-- ウェブオペレーション -->
<div class="babylink-box" style="overflow: hidden; font-size: small; zoom: 1; margin: 15px 0; text-align: left;"><div class="babylink-image" style="float: left; margin: 0px 15px 10px 0px; width: 75px; height: 75px; text-align: center;"><a href="http://www.amazon.co.jp/exec/obidos/ASIN/4873114934/queryok-22/" rel="nofollow" target="_blank"><img style="border-top: medium none; border-right: medium none; border-bottom: medium none; border-left: medium none;" src="http://ecx.images-amazon.com/images/I/51-ThZ6FRfL._SL75_.jpg" width="59" height="75" /></a></div><div class="babylink-info" style="overflow: hidden; zoom: 1; line-height: 120%;"><div class="babylink-title" style="margin-bottom: 2px; line-height: 120%;"><a href="http://www.amazon.co.jp/exec/obidos/ASIN/4873114934/queryok-22/" rel="nofollow" target="_blank">ウェブオペレーション ―サイト運用管理の実践テクニック (THEORY/IN/PRACTICE)</a></div><div class="babylink-manufacturer" style="margin-bottom: 5px;">オライリージャパン</div></div><div class="booklink-footer" style="clear: left"></div></div>


サイト運用管理の実践テクニックということで、様々な人が書いた
ウェブサイトやアプリケーションの管理や運用で四苦八苦したコラム集のような本。
それぞれに教訓があってかなりいろんなものが得られる。

Webをやっている人だと一度は必ず考えたことがある部分が非常に多いので、
何かと響いて面白い。

その中でも12章の「ウェブにおけるリレーショナルデータベースの戦略と戦術」という章の
「ウェブデータベースの要件」に非常に役に立ちそうな情報があったのでまとめてみる。
Webサービスにおけるリレーショナルデータベースには何がなくてはならないかが書いてある章。

## ウェブデータベースの要件

### 1. 常時稼働

当然ではあるが24時間稼働していなければならない。
多くのWebアプリケーションがRDBに依存しているので、
「夜はおやすみ」が許される例外以外は常にリクエストを受け付けている必用がある。
データベースには常にアクセスがあるので、
メンテナンスや運用上必要な作業が難しい。

### 2. トランザクション処理

トランザクションと言っても`BEGIN;`から始まって`ROLLBACK;`か`COMMIT;`で終わるアレではなく、
単に「データの読み書き」のことを言っているらしい。
多くのアプリケーションは読み込み対書き込みが9:1など読み込み処理のほうが多い。


### 3. シンプルなデータ・シンプルなクエリ

Webアプリケーションではデータモデルが複雑ではないので、
シンプルであることが大切。
シンプルだからそれぞれの処理を内部で並列化するのは難しいが、
複数の処理を平行に行うことはできる。

### 4. 一貫性よりも可用性

RDBはデータ構造を厳密に保てる理論的な仕組みを持っているものの、
Webアプリケーションの多くに厳密な整合性は必要ないし、
それよりも使えない瞬間が発生することが問題である。

ここは今まで自分が整合性厨だったのでビビッときた。

### 5. 迅速な開発

Webアプリケーションは随時デプロイを行う。1日に何度も行うこともある。
それにともなってスキーマの変更が随時行われる。

### 6. オンラインデプロイ

5.と同じ理由で、変更があるたびにサービスが止まってしまっては困る。

### 7. 開発者によるビルド

データーベースの専門家でなくアプリケーションの開発者がデータベースを設計し、変更を加え、デプロイする。
**「これまでに恐ろしく優秀な開発者を何人も見てきたが、データベースをよく理解している人はほとんどいなかった」**
わかる。
どうしてもパフォーマンスのことが考えられてないお粗末な設計になることが多くなる。つらい。

この項目は必要なものというよりかは、どうしてもデータベースがわからない人がデータベースを触るという
辛い現実を認識する必要がある、ということだと思う。

---

この章は他にもデータベースのスケールの方法だったりがわかりやすく書いてある。
たまにみたい一冊として本棚に置いておく。

