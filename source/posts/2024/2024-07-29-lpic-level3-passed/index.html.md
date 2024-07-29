---
# title: lpic-level3-passed
title: LPIC-3 305に合格した
date: 2024-07-29 17:44 JST
tags:
thumbnail:

---

LPIC-3 305「仮想化とコンテナ化」に合格した。

まともに勉強した日数はなんと直前の4日間！　試験資格の切れる当日に受験してギリギリ滑り込んだ形。

https://x.com/ikuwow/status/1816033410789568686

590点で合格。正答率は以下の通り。

* Full Virtualization 正答率75%
* Container Virtualization 正答率72%
* VM Deployment and Provisioning 正答率90%

65-70%の得点で合格らしいがなんと8割近く得点できしっかりと合格ラインに乗れた。
ずっと取ろう取ろうと思っていたLevel3を、しかもかなりの短期間に詰め込んで勉強したのでかなり達成感がある。

## 経緯

LPIC Level 2を取得したのが2018年の夏（参考: [LPIC level 2に2週間で合格した](/entry/lpic-level2-passed/)）。

優位性の期限が5年間なので、2023年の夏に優位性の期限が切れる。
LPIC-3はLPIC-2がないと認定されない（受験はできるがLPIC-2の取得まで認定が保留にされる）ので、
期限が切れる前に同じLPIC 201/202の試験に合格するか、上位のLevel3の試験に合格しなければならない。

