---

title: ツイートまとめ 20190914~20190920
date: 2019-09-21 13:52 JST
tags: Weekly

---

<blockquote class="twitter-tweet"><p lang="ja" dir="ltr">技術ブログをとにかく雑でも更新を進めるようにしたらお誘いメッセージが沢山来ましたね。ブログは大事。</p>&mdash; ikuwow (@ikuwow) <a href="https://twitter.com/ikuwow/status/1172707004285997056?ref_src=twsrc%5Etfw">September 14, 2019</a></blockquote>

もう少し何かまとまった話題を書かねばと思いつつ100000万年経った。
その仕事やアプリ特有のことを調べるので頭の調査容量がいっぱいになっている今日このごろ。
あと一通り学習すると全部自明でドキュメントが書いてあるから記事にことがなくなる病気もある。
（本当は記事することがないなんてことはないはずなのだが）

<blockquote class="twitter-tweet"><p lang="ja" dir="ltr">今年2回めのauthorized_keys吹き飛ばし</p>&mdash; ikuwow (@ikuwow) <a href="https://twitter.com/ikuwow/status/1174185388489007104?ref_src=twsrc%5Etfw">September 18, 2019</a></blockquote>

<blockquote class="twitter-tweet"><p lang="ja" dir="ltr">ec2のauthorized_keysを吹き飛ばしたらこれを思い出すんだぞ <a href="https://t.co/8EBjsgId1n">https://t.co/8EBjsgId1n</a></p>&mdash; ikuwow (@ikuwow) <a href="https://twitter.com/ikuwow/status/1174208747377496064?ref_src=twsrc%5Etfw">September 18, 2019</a></blockquote>

定期的にやってしまうので反省している。

<blockquote class="twitter-tweet"><p lang="ja" dir="ltr">僕は今までにコードを追加した行数よりも消した行数のほうが多いと思うんですが、コピペコード量産マンやnode_modulesコミットマンは追加した行数のほうが多いんでしょうか</p>&mdash; ikuwow (@ikuwow) <a href="https://twitter.com/ikuwow/status/1174910273301303298?ref_src=twsrc%5Etfw">September 20, 2019</a></blockquote>

`vendor/`、`node_modules`、`lib/` をごそっと消して数十万行消したということが何度もありましたね。

## terraform cloudにremote stateを移すためにorganizationの再作成をした話

<blockquote class="twitter-tweet"><p lang="en" dir="ltr">terraformのstateを<a href="https://t.co/88wMzoM2G0">https://t.co/88wMzoM2G0</a>にmigrateしようとしたらこれで詰むんですが・・・<br><br>Error: Error copying state from the previous &quot;s3&quot; backend to the newly configured<br>&quot;remote&quot; backend:<br> Error uploading state: resource not found</p>&mdash; ikuwow (@ikuwow) <a href="https://twitter.com/ikuwow/status/1173066791452467200?ref_src=twsrc%5Etfw">September 15, 2019</a></blockquote>

<blockquote class="twitter-tweet"><p lang="ja" dir="ltr">一度localに持ってきてからremoteにうつそうとするも失敗<br><br>Error: Error copying state from the previous &quot;local&quot; backend to the newly configured<br>&quot;remote&quot; backend:<br> Error uploading state: resource not found</p>&mdash; ikuwow (@ikuwow) <a href="https://twitter.com/ikuwow/status/1173070035880833024?ref_src=twsrc%5Etfw">September 15, 2019</a></blockquote>

<blockquote class="twitter-tweet"><p lang="ja" dir="ltr">stateのlockはかかるからcredentialが間違っているということはなさそう。</p>&mdash; ikuwow (@ikuwow) <a href="https://twitter.com/ikuwow/status/1173070245059149824?ref_src=twsrc%5Etfw">September 15, 2019</a></blockquote>

<blockquote class="twitter-tweet"><p lang="ja" dir="ltr">Terraform cloud、いつの間にかユーザー名と同じorganizationが作れるようになっておるな。（結局organizationから作り直している）</p>&mdash; ikuwow (@ikuwow) <a href="https://twitter.com/ikuwow/status/1173070841258496002?ref_src=twsrc%5Etfw">September 15, 2019</a></blockquote>

<blockquote class="twitter-tweet"><p lang="ja" dir="ltr">は〜〜〜〜んorganizationを作り直したらできた。まだfree remote stateがなかったころにfree tier endの状態が保たれていたからかな。</p>&mdash; ikuwow (@ikuwow) <a href="https://twitter.com/ikuwow/status/1173071748184457216?ref_src=twsrc%5Etfw">September 15, 2019</a></blockquote>

<blockquote class="twitter-tweet"><p lang="ja" dir="ltr">や〜〜〜っとbackendを<a href="https://t.co/88wMzoM2G0">https://t.co/88wMzoM2G0</a>に移せたぜ</p>&mdash; ikuwow (@ikuwow) <a href="https://twitter.com/ikuwow/status/1173075622576316416?ref_src=twsrc%5Etfw">September 15, 2019</a></blockquote>

前にまだfree remote stateが有効でなかったときに無料プランでpushしようとして弾かれていたので、プランにもろもろ変更があり無料で使えるようになった今もそのまま使えない状態のままだったのだろうと推測している。捨てられるorganizationでよかった。地味に `ikuwow` organizationが作れたのが嬉しい。
