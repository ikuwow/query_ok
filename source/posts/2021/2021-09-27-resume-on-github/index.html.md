---

# title: resume-on-github
title: 職務経歴書をGitHubに公開してpdfを生成するようにした
date: 2021-09-27 17:20 JST
tags: career
thumbnail:

---


休職期間も終わりに近づいて元気さが取り戻されてきて、キャリアの棚卸しをしようという気持ちになったので、具体的にアウトプットを伴う活動として、職務経歴書を作ってGitHubにぶち上げるということをした。

> ikuwow/resume: 職務経歴書  
> https://github.com/ikuwow/resume

自分が積み重ねてきたものを改めて見て、ではこれから何を積み重ねていこうかという思考の材料になりそうでよかった。

## どこに作るか

ざっくり要件は2つ：

1. Webブラウザから見られる
	* 自分に興味を持った人が具体的な情報をすぐ見られるようにするためにね
2. PDF出力が出来る
	* 会社に送るなどするときはPDFで求められることが多いからね

最終的にはGitHub上で全てやるようにしたが、初めはよくある職務経歴書を生成できるツールは試しながら迷っていた。

その辺の日本の転職エージェントが出してる職務経歴書ジェネレータは、あまり自分の書きたいものができそうにはなかった。
ソフトウェアエンジニア向きなフォーマットでないものがほとんどだし、向けのものでも項目やフォーマットがピンとこなかった。
いわゆるシューカツっぽい「アピールポイント」とか「志望動機」とかを書きたくなかったのだ。

KickresumeやZety、Novoresumeなども試したが、やっぱり全体の見出しの種類も細かいフォーマット（日付とか）もイマイチだった。
USAのいわゆるresumeとかcurriculum vitaeを作るのには便利そうではあった。
職務経歴書としては国内の人向けに作るつもりなので、細かい調整がきかないこのあたりは却下。

自分の納得いく内容や構成で書きたい気持ちが強かったので、それならまあ自分で作ろうとなった。

## GitHubに作る

内容を優先することにしたので見た目へのこだわりは捨てて、単純にMarkdownで書けるのが楽だろう、MarkdownならGitHubに置くとある程度見やすくなるし変更管理もしやすくて便利だろうということでGitHubにした。

GitHub Pagesで表示する案もあったが、PDF出力をするとなると印刷用のスタイルも作る必要があるので却下。

職務経歴書をMarkdownで書いてGitHubで公開をしている例はいくらか見つかったので参考にした。

* [GitHubの機能をフルに使って職務経歴書の継続的インテグレーションを実現する](https://zenn.dev/ryo_kawamata/articles/resume-on-github)
* [GitHubで職務経歴書を公開してみました｜Koushi Kagawa｜note](https://note.com/koushikagawa/n/n0cab6bebc80d)
* [GitHub - mikeda/resume: 職務経歴書](https://github.com/mikeda/resume)
* [履歴書をMarkdownで作って転職活動する | DevelopersIO](https://dev.classmethod.jp/articles/markdown-cv/)
* [【エンジニア向け】職務経歴書をMarkdownで作成し、保存のたびに自動PDF形式で出力されるようにする方法｜名無しのジョン@プロフ詳細に経歴書有｜note](https://note.com/iga34engineer/n/n7df9e8883fc5)

PDF生成はmd-to-pdfがべんり。
ヘッダ・フッタの生成やスタイルの指定などある程度柔軟にできる。

> Markdown to PDF
> https://github.com/simonhaenisch/md-to-pdf

ヒラギノが使いたさにGitHub ActionsのmacOS Runnerを使った。無料でよかった。

## まとめ

最終的にいい感じに仕上がったと思う。

> ikuwow/resume: 職務経歴書  
> https://github.com/ikuwow/resume

次は英語でも職務経歴書を書こうかしら。