ただその時は[LPIのメンバーシップ](https://www.lpi.org/ja/member/)に申し込んだらなんと優位性の期限がさらに1年延長されることがわかり、
申し込んでお金の力で先延ばしにしたのであった。

そんなこんなで1年が経過し2024/07/24の期限が近づいてきて、
忙しいしこのまま資格を切らしても特に問題はなかったが、
バウチャーも既に買っていたし、なによりなんだか悔しいしこのまま切らすのは勿体無いと突然思い立ち、5日後の夕方に近くのテストセンターに申し込みをした。

LPIC-3はいくつか試験項目があるが、今までの経験や知識が生かせて一番勉強時間が少なくて済みそうな305を選んだ。

* 試験概要 https://www.lpi.org/ja/our-certifications/lpic-3-305-overview/
* 試験範囲 https://www.lpi.org/ja/exam-305-objectives/
  * 課題351: Full Virtualization (完全仮想化)
  * 課題352: コンテナ仮想化
  * 課題353: VMのデプロイとプロビジョニング

AWSやKubernetesを触って本番サービスを運用してきた経験がある人なら結構親しみのある単語が並んでいると思う。
Dockerの比重は大きいがLXCもやるし、XenやKVM/QEMUを使った完全仮想化、Libvirtの操作なども出題される。
当然それぞれ使えるだけではなく、仕組みや設定方法などもある程度知っておく必要がある。

試験概要はこの動画がわかりやすい。

<iframe width="560" height="315" src="https://www.youtube.com/embed/l0z0LJMo3d8?si=j61gNwI4yGcQqY0H" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" referrerpolicy="strict-origin-when-cross-origin" allowfullscreen></iframe>

## どんな勉強をしたか

LPIC 305はまだ公式のテキストが出ていない（少なくとも日本語では）ので、ある程度試験範囲が被っている旧バージョンの304試験の黒本を使うことにした。
（実は2023年の時点で購入していた）

<!-- markdownlint-disable-next-line no-alt-text -->
<div class="booklog_html"><table><tr><td class="booklog_html_image"><a href="https://www.amazon.co.jp/dp/4844380540?tag=hashiki88-22&linkCode=ogi&th=1&psc=1" target="_blank"><img src="https://m.media-amazon.com/images/I/51nloW4BtnL._SL160_.jpg" width="106" height="150" style="border:0;border-radius:0;" /></a></td><td class="booklog_html_info" style="padding-left:20px;"><div class="booklog_html_title" style="margin-bottom:10px;font-size:14px;font-weight:bold;"><a href="https://www.amazon.co.jp/dp/4844380540?tag=hashiki88-22&linkCode=ogi&th=1&psc=1" target="_blank">徹底攻略 LPIC Level3 304 教科書+問題集[Version 2.0]対応</a></div><div style="margin-bottom:10px;"><div class="booklog_html_author" style="margin-bottom:15px;font-size:12px;;line-height:1.2em">著者 : <a href="https://booklog.jp/author/%E7%B1%B3%E5%B1%B1%E5%AD%A6" target="_blank">米山学</a></div><div class="booklog_html_manufacturer" style="margin-bottom:5px;font-size:12px;;line-height:1.2em">インプレス</div><div class="booklog_html_release" style="font-size:12px;;line-height:1.2em">発売日 : 2016-04-28</div></div><div class="booklog_html_link_amazon"><a href="https://booklog.jp/item/1/4844380540" style="font-size:12px;" target="_blank">ブクログでレビューを見る»</a></div></td></tr></table></div>

まず勉強を始める前の1日は心残りをなくして完全に集中できるようにした。洗濯とか皿洗いとか、睡眠負債の解消とか食べたいものを食べるとか。

そしてはじめにLPI日本支部のYouTubeチャネルが出している動画で概観を掴むことにした。以前やったセミナーの録画。

<iframe width="560" height="315" src="https://www.youtube.com/embed/ygVdBQGfydo?si=S40qtbtRs6elGPWe" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" referrerpolicy="strict-origin-when-cross-origin" allowfullscreen></iframe>

出題される範囲の一部の本当に触りだけで、概観もわかったかどうか微妙なところだったが、動画メディアというのは食事の合間に再生しておいたりできるので、脳をこの分野でいっぱいにしておくにはちょうどよい。3回ぐらい見たと思う。

351の完全仮想化は主に黒本で勉強した。
テキスト読んで、問題解いて、派生して起きた疑問を全部調べて手元で試して・・・の繰り返し。

問題は352コンテナ仮想化から。テキストという明確な道標がない。
概念的なところは試験要項の項目から辿って調べて、を繰り返した。黒本にも多少載っていることがあった。
LXCは[公式のチュートリアル](https://linuxcontainers.org/lxc/getting-started/)を一通りこなした。
Dockerは問題解きながらやることにした。

このあたりからChatGPTが役に立ち始めた。
試験範囲を読ませて問題出してというと問題出してくれるし、解説もしてくれる。
質はどうあれ問いを投げかけてくれる存在になってくれたのがありがたかったし、裏取りも調べたり手を動かしたりする練習になった。

https://x.com/ikuwow/status/1815385589190926691

303 VMのデプロイとプロビジョニングは試験要項にある項目それぞれを調べて、チュートリアルをやるなどした。
PackerがHCLで書けるようになっていたことをこの時知った。

問題集を求めて色々探し回った結果[touch-q](https://touch-q.info)のLPIC 305問題集を買った。
一見怪しいサイトに見えるが、PayPalでの課金後にすぐに人の書いたメールで連絡が来て使えるようになった。

問題数はあまり多くないし復習に便利な仕組みがあるわけではないが、黒本に乗っている問題と同一のものや試験にそのまま出た問題など、質はよいものが揃っているように感じた。

当日は朝から試験会場近くのコワーキングスペースで仕事をして、試験前になってモンスターエナジーを飲みながら黒本の巻末の問題集を解き直したりノートを見直したりした。

試験時間90分のうち初めの30分で60問全問を一旦解き終え、40問は正解の自信がある状態からどれだけさらに点を拾えるかという感じで全力を出した。

## 感想

まずとにかくほっとした。長い間切り捨てられておらず、受からねばと心のどこかに引っかかっていたものが取れた感覚。
クラウドをよく使う身としては305を選んだのは大正解だった。

合格した後にexpire当日でもちゃんと認定が通るのか怖くなっていたけど無事認定された。

https://x.com/ikuwow/status/1817016763344912868

IT系の資格なんてという話もあるが、自分にとっては勉強のわかりやすい目標になるし、勉強の材料としては手頃。
ついでに試験の権威を借りて自分の能力を証明できるならお得（知らんけど）。

そしてこのタイプの試験はあんまり試験勉強をするようなものではないと思った。

例えば「`docker run`時に`--name`を指定しない場合にデフォルトでつけられる名前の可能性としてありうるものは以下のうちどれ？」のような、重箱の隅を突くような問題が出てくる。

この知識自体は本質ではないし、試せばすぐにわかるので記憶しておく意義は薄い。
これを知っていて欲しいというよりも、「業務経験あるならこれわかるよね？」というタイプの問いなのだと思う。
こういう問題が解けるようになるための努力はあんまり意味がなくて、
ひたすら暗記なんかやってられないし、それでpassしてもすぐ忘れてあまり意味がない。

業務経験のある分野で、最大一ヶ月ぐらいゆるっと頭の中を体系化したり知識の穴を埋めるような勉強をして合格、というのが理想的かしら。

久しぶりの体系的な学びは世界の見え方が変わってやはりいいですね。

さらに改めて思ったこと。
勉強やトレーニングのコツは、やはり生活の中で頭の中をその分野でいっぱいにしておくこと。

アテンションを取られることが多いこの世の中なので、なるべくSNSやニュース等の雑多な情報を取り入れずに、
起きて寝るまで一日中そのことを考え続けていられることが大事なんかな。

306の高可用性とストレージクラスタも面白そうだと思ったけど当分はもういいかな。
