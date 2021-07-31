---

# title: bookmeter-exporter-and-booklog
title: 読書メーターをエクスポートするツールを作ってブクログへ移行した
date: 2021-07-31 17:20 JST
tags: 本,ブクログ,読書メーター,作った
thumbnail:
---

読書メーターの「読んだ本」の一覧をCSVで出力するCLIツールを作った。

[bookmeter\_exporter](https://ikuwow.github.io/bookmeter_exporter/)

一応gemにもした。

[bookmeter\_exporter | RubyGems.org | your community gem host](https://rubygems.org/gems/bookmeter_exporter)

Chrome Driverで読書メーターにログインしてゴリゴリ情報を取ってくる君。
`gem install bookmeter_exporter` でどうぞ。

## なんで作ったの

読書メーターの中身をブクログに移行したいと思ったのがきっかけ。
ブクログはフォーマット整えればCSVでインポートが可能だったが、
読書メーターさんはAPIやエクスポート機能がない。

（提携サービス向けAPIはあるみたい）  
https://blog.bookmeter.com/post/172130570662/提携サービス向け機能レビューapiにつきまして

さすがに501件程度を画面ポチポチコピペするのは大変なのでインターネットの海を漂っていると、
過去にもいろんな人が読書メーターのデータをスクレイピングで取得しようとしている形跡があった。
だがどれも5,6年前に作られたものなので当然そのままは動かず。

それらのほとんどは単にレスポンス内容のHTMLをnokogiriとかBeautifulSoupでparseして取得するもので、
ちょっと治して使うにもこれだけ時代が変わっているので読書メーターがjsを実行せずに動くわけはなく。

というわけで一番素直に、Seleniumゴリゴリしていく奴を自分で作ることにしたのだった。

一応gemにしたがテストもろくに書いてないしテストしづらいので要改善。
とりあえず自分向けにエクスポートは出来るようになった状態で公開した。
あんまりしっかりメンテしていく気持ちはありませんが使いたい方はどうぞ。

読書メーターさん早くエクスポート機能かAPIを実装してくれ〜〜。

## なんでブクログへ移行するの

読書メーターは本の情報やレビューを非公開にする機能がなく、ブクログにはそれがあるというのがきっかけであり一番の理由。

今の長い休みの間に鬼のように読書をしようと思ったが、
ちょうど次に読みたいと思っている本があんまり人には知られたくない本で、
読書メーターに書くと公開されちゃうしどうしようかと思っていたのだった。

そして調べていて、読書メーターは読んだ本が似てる人を見つけるなどコミュニティ的な要素が強い一方、
ブクログは読書を記録して自分だけの本棚を作るという点を第一にしていそうだなということがわかった。
自分は後者の方が目的にあっていそう。
読書メーターよりユーザー数も多くて今後に期待が持てるので、完全移行することにした。
アマゾンへのリンクにAssociate IDが付けられるところなんかも地味にうれしい。

とりあえず雑にカテゴリを分けずにぶち込んでいるので、本棚の整理しながらこれからの読書ログを積み上げていこうと思う。

ただブクログでユーザID `ikuwow` が取れなかったので別IDを取得・・・。
過去の自分がikuwowで登録した後に退会したんだと思う。
退会者のIDが使えないというサービスも多いから使わなくなったアカウントはあんまり消さない方がイイネ。

## 作ったときのメモ

gemという形で公開するのが初めてだったのでメモ。

gem的にはこちらを見ればだいたいわかる。

[Make your own gem - RubyGems Guides](https://guides.rubygems.org/make-your-own-gem/)

作るときに見ると良いのはこちらのbundlerのほう。とりあえず作りたくなったら `bundle gem` するといろいろ整えてくれるので便利。

[Bundler: How to create a Ruby gem with Bundler](https://bundler.io/guides/creating_gem.html)


RubyでCLIを作るなら[Thor](http://whatisthor.com)が鉄板。引数やオプションがいい感じに使える。

CLIのテストは[Aruba](https://github.com/cucumber/aruba)がよさそう。これはRubyに限らずCLIに対してなら使える。
そもそもテスト書いてないので使ってないけれども・・・。
某ネットワーク機器の会社名と同じでググラビリティが低い。

.gemspecに必要なことを書いたら `rake release` で初回リリース。gitにタグも打ってpushもしてくれる。
その後README.mdに[GitHub Actionsのバッジ](https://docs.github.com/ja/actions/managing-workflow-runs/adding-a-workflow-status-badge)とgemのバッジを付けて、repoのGitHub Pagesを有効化すればそれっぽくなる。

何か更新したら `lib/bookmeter_exporter/version.rb` のバージョン番号を更新して、`bundle exec rake release` すればそのrevisionにtagが打たれてpushされて公開が完了する。あとは必要ならGitHub上でReleaseを作ったりchangelogを書き足したりする手順を入れ込んだらよい。
