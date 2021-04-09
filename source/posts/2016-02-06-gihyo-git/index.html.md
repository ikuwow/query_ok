---
title: gihyo.jpに「gitの基礎を見直す」という記事を書きました
# title: gihyo-git
date: 2016-02-06 16:13 JST
tags: gihyo, git, 執筆
---

今月の記事はgit。

<blockquote class="twitter-tweet" data-cards="hidden" data-lang="ja"><p lang="ja" dir="ltr">聞いたら一生の宝，プログラミングの基礎の基礎 「第10回　gitの基礎を見直す」by <a href="https://twitter.com/ikuwow">@ikuwow</a> 公開 <a href="https://t.co/Dp8xHMJYV7">https://t.co/Dp8xHMJYV7</a></p>&mdash; gihyo.jp (@gihyojp) <a href="https://twitter.com/gihyojp/status/694023622076203008">2016, 2月 1</a></blockquote>

書いていて思ったのは、
やはり何をバージョン管理して何をしないのかをリポジトリ作成時やプロジェクト開始時に明確にしておくことがとても大事だなと。

gitに使い慣れていない人が`/vendor`ディレクトリを含むcommitをpushしてきて、
too many diffsだけならまだしも、
オンプレミスで入れているGitLabをぶっ壊してみんな死んだりするのは嫌ですよね。

iOSアプリを作っていた時は何をignoreしておくべきか全くわからなくて、
まとめて[Qiitaの記事](http://qiita.com/ikuwow/items/4fae81a099bf82f44749)にしたらけっこうストックやはてブついて、
結構迷っていた人もいたんだなあと意外に感じた思い出。

composer, bundler, npm, cocoapodsなどの.lockファイルも
バージョン管理するか迷ったことがあったけど、
今はよく見たらどのドキュメントもちゃんとversion controlに入れろと書いてあって、
もう常識として定着したのだろうか。

<blockquote class="twitter-tweet" data-lang="en"><p lang="ja" dir="ltr">composer, bundler, npm, cocoapodsなどの\*.lockファイルは.gitignoreしてる？</p>
&mdash; ゐくを (@ikuwow) <a href="https://twitter.com/ikuwow/status/695871999327928320">February 6, 2016</a></blockquote>