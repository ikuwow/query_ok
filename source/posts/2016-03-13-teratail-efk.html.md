---
title: 「teratailの解析基盤をEFKで作っていろいろ楽しい話」というLTをしました
# title: teratail-efk
date: 2016-03-13 17:33 JST
tags: Elasticsearch, Fluentd, Kibana, LT
---

[ゆとり世代エンジニア交流会](http://connpass.com/event/26812/)で
「teratailの解析基盤をEFKで作っていろいろ楽しい話」というLTをしました。

<script async class="speakerdeck-embed" data-id="40f87cd302aa477e884918f3cea5efb4" data-ratio="1.33333333333333" src="//speakerdeck.com/assets/embed.js"></script>

teratailでElasticsearch + Fluentd + Kibanaの構成を作って、ログを見始めたら結構いろいろはかどっているという話。

この構成はやっぱり、Kibanaの簡単で超かっこいい可視化が一番注目すべきところ。
いままでHiveでクエリを書いてゴリゴリ20秒ぐらい回して計算していたのが、
こちらだと数秒でしかも可視化までできる。

Fluentdは導入簡単だし設定はシンプルだし、Elasticsearchも基本的にスキーマレスだし、
いったん作っておけばあとはひたすらログを流していけばいい。

ApacheやMySQLのログ、CSVやLTSVなどのシンプルな形式であればテンプレートが用意されているので、
Fluentdでのパースも容易。素晴らしいですね。

今後はユーザーの行動ログだけでなくサーバサイドのレスポンスタイムやslow queryなどの
情報も可視化してみたい。

Elasticsearchのサブスクリプションを使ってBeatsを使い、
各サーバーの内部状態を可視化するのもよい。
夢が広がる。
