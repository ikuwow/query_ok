---

title: ツイートまとめ 20191005~20191011
date: 2019-10-12 15:15 JST
tags: Weekly

---

https://twitter.com/ikuwow/status/1180319750519312384

これは多分、Railsというよりクオリティ低めの「Railsでこういうことやってみました！」記事が検索妨害になっているのを辛く感じていましたね。

https://twitter.com/ikuwow/status/1180755792925839361


https://twitter.com/ikuwow/status/1180760527737217024

https://twitter.com/ikuwow/status/1180766266606252032

https://twitter.com/ikuwow/status/1180767445570637825

mini-css-extract-pluginを使うconfigとそうでないconfigで分けたかったのでした。
critical resourceはMiddlemanでinlineにテンプレートに入れたいので、それを.cssで履かせて、他は普通にwebpackで読ませたいなと。
Site Speed Insightで100点を目指す活動の一環。
結局、Webpack部分（上のこと）はできたとしても、Middlemanのexternal\_pipelineでwebpackをinvokeしてその結果のcssをinlineに読ませるというのが結局ダーティーハック以外なさそうだった。
価値も小さいしね。

https://twitter.com/ikuwow/status/1182578894131478528

同じ構成をポンポン複数立てては壊すことを繰り返しているとクラウド時代とInfrastructure as Codeに対する感謝の気持ちが大きくなりますね。
