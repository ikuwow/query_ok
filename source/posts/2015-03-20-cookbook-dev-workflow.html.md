---
# title: cookbook-dev-workflow
title: Cookbook開発の基本ワークフロー
date: 2015-03-20 07:38 JST
tags: Chef, test-kitchen, serverspec
---

先日まで、複数のcookbookを含めたchef-repo全体をgitリポジトリ化して運用していたという非常に
アンチパターンな運用をしていて、このたびきちんとcookbook単位でバージョン管理しようと決意。
ついでにChef-soloもやめてChef serverの使い方を覚えた。

単一Cookbookをchef-repoなしに独立に開発する流れがどこにもまとまっていなかったのでメモ。
いちおう自分の考える王道のようなものになっているはず。

Chefはchefdkでインストールしてあるものとする。

今回はサーバーの基本設定をまとめたbase-settingsというcookbookの作成を例に取る。

## Cookbookの作成


新しいCookbookを作る場合は以下のコマンドで作る。

```bash
$ knife cookbook create base-settings -o .
WARNING: No knife configuration file found
** Creating cookbook base-settings in /Users/degawaikuo/workspace
** Creating README for cookbook: base-settings
** Creating CHANGELOG for cookbook: base-settings
** Creating metadata for cookbook: base-settings
```

このコマンドはchef-repoのトップディレクトリで使うことを想定されているようで、
デフォルトだと`./cookbooks`ディレクトリを探してそこにcookbookをつくろうとするので、
`-o`オプションでカレントディレクトリに作成場所を指定する。

```bash
$ cd base-settings
$ ls
CHANGELOG.md README.md    attributes   definitions  files
libraries    metadata.rb  providers    recipes      resources    templates
```

さっき「knifeの設定がないよ」と言われたので下のように作成する。
この単一cookbook開発ではChef Serverを使わないのでlocal\_modeをtrueにしておく。
これで`-z`オプションが不要になり、
`ERROR: Your private key could not be loaded from /etc/chef/client.pem`のエラーがなくなる。
local\_modeで使っていると.chef/local-mode-cacheができるのでこいつをgitignoreしておく。

```bash
mkdir .chef/
echo "local_mode true" > .chef/knife.rb
echo "/.chef/local-mode-cache" >> .gitignore
```

ひととおりファイルができたところで`git init`してバージョン管理に乗せる。
GitHubへの登録は省略。

```bash
$ git init
Initialized empty Git repository in /path/to/cookbook/base-settings/.git/
$ git add .
$ git commit -m'initial commit'
[master (root-commit) 1c73a3b] initial commit
 4 files changed, 96 insertions(+)
 create mode 100644 CHANGELOG.md
 create mode 100644 README.md
 create mode 100644 metadata.rb
 create mode 100644 recipes/default.rb
```

## test-kitchenの設定

cookbookのテストは基本的にtest-kitchenの仮想マシン上で行う。Vagrantfileは作らない。
test-kitchenの設定ファイルである.kitchen.ymlにrun_listやテストスイートをなどを細かく書けて非常に便利なので
手動でvagrantコマンドをうつよりも`kitchen test`する方がオススメ。

```bash
$ kitchen init
IkuosMacmini:base-settings degawaikuo$ kitchen init
      create  .kitchen.yml
      create  test/integration/default
      append  .gitignore
      append  .gitignore
      append  .gitignore
Successfully installed kitchen-vagrant-0.15.0
1 gem installed
```

`.gitignore`に追記され`.kitchen.yml`が新しく追加された。

`.kitchen.yml`はtest-kitchenで使う種々の設定を書くファイルで非常に重要。デフォルトでは以下のようになっている。

```yaml
---
driver:
  name: vagrant

provisioner:
  name: chef_solo

platforms:
  - name: ubuntu-12.04
  - name: centos-6.4

suites:
  - name: default
    run_list:
      - recipe[base-settings::default]
    attributes:
```

driverは仮想マシンを立ち上げる環境を指定する。デフォルトだとvagrantなのでこれでよい。
他にもec2やdockerを指定できるらしい。

platformsはテストするサーバーOSを指定する。指定した数だけ仮想マシンが立ち上がるので、
開発マシンのスペックと相談かな。

provisionerがdeprectedなchef\_soloなのでこれをchef\_zeroにする。
あとplatformsのOSのバージョンが古いので新しくする。
結果以下のようになる。

```yaml
---
driver:
  name: vagrant

provisioner:
  name: chef_zero

platforms:
  - name: ubuntu-14.10
  - name: centos-6.6

suites:
  - name: default
    run_list:
      - recipe[base-settings::default]
    attributes:
```

