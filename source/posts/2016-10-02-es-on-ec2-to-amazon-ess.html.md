---
# title: es-on-ec2-to-amazon-ess
title: 「Elasticsearch on EC2からAmazon Elasticsearch Serviceに 移行してだいぶ楽になった話」というLTをしました
date: 2016-10-02 12:58 JST
tags: Elasticsearch, Fluentd, Kibana, LT
---

2016/9/15に開催したteratail Meetup「集まっtail」にて
「Elasticsearch on EC2からAmazon Elasticsearch Serviceに 移行してだいぶ楽になった話」
というLTをしました。

<script async class="speakerdeck-embed" data-id="099c9c8cd85f4cca92c61ea001bb9928" data-ratio="1.33333333333333" src="//speakerdeck.com/assets/embed.js"></script>

Kibanaで気楽にログを見るためにEC2でぬるっとEFK(Elasticsearch, Fluentd, Kibana)の構成を作ったけど
管理が面倒になってこっちに移行した話。

すべての発端はAmazon Elasticsearch ServiceでElasticsearchバージョン2系（2.3）がサポートされたこと。
本当ははじめからこれにしたかったけど、2系が使えないというのだけがネックで使っていなかった。

> Amazon Elasticsearch Service で Elasticsearch 2.3 のサポートを開始
> https://aws.amazon.com/jp/about-aws/whats-new/2016/07/amazon-elasticsearch-service-now-supports-elasticsearch-2-3/

Elasticsearchはクラスタを構成して動き出し始めるのは簡単だけど、
基本的にCPUもMemoryもStorageも全部使うヘビーなやつなので、
軽い気持ちでスケールアウトしようとノード数を3から4に増やすと死んだりする。
Elasticsearch Serviceの動作を見ていると一度ノード数を2倍に増やしてから所望の
サイズに縮小していて、やっぱり結構気を使うやつなんだなあと思った。

ちゃんと張り付いている人をつけないようにするなら、
こういうマネージドサービスははじめから極的に利用しないとダメですね。
