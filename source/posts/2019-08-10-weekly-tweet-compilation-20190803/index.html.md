---

title: ツイートまとめ 20190803~20190809
date: 2019-08-10 15:29 JST
tags: Weekly

---

<blockquote class="twitter-tweet"><p lang="ja" dir="ltr">yarnとnpm、最近はnpmが怪しいのでyarnのほうがいいんですかね。</p>&mdash; 納税成功 (@ikuwow) <a href="https://twitter.com/ikuwow/status/1157467503192182784?ref_src=twsrc%5Etfw">August 3, 2019</a></blockquote>

npmが怪しいというのはこのあたりの話でした。

<blockquote class="twitter-tweet"><p lang="ja" dir="ltr">npmが突如更新されなくなる覚悟をしといたほうがいいかも。運営母体がやばい状況。オープンソースでスタートしたが資金が厳しくVCのお金を入れ法人化。ここ1年はCTOが追い出され、新しく入ったCTOが昔の仲間を連れてきて元々いた社員と合わなくて揉め、昔からいた社員が大量離職。突然の解雇も行われた</p>&mdash; 山浦清透@技術をわかりやすく (@kiyotoyamaura) <a href="https://twitter.com/kiyotoyamaura/status/1151297024177901569?ref_src=twsrc%5Etfw">July 17, 2019</a></blockquote>

npm registryは大変そうだ・・・。
https://yosuke-furukawa.hatenablog.com/entry/2019/06/17/191720

<blockquote class="twitter-tweet"><p lang="ja" dir="ltr">これはハマる <a href="https://t.co/nNoNif5tZS">https://t.co/nNoNif5tZS</a></p>&mdash; 納税成功 (@ikuwow) <a href="https://twitter.com/ikuwow/status/1157479638295183360?ref_src=twsrc%5Etfw">August 3, 2019</a></blockquote>

CircleCIで `bundle install` したパッケージがキャッシュされないと思ったら、.bundle/configが効いてなかったという話だった。
`bundle install --path foobar` というオプションつけたくなかったの・・・。

<blockquote class="twitter-tweet"><p lang="ja" dir="ltr">OSSに自分がcontributeしたPRやissueをtwitterにshareしたいんですがなにかいい方法ないですかね</p>&mdash; 納税成功 (@ikuwow) <a href="https://twitter.com/ikuwow/status/1157506754009108481?ref_src=twsrc%5Etfw">August 3, 2019</a></blockquote>

自分のpublicなcontributionをTwitterに全てシェアして自尊心高める方法を探していた。IFTTTだとprivateなものもshareされるので事故りかけた。
Zapierだとcommitとissueしかなくて、それぞれrepo指定をするタイプのもので、自分のcontributionという切り口では絞れなかった。
どなたか知っていたら教えて下さいmm

<blockquote class="twitter-tweet"><p lang="ja" dir="ltr">よいこのみんなはterraformのstateは初めから環境ごとに分けようね！お兄さんとの約束だぞ！</p>&mdash; 納税成功 (@ikuwow) <a href="https://twitter.com/ikuwow/status/1157852835591024640?ref_src=twsrc%5Etfw">August 4, 2019</a></blockquote>

staging/productionがまぜこぜになったネットワークだったので、そのまま同じstateにして管理していたプロジェクトがあるんですが、
共通するものをmoduleに切り出すと同時に反映するしかなくなり実質運用できなくなるという罠に気づいたのだった。

<blockquote class="twitter-tweet"><p lang="ja" dir="ltr">BAD_REQUEST = 400 をめぐる問い。マジックナンバーは可読性を下げるのか？ / bad request is 400 <a href="https://t.co/tATwnCevmZ">https://t.co/tATwnCevmZ</a></p>&mdash; 納税成功 (@ikuwow) <a href="https://twitter.com/ikuwow/status/1158329210881994753?ref_src=twsrc%5Etfw">August 5, 2019</a></blockquote>

近くで話題になってた。スライドに有るように以下の3点は考える視点として思い出せるとよさそう。
https://speakerdeck.com/qsona/bad-request-is-400?slide=19

* 何に対する数値だかがわからないよ
* 数値自体の根拠（妥当性）がわからないよ
* 共通化されてないよ

<blockquote class="twitter-tweet"><p lang="ja" dir="ltr">dein.nvimでいつの間にかfile_recが使えなくなっていたのでfile/recを使うようにした <a href="https://t.co/senudHEEEj">https://t.co/senudHEEEj</a></p>&mdash; 納税成功 (@ikuwow) <a href="https://twitter.com/ikuwow/status/1158982807697235968?ref_src=twsrc%5Etfw">August 7, 2019</a></blockquote>