ここまで書けば`kichen test`が動くので動かしてみる。
新しく仮想マシンを立ち上げるときに結構時間かかるので、仮想マシン壊さないように`--destroy=never`をつけるととっても捗る。
あと`-c`をつけると複数の仮想マシンを並列にテストしてくれるので速い。

```bash
kitchen test --destroy=never -c
```

だいぶ時間をかけて、vagrantで２つの仮想マシンが立ち上がり、それぞれにVirtualBoxのGuestAdditionsがインストールされ、
さらにchef-clientがインストールされる。仮想マシンごとに色分けして出力されるのがわかりやすい。
recipeもテストコードはなにも書いていないので何も実行されない。

ここまででtest-kitchenの最低限の設定は完了。この辺りで`git commit`しておくとよい。


##  レシピを書いてテストコードを回す

設定がだいたい終わったので、早速テストコードとrecipeを書く。
テストコードはserverspecで書くので、

`/test/integration/default/serverspec/user_spec.rb`

```ruby
require 'serverspec'
set :backend, :exec

describe user('ikuwow') do
    it { should exist }
    it { should belong_to_group 'ikuwow' }
    it { should have_home_directory '/home/ikuwow' }
end
```

`/recipes/default.rb`

```ruby
include_recipe "base-settings::user"
```

`base-cookbook/recipes/user.rb`

```ruby
group "ikuwow" do
    action :create
end

user "ikuwow" do
    gid "ikuwow"
    home "/home/ikuwow"
    action :create
end
```

recipeが書けたら`kitchen test`する前にまず`knife cookbook test base-settings -o ..`するとよい。
文法チェックだけしてくれる。
`-o`オプションではcookbookの設置されているディレクトリを指定する必要があることに注意。

```bash
$ knife cookbook test base-settings -o ..
checking base-settings
Running syntax check on base-settings
Validating ruby files
Validating templates
```

それでは`kitchen test`。

```bash
$ kitchen test --destroy=never -c
（省略）
-----> serverspec installed (version 2.10.2)
       /opt/chef/embedded/bin/ruby -I/tmp/busser/suites/serverspec -I/tmp/busser/gems/gems/rspec-support-3.2.2/lib:/tmp/busser/gems/gems/rspec-core-3.2.2/lib /opt/chef/embedded/bin/rspec --pattern /tmp/busser/suites/serverspec/\*\*/\*_spec.rb --color --format documentation --default-path /tmp/busser/suites/serverspec

       User "ikuwow"
         should exist
         should belong to group "ikuwow"
         should have home directory "/home/ikuwow"

       Finished in 0.09826 seconds (files took 0.27158 seconds to load)
       3 examples, 0 failures

       Finished verifying <default-ubuntu-1410> (0m14.02s).
       Finished testing <default-ubuntu-1410> (14m58.27s).
-----> Kitchen is finished. (14m58.54s)
```

無事にレシピを適用できテストも通過した。
神経質な人は`kitchen login default-centos-66`でsshログインして手動で確認すればよい。


## 依存cookbookの解決

supermarket.chef.ioにあるコミュニティクックブックはぜひ積極的に使いましょう。
車輪の再発明は悪。先人の知恵は活用すべし。
ただサービスを動かすサーバーなどセキュリティ要件が大きい場合はよくクックブックの中身を読むこと。
自分はなるべくダウンロードが多いものを選ぶようにしている。

今回は以下のSELinuxのクックブックを使う。
Chef公式でかつダウンロード数がずば抜けて多かったので信用度高い。

https://supermarket.chef.io/cookbooks/selinux

追加が必要なのは`metadata.rb`と`Berksfile`。

`metadata.rb`を編集して依存クックブックを記入する。
dependsという項目に依存cookbookを書く。
ついでにmaintainerなどの必要事項を書き足しておく。

```
name             'base-settings'
depends          'selinux', '~> 0.9.0'
maintainer       'ikuwow'
maintainer_email 'ikuwow@example.com'
license          'All rights reserved'
description      'Installs/Configures base-settings'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'
```

またBerksfileを作成して以下のようにする。`berks init`で様々作成できるがこれは使わない。

```
source "https://supermarket.chef.io"

metadata
```

このmetadataというのがポイント。
これを書くとmetadata.rbのdependsを確認して、
test-kitchenを使った時にBerkshelfで依存cookbookをダウンロードしてくれる。
つまりこの状態でselinuxクックブックが使えるようになったというわけ。

recipes/default.rbを以下のように編集。

```ruby
include_recipe "base-settings::user"

include_recipe "selinux::disabled"
```

そして`kitchen converge`。少し長いけどcentosの方のみ変更があったのでこちらを載せる。

