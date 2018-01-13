---
# title: site-reliability-engineering
title: 「SRE サイトリライアビリティエンジニアリング」を読んだ
date: 2018-01-13 17:46 JST
tags:
---

年始に読んだのでメモ。

<div class="babylink-box" style="overflow: hidden; font-size: small; zoom: 1; margin: 15px 0; text-align: left;"><div class="babylink-image" style="float: left; margin: 0px 15px 10px 0px; width: 75px; height: 75px; text-align: center;"><a href="http://www.amazon.co.jp/exec/obidos/ASIN/4873117917/ikuwow-22/" rel="nofollow" target="_blank"><img style="border-top: medium none; border-right: medium none; border-bottom: medium none; border-left: medium none;" src="https://images-fe.ssl-images-amazon.com/images/I/51Ybz%2B6kIsL._SL75_.jpg" width="59" height="75" /></a></div><div class="babylink-info" style="overflow: hidden; zoom: 1; line-height: 120%;"><div class="babylink-title" style="margin-bottom: 2px; line-height: 120%;"><a href="http://www.amazon.co.jp/exec/obidos/ASIN/4873117917/ikuwow-22/" rel="nofollow" target="_blank">SRE サイトリライアビリティエンジニアリング ―Googleの信頼性を支えるエンジニアリングチーム</a></div><div class="babylink-manufacturer" style="margin-bottom: 5px;">オライリージャパン</div></div><div class="booklink-footer" style="clear: left"></div></div>

Googleの提唱するSREという概念（役割？）について説明された本。
SREがどういう役割をになっていて、どういう考えが必要か、具体的に何をするのかが書いてある。
主にGoogleの内部で実際に行われている大規模なサービスを運用する手法や、
Googleでのケーススタディが載っている。
グーグルグーグルしてるが世界一複雑で巨大なサービス群を抱えているGoogleなので特に違和感はない。

SRE (Site Reliability Engineer)とは、
コンピュータサイエンスとエンジニアリングの原則を、概して大規模な分散型のコンピュータシステムに適用して、
スケーラビリティ、信頼性、効率性を向上させていくエンジニア。
ざっくりしているが著者たちもはっきり言葉で表現できてはいないらしい。

いわゆるシスアドの仕事もするが、
オンコール対応もするが、日常運用は業務時間の50%を超えてはならないという決まりがあり、
コーディングスキルを使う開発を最低50%行う。
ただの何でも屋でもなくて、きちんとSLAの上でSLOを設定して積極的に改善を図っていく。

SREは能力に対する要件が非常に高い。
LRE (Launch Coordination Engineers、新しいサービスのローンチをサポートするSREの一部の人々）
なんてトレーニングに半年かかるとのこと。

SRE (Site Reliability Engineering)はDevOpsという言葉とも少し似ているが、より大きい概念だと思われる。

厚い本だが、ひとまず2部の「原則」は誰にでもオススメ。SREが何をするかがざっくりわかる。

SREという言葉が知られるようになってから、いろんな会社でのSREという肩書や取り組みが聞かれるようになったが、
実際にこの本に書いてあるぐらいのことを徹底的に取り組めているところはあるのだろうか？たぶんない。

単なる運用をしている作業を超えてこういうことを少しずつ取り組み始めるとよいのだなという
一つのガイドラインにはなりそう。
