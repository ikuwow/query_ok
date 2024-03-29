---
title: PHP5.3.3からPHP 5.6.7にアップデートする際にやったこと
date: 2015-04-04 18:34 JST
tags: PHP, Chef
---

PHP 5.3.3から現在最新のPHP5.6.7にアップデートする機会があったのでその時のメモ。

Cent OSで`yum install php`をすると、
既にサポートが1年近く前に切れているPHP 5.3.3がインストールされてしまう。
もはやこのコマンドは既に絶対に打ってはいけないコマンドになってしまった。

なんとサービスの動いているサーバーのPHPのバージョンが5.3.3だったということで急遽アップデートすることに。
PHP7の発表も近そうな雰囲気がしているので、いい機会だということで一気に現在最新の5.6.7まであげることにした。

## サーバー側の変更

サーバーにインストールされているPHPのアップデートそのものの作業に関しては、特に複雑な部分はない。
適切なビルドオプションを考えるというのが中心の作業。

まず今インストールされているPHPのコンパイルオプションを確認し、
その中から必要なものを選んで`./configure`、`make`、`make install`すればよい。
依存パッケージはyumでインストールするものでいいかと。

Chefでrecipeを書くと以下のようになる。

```ruby
# 依存パッケージのインストール
%w{libxml2 libxml2-devel libpng libpng-devel libjpeg libjpeg-devel
    libvpx libvpx-devel}.each do |p|
    package "Install #{p} for PHP" do
        package_name p
        action :install
    end
end

# epelリポジトリで入れる依存パッケージのインストール
%w{libmcrypt libmcrypt-devel}.each do |p|
    package "Install #{p} for PHP" do
        package_name p
        options "--enablerepo=epel"
        action :install
    end
end

php56_version = "5.6.7"

bash "Fetch PHP" do
    cwd "/tmp"
    code <<-EOC
    wget http://jp2.php.net/distributions/php-#{php56_version}.tar.gz
    tar xvf php-#{php56_version}.tar.gz
    EOC
    not_if { File.exists?("/tmp/php-#{php56_version}") }
end

build_option = '\
--prefix=/usr \
--with-apxs2 \
--enable-xml \
--with-config-file-path=/etc \
--enable-mbstring \
--with-mcrypt \
--with-openssl \
--with-curl \
--with-gd \
--with-jpeg-dir=/usr \
--with-vpx-dir=/usr \
--with-mysql \
--with-pdo-mysql \
--with-snmp \
--with-zlib'

bash "Build PHP" do
    cwd "/tmp/php-#{php56_version}"
    code "./configure #{build_option}  && make && make install | tee ./php-build.log"
    not_if <<-EOC
        test "`php -i | grep configure | sed -e "s/'//g" | cut -d ' ' -f7-`" = "#{build_option}" -a "`php -v | grep #{php56_version} > /dev/null;echo $?`" -eq 0
    EOC
    notifies :run, "bash[Restart Apache to apply PHP changes]"
end

```

`php56_version`の値を変えればアップデートにも対応できる。
また`Build PHP`の`not_if`は`php -i`で現在のビルドオプションとバージョンが指定したものと同じか確認する。
この部分はかなり強引に書いてしまったので、より良い方法があったら誰か教えていただきたい。。。。

## アプリケーション側の変更

今回は5.3から5.6というかなり間をすっ飛ばしたアップデートの仕方をするので、
アプリケーション側で確認すべきことは多い。

5.3 => 5.4、5.4 => 5.5、5.5 => 5.6のそれぞれについての後方互換性のない変更（incompatible changes）を確認する必要がある。

* http://php.net/manual/ja/migration54.php
* http://php.net/manual/ja/migration55.php
* http://php.net/manual/ja/migration56.php

この中で特に注意したものを挙げる。

### 参照渡しの利用方法の変化 (PHP5.3 => PHP5.4)

関数呼び出し時に参照渡しが指定されている場合Fatal Errorが発生する。
古いライブラリを使用していたりする場合はよくこれが行われているので動かなくなることが多い。

以下はエラーになる例。

```php
<?php
function foo($var) {
    $var++;
}

$a=5;
echo foo(&$a);
```

解決方法は簡単で、以下のように、関数呼び出し時に参照渡しを指定するのではなく、
関数宣言時に参照渡しを指定すればよい。

```php
<?php
function foo(&$var) {
    $var++;
}

$a=5;
echo foo($a);
```

修正の方法が画一的なので、動作を確認しなくてもコードベースで修正が可能。
影響の大きい変更ではあるもののSyntax Errorなので、
以下のように全ファイルに文法チェックを行えば動作を確認しなくても修正ポイントが発見できる。

```bash
find /path/to/app -name *.php -exec php -l {} \;
```

そもそもPHP5以降では参照渡しの意義が薄くなっているらしいので、`&`を消してしまうという選択もありかもしれない。

### 変数が文字列の場合に非数値のオフセットを指定した場合の挙動が変わる（PHP5.3 => PHP5.4）

文字列にうっかり非数値のオフセットが指定されていると挙動が変わってくるのに注意。
ドキュメントに乗っているのは以下の様な例。

```php
$text = "test";
echo isset($text["aa"]); // PHP5.4以降false
echo empty($text["aa"]); // PHP5.4以降true
```

細かく確認してはいないが、単純に文字列に非数値のオフセットをつけてechoさせたら`Allowed memory size of *** bytes exhausted`がでて完全停止してしまった。PHP5.3だとなんのエラーもなく非数値のオフセットでも文字列が出力されるので見落としがち。

### Strict Standardsがデフォルトで出力されるようになった（php5.3 => PHP5.4）

もうちょっと詳しく言うと、`E_ALL`に`E_STRICT`が含まれるようになった。
PHP5.3では出力されなかったので、開発中ところどころに見つかってもびっくりしないように。
本番環境では全く表示しないはずなのですぐ問題ではないが、開発中に出てきて気持ち悪い。

例えば、クラスの継承を行ってメソッドをoverrideするときにもとのメソッドと引数の数や型が
異なっていると`Declaration of ClassB::methodA() should be compatible with ClassA::methodA`のような
メッセージが出る。

より安全にコードを書くように促してくれるため、これを見かけたら修正するというのが簡単かと。
完全に無視したい場合は非表示にしてしまうこともあるらしい。以下の記事を参照。

参考：
http://qiita.com/MANO_fukuoka/items/8d4ec7d4f3cc20355272

## まとめ

もちろんここで挙げた他にもincompatible changesたくさんあるので、
必ず公式のドキュメントを見て必要であれば確認すること。

この前のアップデートで他に確認したのは、continueとbreakの引数に変数が使われていないこと、
traitやcallableなどの新しい予約語が使われていないこと、`json_decode()`で受け取るtrueやfalseが
全て小文字であることなど。また古いライブラリはひと通り最新版にアップデートするのがよい。

手を動かす前にビビっていたほど作業量は多くなかったのでよかったものの、
確実に考慮しなければならないことは多いし、何より一人だとモチベーションが続かないので、
チェック項目をひと通り挙げてから修正作業を始めるのがよい。
