---
title: vagrant-awsとvagrant-digitaloceanの比較
date: 2015-05-06 00:00 JST
tags: Vagrant, AWS
published: false
---

ちょっと開発マシンのスペックが低く、
マシン内で仮想マシンを立ち上げてあれこれするリソースがないため、
クラウドの開発環境を検討することに。
候補としてはAWSのEC2かDigitalOcean。
どちらの開発環境も作ってみて、今後どちらを使うかを考えることにした。

## vagrant-aws

まずはvagrant-awsをインストールする。詳細はこちらから。
https://github.com/mitchellh/vagrant-aws

```
vagrant plugin install vagrant-aws
```

### IAMユーザーを作成しキーを取得する

Vagrant用に新しくIAMでユーザーを作成するのをオススメ。
ここではvagrantというユーザー名でEC2に対するFullAccess権限を与えました。

取得するキーは以下の２つ。

* Access Key ID
* Secret Access Key

この２つを保存しておくこと。

### Vagrantfile書く

dummyのboxが必要なようで、これを"dummy"という名前にアサインする。



コードは以下のとおり


usernameはきちんと決めないといけない。

```
==> default: Warning! The AWS provider doesn't support any of the Vagrant
==> default: high-level network configurations (`config.vm.network`). They
==> default: will be silently ignored.
==> default: Starting the instance...
==> default: Waiting for instance to become "ready"...
==> default: Waiting for SSH to become available...
==> default: Machine is booted and ready for use!
==> default: Rsyncing folder: /path/to/vagrant/root/ => /vagrant
```

こんなかんじで

### エラー対策

```
The following SSH command responded with a non-zero exit status.
Vagrant assumes that this means the command failed!

mkdir -p '/vagrant'

Stdout from the command:



Stderr from the command:

sudo: sorry, you must have a tty to run sudo
```

以上の様なエラーが起きた時は、以下のように/etc/sudoers中のrequirettyをコメントアウトすると治る。

```
# これをコメントアウトする
# Defaults    requiretty
```

新しくマシンを立ち上げるたびにこれをするのはさすがに面倒なので、
AMIを作ってしまうというのを非常におすすめする。


## vagrant-digitalocean

DigitalOceanはSSDのVPSのみを作れるサービス。
UIや設定項目はすごくシンプルで、価格も結構安い。

### API keyの取得

一度しか保存できるタイミングがないので必ず保存して安全な場所に管理しておくこと。


### vagrantfileを書く
