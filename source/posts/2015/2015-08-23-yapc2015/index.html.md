---
title: YAPC::Asia Tokyo 2015にスポンサー側で参加してきました
# title: yapc2015
date: 2015-08-23 20:17 JST
tags: HTTP/2
---

初参加でYAPC::Asia Tokyoに参加してきました。

今年のYAPCは一応最後の開催ということなので寂しいが、
YAPCの名前はフリーらしいし10回も開催したので、きっと来年以降も誰かが開催してくれると思っています。

会場では主にのオリジナルタオルを配布しておりました。
場内で大量のタオルを身にまといながらチラシを配っていたのは私です。

https://twitter.com/uzulla/status/634970322920280065

だいたい受付に張っていたりしたのでセッションは2つ+LTのみ聞いた。あとでレポートを大量に読もうと思います。

ラリー・ウォール氏の講演も聞いた。
Perlをほぼほぼ触ったことがないからPerl6の良さはわかっていないが、
長らく待ち望まれていたものがついに出るということで結構場内は湧いていた気がする。

Jxckさんの「HTTP2時代のWeb」が大変面白かったのが印象的。

<iframe src="//www.slideshare.net/slideshow/embed_code/key/GiEBiNl1oDDHKz" width="425" height="355" frameborder="0" marginwidth="0" marginheight="0" scrolling="no" style="border:1px solid #CCC; border-width:1px; margin-bottom:5px; max-width: 100%;" allowfullscreen> </iframe> <div style="margin-bottom:5px"> <strong> <a href="//www.slideshare.net/Jxck/http2-web-web-over-http2-51943080" title="HTTP2 時代の Web - web over http2" target="_blank">HTTP2 時代の Web - web over http2</a> </strong> from <strong><a href="//www.slideshare.net/Jxck" target="_blank">Jxck :)</a></strong> </div>

今はHTTP2がRFCになり、策定はほぼ終了して使うことを考えるフェーズであること。
Webの高速化のためにはラウンドトリップの回数を減らすことが普通だが、
HTTP1.1だとCSS SpriteやCDN化など泥臭くてスマートじゃない方法で実現することになる。
HTTP2だとドメインあたりのコネクション数6の制限が実質無くなって、
一つのTCPコネクションで複数のリソースを取得できるようになるので、ユーザー体感速度がぐっと上がる。

基本的にHTTP2はいいことばかり。
ただHTTP2が使われるようになってもHTTP1.1は使えるので、
必要かどうかを判断して移行していけばいい。
「導入しちゃえ！」っていうのはわりとありな気がしているし、
HTTPは深く知らなくても知らないうちに使っているという状態であるべきなきもするが、
まだまだノウハウや道具が少ない現状だし、スパッと導入する前に必要性をきちっと見たほうがいいですね。

Nginxが今年の終わりにHTTP2をサポートするかも、と言っているので、
サービスで使いはじめるのは早くても来年頭からかなあと。
既にパッチはあって試せる材料は整っているので触ってみることはもう出来る。
Apacheさんはいつごろに実装してくれるだろうか。
https://www.nginx.com/blog/how-nginx-plans-to-support-http2/
