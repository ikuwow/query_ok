---
title: チームで使える即効でWebアプリ開発環境を整える手順をまとめる
date: 2015-02-26 23:14 JST
published: false
tags: Vagrant, Chef
---

しばらく知識のキャッチアップが必要なインターン生なんかの場合は特に、
環境構築という開発において本質的でない部分で躓いてしまうことがしばしば。


まずニューカマーのマシン（Macを想定）を開発ができるように適切にセットアップし、
開発用の仮想マシンをVagrantで立ち上げ、
それにChefのレシピを流し込んで、Vagrantのsynced folderにおいたソースコードを触って
開発が初められるようにするところまで。

## 開発マシン（Mac）のセットアップ

これはかなり個人差があります。

### Homebrewのインストール

これは公式サイトから一行コピペしてターミナルに貼り付けます。
http://brew.sh/index_ja.html

```
$ ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```


## Vagrantで仮想マシンを立ち上げる

```
Vagrantfile
chef/centos-6.6
```

```
$ vagrant up
```

## Chefrepoを流し込む