```bash
$ kitchen converge
(ubuntuは省略)
-----> Converging <default-centos-66>...
       Preparing files for transfer
       Preparing dna.json
       Resolving cookbook dependencies with Berkshelf 3.2.3...
       Removing non-cookbook files before transfer
       Preparing validation.pem
       Preparing client.rb
-----> Chef Omnibus installation detected (install only if missing)
       Transferring files to <default-centos-66>
       Starting Chef Client, version 12.1.1
       [2015-03-21T15:47:39+00:00] WARN: Child with name 'dna.json' found in multiple directories: /tmp/kitchen/dna.json and /tmp/kitchen/dna.json
       resolving cookbooks for run list: ["base-settings::default"]
       Synchronizing Cookbooks:
         - base-settings
         - selinux
       Compiling Cookbooks...
       Converging 5 resources
       Recipe: base-settings::user
        (up to date)
         * user[ikuwow] action create (up to date)
       Recipe: selinux::_common
        (up to date)
         * directory[/etc/selinux] action create (up to date)
       Recipe: selinux::disabled
        (up to date)
         * execute[selinux-disabled] action run


           - update content in file /etc/selinux/config from 2b3b43 to 8a6a4a
           --- /etc/selinux/config	2015-02-24 14:25:26.023999934 +0000
           +++ /tmp/chef-rendered-template20150321-8033-ndcsnv	2015-03-21 15:47:42.136045491 +0000
           @@ -1,14 +1,12 @@
           -
            # This file controls the state of SELinux on the system.
            # SELINUX= can take one of these three values:
           -#     enforcing - SELinux security policy is enforced.
           -#     permissive - SELinux prints warnings instead of enforcing.
           -#     disabled - No SELinux policy is loaded.
           -SELINUX=permissive
           -# SELINUXTYPE= can take one of these two values:
           -#     targeted - Targeted processes are protected,
           -#     mls - Multi Level Security protection.
           -SELINUXTYPE=targeted
           -
           +#       enforcing - SELinux security policy is enforced.
           +#       permissive - SELinux prints warnings instead of enforcing.
           +#       disabled - SELinux is fully disabled.
           +SELINUX=disabled
           +# SELINUXTYPE= type of policy in use. Possible values are:
           +#       targeted - Only targeted network daemons are protected.
           +#       strict - Full SELinux protection.
           +SELINUXTYPE=targeted

           - restore selinux security context

       Running handlers:
       Running handlers complete
       Chef Client finished, 2/7 resources updated in 4.01651555 seconds
       Finished converging <default-centos-66> (0m7.70s).
-----> Kitchen is finished. (0m29.39s)
```

Berksfileでcookbokの依存パケージが解決され、仮想マシンに同期されている様子がわかる。
無事にSELinuxの無効も済んだよう。

テストコードselinux\_spec.rbを後から書いた。

```ruby
require 'serverspec'
set :backend, :exec

describe selinux do
    it { should be_disabled }
end
```


`git commit`する前に`Berksfile.lock`はバージョン管理しないことが推奨されるので、
.gitignoreに追加しておいたほうがよい。


## attributesの使い方

environmentsやrolesやnodesオブジェクトに書くattributesも.kitchen.ymlで指定することで利用できる。
ここではコミュニティクックブックのうちopensshを使って、
SSHのルートログイン不許可とパスワード認証無効を設定する。
これもChef謹製で2009年に作成されて着々とアップデートされているので信頼できそう。

https://supermarket.chef.io/cookbooks/openssh

このcookbookはattributeに細かい設定をするようになっている。

依存クックブックを解決するために`metadata.rb`に追加。

```
name             'base-settings'
depends          'selinux', '~> 0.9.0'
depends          'openssh', '~> 1.3.4'
maintainer       'ikuwow'
maintainer_email 'ikuwow'
license          'All rights reserved'
description      'Installs/Configures base-settings'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'
```

そんでrecipeに追記。

```ruby
include_recipe "base-settings::user"

include_recipe "selinux::disabled"

include_recipe "openssh::default"
```

とりあえずattributesを書かない状態で適用してみる。

```bash
kitchen test --destroy=never -c
```

成功したのを確認したら.kitchen.ymlにattributeを書いていく。

どのような形でattributesを書けばいいかはソースのattributesを見るとわかる。
nodesやenvironmentsにはjsonで書くがこちらはyamlなので注意。

https://github.com/opscode-cookbooks/openssh/blob/master/attributes/default.rb


`.kitchen.yaml`

```yaml
---
driver:
  name: vagrant

provisioner:
  name: chef_zero

platforms:
  - name: ubuntu-14.10
  - name: centos-6.6

suites:
  - name: default
    run_list:
      - recipe[base-settings::default]
    attributes:
      openssh: 
        server:
          password_authentication: "no"
          permit_root_login: "no"
```

