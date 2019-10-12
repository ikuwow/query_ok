---

title: ツイートまとめ 20191005~20191011
date: 2019-10-12 15:15 JST
tags: Weekly

---

<blockquote class="twitter-tweet"><p lang="ja" dir="ltr">ルッビーオンレールズはやっぱり厳しさを感じるのじゃ</p>&mdash; ikuwow (@ikuwow) <a href="https://twitter.com/ikuwow/status/1180319750519312384?ref_src=twsrc%5Etfw">October 5, 2019</a></blockquote>

これは多分、Railsというよりクオリティ低めの「Railsでこういうことやってみました！」記事が検索妨害になっているのを辛く感じていましたね。

<blockquote class="twitter-tweet"><p lang="ja" dir="ltr">これやるとwebpack-mergeがうまくいかんのだよどうしよう <a href="https://t.co/jLRQ2scEzh">https://t.co/jLRQ2scEzh</a></p>&mdash; ikuwow (@ikuwow) <a href="https://twitter.com/ikuwow/status/1180755792925839361?ref_src=twsrc%5Etfw">October 6, 2019</a></blockquote>


<blockquote class="twitter-tweet"><p lang="ja" dir="ltr">普通にwebpack-mergeをうまく使えという話でしたね</p>&mdash; ikuwow (@ikuwow) <a href="https://twitter.com/ikuwow/status/1180760527737217024?ref_src=twsrc%5Etfw">October 6, 2019</a></blockquote>

<blockquote class="twitter-tweet"><p lang="ja" dir="ltr">ふーむ <a href="https://t.co/sLDwwQ4AWG">https://t.co/sLDwwQ4AWG</a></p>&mdash; ikuwow (@ikuwow) <a href="https://twitter.com/ikuwow/status/1180766266606252032?ref_src=twsrc%5Etfw">October 6, 2019</a></blockquote>

<blockquote class="twitter-tweet"><p lang="ja" dir="ltr">まあMiddlemanのexternal_pipelineが複数のsourceを受け付けてくれるなんてことはなかった</p>&mdash; ikuwow (@ikuwow) <a href="https://twitter.com/ikuwow/status/1180767445570637825?ref_src=twsrc%5Etfw">October 6, 2019</a></blockquote>

mini-css-extract-pluginを使うconfigとそうでないconfigで分けたかったのでした。
critical resourceはMiddlemanでinlineにテンプレートに入れたいので、それを.cssで履かせて、他は普通にwebpackで読ませたいなと。
Site Speed Insightで100点を目指す活動の一環。
結局、Webpack部分（上のこと）はできたとしても、Middlemanのexternal\_pipelineでwebpackをinvokeしてその結果のcssをinlineに読ませるというのが結局ダーティーハック以外なさそうだった。
価値も小さいしね。

<blockquote class="twitter-tweet"><p lang="ja" dir="ltr">今日もterraform destroy</p>&mdash; ikuwow (@ikuwow) <a href="https://twitter.com/ikuwow/status/1182578894131478528?ref_src=twsrc%5Etfw">October 11, 2019</a></blockquote>

同じ構成をポンポン複数立てては壊すことを繰り返しているとクラウド時代とInfrastructure as Codeに対する感謝の気持ちが大きくなりますね。
