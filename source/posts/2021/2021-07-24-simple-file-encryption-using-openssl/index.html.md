---

# title: simple-file-encryption-using-openssl
title: opensslコマンドで簡単なファイル暗号化
date: 2021-07-24 12:13 JST
tags: Qiita, OpenSSL
thumbnail:

---

この記事は、2016年08月22日にQiitaで投稿した以下の記事を転記したものです。

> opensslコマンドで簡単なファイル暗号化  
> https://qiita.com/ikuwow/items/1cdb057352c06fd3d727

---

単純にテキストファイルを暗号化する方法はないかと思って探してみると`openssl`コマンドで可能でした。おそらく多くの開発マシンやサーバーにはopensslコマンドが入っているので、汎用性は非常に高い気がしています。

こちらを主に参考にしました。
http://cpplover.blogspot.jp/2013/07/gnulinuxcli.html

opensslのサブコマンドのマニュアルの見方がわからず参照していないので、オプションなど微妙に間違っていたら教えていただけると幸いです。

## 準備


準備するものは以下の2つ。

* 暗号化したい対象のテキストファイル `rawtext.txt`
* パスワード`password`、もしくはパスワードファイル`password.txt`

ちなみにパスワードは1行目にずらずらっと書く必要があるようです。

これらから暗号化ファイル`encrypted.txt`を出力して、それを`decrypted.txt`に復号します。これが`rawtext.txt`と一致するはず。


## 暗号化

### パスワードを標準入力から取得する場合

```bash
$ openssl aes-256-cbc -e -in rawtext.txt -out encrypted.txt
enter aes-256-cbc encryption password: # パスワード入力
Verifying - enter aes-256-cbc encryption password: # もう一度
```

### パスワードをファイルから読み込む場合

```bash
openssl aes-256-cbc -e -in rawtext.txt -out encrypted.txt -pass file:./password.txt
```

## 復号

### パスワードを標準入力から取得する場合

```bash
$ openssl aes-256-cbc -d -in encrypted.txt -out decrypted.txt
enter aes-256-cbc decryption password: # パスワードを入力
```

### パスワードをファイルから読み込む場合

```bash
openssl aes-256-cbc -d -in encrypted.txt -out decrypted.txt -pass file:./password.txt
```

## 簡単な説明

`aes-256-cbc`というのが暗号化方式の1つ。ググった感じでは、これがよく使用されている暗号化方式っぽい。暗号化方式の一覧は`openssl list-cipher-commands`で見られる。

`-e`というのがencrypt、つまり暗号化を表し、`-d`がdecryptつまり復号を表す。

`-pass`はパスワードの読み込み先を指定する。`file:filepath`で`path`のファイルの内容を読み、env:varで環境変数`$var`を読む。`pass:password`と直接passwordを指定することもできるが危険なのであまりしないこと。

## 活用場面

Chefのencrypted data bagみたいに、公開したくない情報をgithubへ上げるときに使えそう。password.txtを.gitignoreするのを忘れずに。個人的にはdotfilesリポジトリに`~/.ssh/config`を入れるのに使用しようかと思っている。

## オマケ

「パスワード」と「パスフレーズ」の違い。この記事を書いていたら気になったので。
https://technet.microsoft.com/ja-jp/library/dd362846.aspx

