---
title: M1 MacBook Proを買いセットアップをした
# title: m1-mac-setup
date: 2020-12-22 01:59 JST
tags: Apple, Mac

---

https://twitter.com/ikuwow/status/1340280004563804161

## 買った理由

今のMacBook Pro 13 inch 2017はスペックを盛らず妥協して購入していて、最近何かと挙動がカクついてきたところだったので買い換えを決意。eGPUが使えなかったりアプリによってはまだ動かなかったりするのがハードルだが、何かあっても他に仕事用MacBook Proと母艦Mac miniがあるので、Intelは捨ててApple Siliconに手を出したのだった。

ファンクションキーが嫌いなのでAirでなくProを選択。Touch Barに特に感情があるわけではない。

注文してから届くまでの間にM1で動くDocker tehcnical previewが発表されて安心した☺️

## セットアップ

セットアップは基本的にdotfilesを通せばよいようにしているのでこれを直していく。

https://github.com/ikuwow/dotfiles

右往左往したが最終的にはこんな感じ。M1対応に関係なくそもそも欠けていたいた部分を直すのもやった。

https://github.com/ikuwow/dotfiles/pull/20

homebrewはARM版を `/opt/homebrew` に、Intel版を `/usr/local` に入れるのが推奨されていて、今回は全てターミナル環境をIntel版で作ることにした。（とはいえ上のPRでは途中までARM版も `brew bundle` まで通すつもりで`/opt/homebrew`を置くまでやってしまっているが）

https://docs.brew.sh/Installation

ワンライナーのスクリプトはまだARM版インストールに対応しておらず怒られる。

```
Error: Cannot install in Homebrew on ARM processor in Intel default prefix (/usr/local)!
Please create a new installation in /opt/homebrew using one of the
"Alternative Installs" from:
  https://docs.brew.sh/Installation
```

brewのインストールなどは `arch` コマンドで明示的にアーキテクチャを指定して実行し、判定は `uname -m` でやればよろしい。

その後はiTermのデフォルトシェルを今まで通り `/usr/local/bin/bash` （Intel版brewで入れたbash）に通したら、完全に今までのIntel環境で作ってきたターミナル環境が完成した。

M1向けの修正に限らず、Macを買うたびに大がかりな修正が必要になってるので、bootstrapをCI回すなどしたい。1,2年に1度のMacのセットアップのためにそこまでする？という感じではあるが単に楽しいので。

## 使用感

評判の早さは、なんというか、今までのパーソナルコンピュータとはそもそも違うという感覚。

https://twitter.com/ikuwow/status/1340290209351528448

まだ新しいMacというのもあるが全ての挙動がキビキビしている。Macと意識との距離が縮まって第二の脳としての地位がさらに強まったような。これでバッテリーの持ちがずっといいんだからたいしたもんだ。ただただ強い。

## まとめ

Dockerもpreviewで動くしdotfilesによるbootstrapも少し直せば動くし、ウェブ開発の仕事ぐらいならできるぐらいになっているので皆さん今後MacはARM版を買いましょう。
