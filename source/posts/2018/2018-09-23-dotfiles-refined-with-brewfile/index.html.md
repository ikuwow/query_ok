---
# title: dotfiles-refined-with-brewfile
title: dotfiles類をbrew bundleを使って整えるためにやったこと
date: 2018-09-23 13:36 JST
tags:
---

MacBook Proの`networksetup`が動かないという謎の不具合があったり、brew bundleの存在を今更知ったりしたので、
dotfiles類をリファクタしてMacをリストアしようと思い立ったのでやったりました。

> ikuwow/dotfiles  
> https://github.com/ikuwow/dotfiles/commit/36d80be49eaa7a224e595ae0b362091b88e0912f

自分史上最高にきれいなdotfilesになったと思います。

## dotfilesとは（おさらい）

.bash\_profileなどのdot付き（不可視）のファイルをrepoでバージョン管理して、
`~/.bash_profile` => `~/dotfiles/.bash_profile` のようにシンボリックリンクを貼って使えるようにする、という感じの仕組み。

設定をマシン間で共有でき、開発の基本となる環境の構築が一瞬で終わるようになる。
Macだとhomebrewなどで必要なパッケージを入れる処理を別途書いておくことも多い。

以下がわかりやすい。

> 最強の dotfiles 駆動開発と GitHub で管理する運用方法
> https://qiita.com/b4b4r07/items/b70178e021bef12cd4a2

## やったこと

### homebrew-bundleを使い始めた


> 📦 Bundler for non-Ruby dependencies from Homebrew  
> https://github.com/Homebrew/homebrew-bundle

Brewfileというファイルにつらつらと依存関係を書いて
`brew bundle` すると全部インストールしてくれるという便利なやつ。
RubyのGemfileをイメージするとわかりやすい。

かつてlegacyな方のhomebrewでdeprecatedになったものが公式にプラグイン？という形でいつのまにか復活していた。
https://github.com/Homebrew/legacy-homebrew/issues/30815

`brew bundle` を叩いたときにhomebrew-bundleが入ってなかったら自動で入れてくれるし、
`brew bundle dump`すれば今brewでインストールされているものをBrewfileとして出力してくれるなど導入も容易。

後述のhomebrew caskやmasにも対応していて、これ使っておけばいい感がすごい。
dotfilesをリファクタしようと思ったきっかけの一つ。

### anyenv類をすべて使わなくした

rbenv, phpenvなど、触る可能性のある言語の*envはすべてanyenvで入れて、最新バージョンをインストールしていたが、やめた。
常にすべての言語を触るわけではなく、更新があるたびにそれらをアップデートするのも面倒。
開発環境が必要ならDockerで立てたり、Vagrantの環境を作ったりすればいい。
Macを汚さず開発環境をポータブルにする方に力を注ぐことにした。

### Ansibleをやめた

> Provisioner of My Mac.  
> https://github.com/ikuwow/mac-provision

以前はansibleのリポジトリを作って、そちらでbrewによるインストールやdefaultsをして、dotfilesは単に設定ファイル置き場としていたが、やめた。

env系も減らしたし他にも不要なものが多くなくなり全体が小さくなったのと、homerew-bundleで十分なので特別必要ではなくなったから。
osx_defaultsというモジュールがあるのが利点の一つだったが、defaultsコマンドはだいたい冪等なのでshellscriptで実行してもそんなに問題はない。

何よりMacの初期セットアップにAnsibleという別途インストールが発生する依存がある問題が解消したのは大きい。

### masを使った

> 📦 Mac App Store command line interface  
> https://github.com/mas-cli/mas

App Storeからインストールする必要のあるアプリをCLIからインストールできる代物。
homebrew-bundleにも対応しているし、入れない手はない。
下記のhomebrew-caskもだが、自分の使う全てのMacで必要なものだけ入れるようにして、
Macによっては入れる必要のないものはここに書かず手動で入れる方針にした。

### なるべく全てをhomebrew caskに入れた

> 🍻 A CLI workflow for the administration of macOS applications distributed as binaries https://brew.sh  
> https://github.com/Homebrew/homebrew-cask

.pkgなどでApp Store以外から落としてくる必要のあるアプリのインストールに使う。
以前 [自動化厨の自分がhomebrew-caskを使わなくなった理由](/entry/stop-brew-cask/) という記事を書いたりしたが、
今は自動アップデートされるアプリはフラグを立ててcaskがアップデートしないようにでき、
問題が解決しているので使っている。
管理下に入ってないものを管理下にいれることもした。

### mackupを使った

> Keep your application settings in sync (OS X/Linux)  
> https://github.com/lra/mackup

アプリケーションの設定の実体をDropboxやiCloud Driveにバックアップして、必要な場所にsymlinkを貼ってくれるもの。
バックアップというより設定の同期をサポートしてくれるツールという理解。

今まで.ssh/config{.d}の同期をiCloud Driveでやっていたりしたのでこいつに巻き込んだ。
ここにサポートされてないアプリケーションも、同期が必要なファイルがわかっていれば `~/.mackup/*.cfg`に書けばよいので便利。
このあたりやりすぎると副作用も多そうなので、本当に最低限にした。

### その他

defaultsコマンドをシェルスクリプトにした。Ansibleをやめたので当然こうなる。
ついでに足りていない設定も少し追加した。
とはいえ、Night Shiftの設定はrootが必要だったり、defaultsはMapの処理がうまくできず`/usr/libexec/PlistBuddy`を
使う必要があったりしたので、まだ漏れがある。一旦今回のリストアの後に手動で設定した。

TravisCIを回し始めて[shellcheck](https://www.shellcheck.net)をするようにした。
shellcheckはなんとこのリファクタ中に知った。
TravisCIに取り込まれている程度にはメジャーで、Wikiのruleの説明も充実している。
vimのaleにもデフォルトで対応していた。

dotfiles以下だけdotなしにするのをやめた。
なぜか以前は `~/.bashrc` => `~/dotfiles/bashrc` のようにリンクを張っていたが、逆に混乱を招いていたのでやめた。

ワンライナーでスタートアップが行えるようなbootstrap.shを作った。

```
bash -c "$(curl -L https://raw.githubusercontent.com/ikuwow/dotfiles/master/bootstrap.sh)"
```

Homebrewのインストール、`brew bundle`、その他スクリプトの実行を順次行っていくもの。
リストアの際に、1passwordは早めにインストールさせておくとブラウザでTwitterやGitHubにログインできて、
Xcodeは後にしないと他のインストールが全部止まる、など改善点も見えたので直した。

## まとめ

見てみると意外と不要なものは多かったのでお掃除ができてよかった。
Brewfileが復活したのもそうだが、
Dockerがあることで例えば「Ruby 2.4.3でこのスクリプト叩くとどうなるかなー」などをMacを汚さずにすぐ実験できるようになったのも大きい。

実際にMacBook Proのリストアもしてみて、漏れていてまだ自動化できそうな設定が洗い出されたので今後時間があるときに
defaultsに移していく。

## 参考

開発環境をDocker化して、1年に1回はMacをリストアする人。Macをimmutableにする勇気。
http://saboyutaka.hatenablog.com/entry/2018/08/23/023925
