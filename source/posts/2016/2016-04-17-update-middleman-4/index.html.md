---
title: ブログのMiddlemanを3.4.1から4.1.7にアップデートした
# title: update-middleman-4
date: 2016-04-17 19:28 JST
tags: Middleman
---

このブログいまMiddleman3.3.9で動いているわけですが、
4が[2015年の12月](https://github.com/middleman/middleman/releases/tag/v5.0.0)に出てからだいぶ時間が立ったことだし、
そろそろアップデートを敢行することにしました。

相変わらずRuby力は高くないので、一番簡単な方法を取る方針。

詳細は以下を参照すればだいたいの情報はありそうです。

> Middleman: v4 へのアップグレード  
> https://middlemanapp.com/jp/basics/upgrade-v4/

## 手順

まず`Gemfile`のバージョン指定を全部外して`bundle update`。依存しているものも含め全てが最新にアップデートされる。Middlemanは4.1.7になった。

さっそく立ち上がらない。

```
$ bundle exec middleman
/Users/username/.rbenv/versions/2.2.3/lib/ruby/gems/2.2.0/gems/bundler-1.11.2/lib/bundler/runtime.rb:80:in `rescue in block (2 levels) in require': There was an error while trying to load the gem 'middleman-inliner'. (Bundler::GemRequireError)
	from /Users/username/.rbenv/versions/2.2.3/lib/ruby/gems/2.2.0/gems/bundler-1.11.2/lib/bundler/runtime.rb:76:in `block (2 levels) in require'
	from /Users/username/.rbenv/versions/2.2.3/lib/ruby/gems/2.2.0/gems/bundler-1.11.2/lib/bundler/runtime.rb:72:in `each'
	from /Users/username/.rbenv/versions/2.2.3/lib/ruby/gems/2.2.0/gems/bundler-1.11.2/lib/bundler/runtime.rb:72:in `block in require'
	from /Users/username/.rbenv/versions/2.2.3/lib/ruby/gems/2.2.0/gems/bundler-1.11.2/lib/bundler/runtime.rb:61:in `each'
	from /Users/username/.rbenv/versions/2.2.3/lib/ruby/gems/2.2.0/gems/bundler-1.11.2/lib/bundler/runtime.rb:61:in `require'
	from /Users/username/.rbenv/versions/2.2.3/lib/ruby/gems/2.2.0/gems/bundler-1.11.2/lib/bundler.rb:99:in `require'
	from /Users/username/workspace/query_ok/vendor/bundle/ruby/2.2.0/gems/middleman-core-4.1.7/lib/middleman-core/load_paths.rb:35:in `setup_bundler'
	from /Users/username/workspace/query_ok/vendor/bundle/ruby/2.2.0/gems/middleman-core-4.1.7/lib/middleman-core/load_paths.rb:15:in `setup_load_paths'
	from /Users/username/workspace/query_ok/vendor/bundle/ruby/2.2.0/gems/middleman-cli-4.1.7/bin/middleman:10:in `<top (required)>'
	from /Users/username/workspace/query_ok/vendor/bundle/ruby/2.2.0/bin/middleman:22:in `load'
	from /Users/username/workspace/query_ok/vendor/bundle/ruby/2.2.0/bin/middleman:22:in `<main>'
```

[middleman-inliner](https://github.com/kaiinui/middleman-inliner)という
`inline_javascript`と`stylesheet_inline_tag`でインラインアセットが書けるものを使っていたが、
だいぶ更新されていないし効果も大きくないし自分で書けという感じの拡張だし、
使わないように変更・・・。そしてGemfileからmiddleman-inlinerを削除。

そしたら次のエラー。

```
$ bundle exec middleman
/Users/username/workspace/query_ok/vendor/bundle/ruby/2.2.0/gems/middleman-core-4.1.7/lib/middleman-core/extensions.rb:96:in `load': Tried to activate old-style extension: deploy. They are no longer supported. (RuntimeError)
	from /Users/username/workspace/query_ok/vendor/bundle/ruby/2.2.0/gems/middleman-core-4.1.7/lib/middleman-core/extensions.rb:127:in `block in load_settings'
	from /Users/username/workspace/query_ok/vendor/bundle/ruby/2.2.0/gems/middleman-core-4.1.7/lib/middleman-core/extensions.rb:125:in `each'
	from /Users/username/workspace/query_ok/vendor/bundle/ruby/2.2.0/gems/middleman-core-4.1.7/lib/middleman-core/extensions.rb:125:in `load_settings'
	from /Users/username/workspace/query_ok/vendor/bundle/ruby/2.2.0/gems/middleman-core-4.1.7/lib/middleman-core/extension_manager.rb:12:in `initialize'
	from /Users/username/workspace/query_ok/vendor/bundle/ruby/2.2.0/gems/middleman-core-4.1.7/lib/middleman-core/application.rb:262:in `new'
	from /Users/username/workspace/query_ok/vendor/bundle/ruby/2.2.0/gems/middleman-core-4.1.7/lib/middleman-core/application.rb:262:in `initialize'
	from /Users/username/workspace/query_ok/vendor/bundle/ruby/2.2.0/gems/middleman-cli-4.1.7/bin/middleman:48:in `new'
	from /Users/username/workspace/query_ok/vendor/bundle/ruby/2.2.0/gems/middleman-cli-4.1.7/bin/middleman:48:in `<top (required)>'
	from /Users/username/workspace/query_ok/vendor/bundle/ruby/2.2.0/bin/middleman:22:in `load'
	from /Users/username/workspace/query_ok/vendor/bundle/ruby/2.2.0/bin/middleman:22:in `<main>'
```

[middleman-deploy](https://github.com/middleman-contrib/middleman-deploy)は、サーバーに置くのではなくs3_syncでs3にホスティングするようになってから使わなくなったので、
これも単にconfig.rbとGemfileから削除しちゃう。
こちらは更新されてないわけじゃないので使えるやつ。

無事ビルトインサーバーが動いた。

```
$ bundle exec middleman
== The Middleman is loading
== Blog Sources: posts/{year}-{month}-{day}-{title}.html (:prefix + :sources)
/Users/username/workspace/query_ok/vendor/bundle/ruby/2.2.0/gems/middleman-livereload-3.4.6/lib/middleman-livereload/reactor.rb:14: warning: toplevel constant Mutex referenced by Thread::Mutex
== LiveReload accepting connections from ws://192.168.0.11:35729
== View your site at "http://localhost:4567", "http://127.0.0.1:4567"
== Inspect your site configuration at "http://localhost:4567/__middleman", "http://127.0.0.1:4567/__middleman"
```

ただ今度はsitemap.xmlを作成するときにエラーが。

```
$ bundle exec middleman
/Users/username/workspace/query_ok/vendor/bundle/ruby/2.2.0/gems/middleman-sitemap-0.0.13/lib/middleman-sitemap/extension.rb:94:in `block in encode': undefined method `escape_html' for #<Middleman::Application:0x70297247099460> (NoMethodError)
	from /Users/username/workspace/query_ok/vendor/bundle/ruby/2.2.0/gems/middleman-sitemap-0.0.13/lib/middleman-sitemap/extension.rb:94:in `map'
	from /Users/username/workspace/query_ok/vendor/bundle/ruby/2.2.0/gems/middleman-sitemap-0.0.13/lib/middleman-sitemap/extension.rb:94:in `encode'
	from /Users/username/workspace/query_ok/vendor/bundle/ruby/2.2.0/gems/middleman-sitemap-0.0.13/templates/sitemap.xml.erb:4:in `block (2 levels) in singleton class'
	from /Users/username/workspace/query_ok/vendor/bundle/ruby/2.2.0/gems/middleman-sitemap-0.0.13/templates/sitemap.xml.erb:2:in `each'
（略）
```

[middleman-sitemap](https://github.com/statonjr/middleman-sitemap)がエラー起こしてるっぽい。これも2年ぐらい更新がない。
[middleman-search\_engine\_sitemap](https://github.com/Aupajo/middleman-search_engine_sitemap)は4.0対応しているようで、こっちをいれたら治った。

## 終わりに

単純に新しくて更新されているバージョンが4系に対応していたから問題なく動いた、と言った感じでした。。
幸運にも重要でないものだったり、使っていないものだったり、代替物があったりと詰まることはなかったです。

アップデート次の差分はこちら。

> Update to middleman 4.1.7 · ikuwow/query\_ok@e7d0024  
> https://github.com/ikuwow/query_ok/commit/e7d002480a8a99031512e17d5a692f973214b563
