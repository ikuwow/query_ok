---
#  title: everyone-in-the-project
title: みんなフロント触れるしSQL叩けるチームっていいなと思った話
date: 2015-12-06 17:20 JST
tags: teratail
published: false
---

（この記事は[teratailアドベントカレンダー](http://www.adventar.org/calendars/907#list-2015-12-04)の4日目です。投稿遅れてごめんなさい。）

こんにちは。今回はteratailアドベントカレンダーにのせる記事ということで、
いま私のいるteratail開発チームの中の話とかを少ししたいと思います。

現在teratailに関わっている人間は11人いて、エンジニアやデザイナーなどの他に、
プロデューサー、ディレクター、広報なんかもいたりする。

エンジニアは自分も含めて4人いて、
みんなフロントエンドもバックエンドもインフラもだいたい触れる。

デザイナーはみんなPhotoshopからHTML、CSSからJavaScriptやjQueryまで、
どれも特に不自由なく触れる。

エンジニア以外もだいたい皆プログラミングというものには浅くない経験がある。
ディレクターは以前コードを書いていたし、
プロデューサーはSQLやHiveSQLを叩いてログからガシガシデータを取り出して分析している。

特に元営業だったのがいまや最近触り始めたGo言語で簡単なもの作ってLTしちゃったりする。

UXデザイナーやディレクターもSQLをバシバシ叩いて施策の根拠を出したりしている。

自分はこのチーム、すごくいいチームだなと思いながら毎日仕事をしている。

チームについて簡単に紹介しながら、

フロント触れるし

エンジニア向けサービスを作るにあたって、
理想となる3つの段階という仮説を思いついたので勝手にまとめてみることにした。

いいなと思う理想的な姿が思い浮かんだので

* みんながHTMLとかCSSのちょっとしたことならできるチーム
* みんながSQL叩けるチーム
* みんながgit使えるチーム

暗黙の了解でなんとかいけちゃったりする。

## みんながHTMLとかCSSのちょっとしたことならできるチーム

Webの技術の領域で、一番入りやすいところがHTMLとCSS。
最もはじめに勉強\[する,したくなる,してほしい\]ところがこれ。

ブラウザの「要素の検証」を日常的に触り、
コンバージョン計測用のタグが入っているかどうかの確認ができたりする。

単純にWeb技術の基本として、知っておいてもらいたいというところ。
また全くプログラミングとかをしたことがない人にとっては、
書いてそれをブラウザで開くと書いたように表示されることに感動を覚えてくれたりする。

以前社内の営業さんたちに向けて勉強会をしたとき
「なるほど、これならエンジニアって無限にディスプレイほしいですよね」
という言葉をもらって、ひとつ通じ合えた感じがした。

## みんながSQL叩けるチーム

SQLというのは、多くのWebアプリケーションで使うデータを扱うための道具。
これを扱えるようになることはサービスが持っている情報をみることができるということ。

またデータの取り方がわからないと質問を受けた時、
そこがDBだけでデータが完結せず、
整合性をコードのロジックや定数で保っている部分だったりして、非常に恥ずかしい気持ちになる。
負債となっている部分をたまに指摘されて刺激受ける。

作った人やレビューした人以外に見てもらえるのはよいこと。

重いクエリ叩いて落ちたなんていうことも経験してもらえると、
パフォーマンスに対する意識が若干生まれてきてくれると嬉しい。

## みんながgitやGitHubが使えるチーム

gitはデファクトスタンダード。
ソースコードの変更をどのように扱っているのかをわかるようになる。

エンジニア

これができると、本当にもうコードを触ってくれる。

「ちょっと告知文言間違ってたから直しておいた」
「CSSスプライト1pxずれてたから直した」

GitHubのactivityから開発がどれぐらい進んでいるかの雰囲気がわかるし、
そこでどんなコミュニケーションがされているかも見られる。

またGitHubの文化から、

* issueに登録してもらえる
* issueで簡単に議論してもらえる
* プルリク送ってくれる

プルリクの仕組みがわかっていれば、あとは書いてもらえばいいだけ。
よかったらそのままマージボタンぽちっでマージされるし、ダメならdeclineになるだけ。
GitLabとかだとreporter権限というまさに適任なものがある。

コード書く人だけが見ているよりも、基本書かない人もちょくちょく見ているとなると
書く側も緊張感が湧く。

## 終わりに

ここまで完全にエンジニア目線から本当に好き勝手なことを言っていきました。
全部に共通して言えるのは、
お願いするコミュニケーションがいらないからスピードが上がること、
みんなのスキルの共通部分を大きくすることで話していて通じ合いやすくなること。

エンジニアの自分は教える義務感を持っている。

teratailというまさにITエンジニアのためにあるというサービスの性質もあって、
うちのチームはよい状態にあると思っています。

技術より

フォトショで画像中の文字消すとかもできない自分を改善すべく、
こんどデザイナーに簡単な使い方を教えてもらおうと思っています。

## 参考

この辺の記事をみながら書いていました。この記事よりとてもよくまとまっているのでぜひご覧ください。

理想的なサイクルである「責任範囲の越境」「共有」「学習」がある。

同じチームなのにデータを共有しないなんてアホらしい。
分析用のDBを用意するなんて、リアルタイム性を考慮しなければ大した手間ではない場合が多いと思う。
メルマガのテスト配信も全員で送る。

自分はカスタマーサポートもメルマガ運用もやっていたりするし。

> [営業さんまで、社員全員がSQLを使う 「越境型組織」 ができるまでの3+1のポイント | リブセンス](http://www.slideshare.net/livesense/150225-sql-foreveryone-45695818)
>
> [「全員がコードを書ける組織づくりをする」MAISIN&CO.が語る企業文化とプロダクト開発。 | TechStars Blog](https://techstars.jp/blog/maisin-int1/)
