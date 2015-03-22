---
title: MiddlemanとPureとその他もろもろでブログ作った
date: 2015-03-22 22:32 JST
tags: Middleman, YAML, Pure
published: false
---

自分の発信の場として技術ブログをきちんと立ち上げようと思って、
何がいいか探していたらMiddlemanに出会って素晴らしかったのでブログを作ってみたという話。

WordPressのブログは持っていて技術に限らず雑多にいろんなことを書いていたけれど、
WordPressはオブジェクト指向じゃない古いPHPが元になっていてハックする気にならないし、
はてなブログなどのサービスだとどうしても微妙なところに不満が出てきてしまう。

そこで見つけたのがMiddleman。
ブログ作成ツールというよりも、静的ページ作成ツール。
公式のmiddleman-blogというプラグインでブログを作っている例が多い。
こいつが非常に自分が好きなタイプで、これで最後までブログを作った。

## Middlemanすばらしい

公式サイトは日本語対応もしていて助かる。チュートリアルにはお世話になりました。

> Middleman：https://middlemanapp.com/jp/

erbでレイアウトを書いて、yamlとMarkdownで記事を書く。
書いたら`middleman build`でHTML等を生成。
やはりMarkdownで書けるのは気持ちいい。
当然シンタックスハイライトにも対応。

ディレクトリ構成は以下のようになっている。公式ドキュメントから引用。

```
mymiddlemansite/
+-- .gitignore
+-- Gemfile
+-- Gemfile.lock
+-- config.rb
+-- source
    +-- images
    ¦   +-- background.png
    ¦   +-- middleman.png
    +-- index.html.erb
    +-- javascripts
    ¦   +-- all.js
    +-- layouts
    ¦   +-- layout.erb
    +-- stylesheets
        +-- all.css
        +-- normalize.css
```

こんな風に、Jekyllと違ってとってもシンプル。

主にsourceディレクトリ内のerbやcss、javascriptを触り、
`middleman build`すると`/build`ディレクトリが生成され、
中にHTMLやCSSなどの静的ファイルが作成される。

middleman-deployというプラグインを使えばデプロイも簡単になる。
GitHub Pagesと合わせて`git push origin master`でデプロイするように運用すると、
バージョン管理とデプロイが同時にできてよい。
エディタもいつも開発で使うものを使うだろうから、本当にいつもの開発の流れと同じようにブログ記事を執筆できる。

また`middleman server`でビルトインサーバーが使えるので手間がない。
しかも自動リロード機能付き。ガシガシMarkdownで書くのに本当に役に立つやつです。

業務などだと企業のコーポレートサイトとかを作るのにもいいかもしれない。
どうやらMiddlemanは日本でも海外でもそこまで知名度は高くないようで、
これからの発展に期待。


Middlemanはもっと普及すべき！

## Pure.css

PureフレームワークはYahooが作っているCSSフレームワーク。
BootstrapやFoundationと違って本当にCSSしか含まない、
最小で4.0KBの超軽量フレームワーク。
ひたすらシンプルなところを気に入った。

> Pure.css：http://purecss.io

実はこのブログのデザインはPureの公式ページに載っているBlogレイアウトをかなり参考にしている。
YahooはYUIライブラリの開発を終了したといつか発表されたが、
Pureの方は最近もどんどん開発が進んでいる。記事執筆現在バージョンは0.6.0。