これで`kichen converge`すれば望んだ状態になるはず。

```bash
$ kitchen converge 
〜（省略）〜
       Recipe: openssh::default
         * apt_package[openssh-client] action install (up to date)
         * apt_package[openssh-server] action install (up to date)
         * service[ssh] action enable (up to date)
         * service[ssh] action start (up to date)
         * template[/etc/ssh/ssh_config] action create (up to date)
         * template[/etc/ssh/sshd_config] action create
           - update content in file /etc/ssh/sshd_config from 330f51 to d89d12
           --- /etc/ssh/sshd_config	2015-03-22 00:52:55.336641973 +0000
           +++ /tmp/chef-rendered-template20150322-1880-18smxl	2015-03-22 01:19:51.899348600 +0000
           @@ -3,5 +3,7 @@

            ChallengeResponseAuthentication no
            UsePAM yes
           +PasswordAuthentication no
           +PermitRootLogin no

         * service[ssh] action restart
           - restart service service[ssh]

       Running handlers:
       Running handlers complete
       Chef Client finished, 2/12 resources updated in 6.559877352 seconds
       Finished converging <default-ubuntu-1410> (0m10.03s).
```

/etc/ssh/sshd\_configに二行追加されて、restartがnotifyされて無事適用された。


## data bagsの使い方

これは.kitchen.ymlにdata bagsを置くディレクトリを指定して、その場所にdata\_bagsを作ってやればよい。
あくまでテスト用のdata bagsなので、`test/`ディレクトリ以下に入れるとよいかも。
ここではdata\_bag userにdata\_bag\_item ikuとwowを追加して、これを使ってユーザー作成を行う。

.kitchen.ymlは以下のようになる。

```yml
---
driver:
  name: vagrant

provisioner:
  name: chef_zero

platforms:
  - name: ubuntu-14.10
  - name: centos-6.6

suites:
  - name: default
    run_list:
      - recipe[base-settings::default]
    attributes:
      openssh: 
        server:
          password_authentication: "no"
          permit_root_login: "no"
    data_bags_path: test/data_bags

```

次にdata bagの作成。`-o`オプションでdata_bagsディレクトリの場所を指定できたらいいのだがどうやら存在しないようなので、
cdしてから`knife data bag create ...`してdata bagを作る。

```bash
$ cd test
$ knife data bag create users iku
(vimが立ち上がるので以下のように編集する）
{
  "id": "iku",
  "comment": "ゐく"
}
(:q)
Created data_bag[users]
Created data_bag_item[iku]
$ knife data bag create users wow
(vimが立ち上がるので以下のように編集する）
{
  "id": "wow",
  "comment": "を"
}
(:q)
Data bag users already exists
Created data_bag_item[wow]
```

そしてrecipeとテストコードを書く。

`recipes/users.rb`

```ruby
group "ikuwow" do
    action :create
end

user "ikuwow" do
    gid "ikuwow"
    home "/home/ikuwow"
    action :create
end

user_list = data_bag('users')

user_list.each do |ul|
    u = data_bag_item('users',ul)
    user u["id"] do
        comment u["comment"]
        home "/home/#{u["id"]}"
        action :create
    end
end
```

`test/integration/default/serverspec/users_spec.rb`

```ruby
require 'serverspec'
set :backend, :exec

describe user('ikuwow') do
    it { should exist }
    it { should belong_to_group 'ikuwow' }
    it { should have_home_directory '/home/ikuwow' }
end

%w{iku wow}.each do |u|
    describe user(u) do
        it { should exist}
    end
end
```

```bash
kitchen converge && kitchen verify
```

これで`iku`ユーザーと`wow`ユーザーが作成される。


## まとめ

metadataとBerksfileでcookbookの依存は解決でき、あとは.kitchen.ymlに必要なことを書けばよいということで、
非常にわかりやすい手順が得られたかなと満足している。
依存クックブックやattributesも一つのcookbook内で完結させられるというのがよいですね。

補足として、run\_listをnodesやrolesに書くよりも、
ここで示した例として`include_recipe`を並べるcookbookを作ったほうがよいようだ。
run\_listとrolesはChef Server環境だとバージョン管理を行わない一時ファイルの扱いにするのが普通なので、
バージョン管理するcookbookのrecipeに入れておくと運用しやすい。

ここで作ったbase-settingsはGitHubに上げてあるので参考までに。

https://github.com/ikuwow/base-settings

## 参考資料

* test-kitchenを並列実行する：http://think-t.hatenablog.com/entry/2014/12/12/002237
* [和訳] 初心者Chefアンチパターン by Julian Dunn #opschef_ja：http://www.creationline.com/lab/3080

