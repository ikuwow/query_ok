---
# title: github-widget-released
title: GitHubのcontributionを見られるウィジェットを作った
date: 2016-01-16 20:09 JST
tags: GitHub, 作った
---

GitHubの自分のcontributionをウェブサイトに埋め込めるウィジェット"**Yourcontributions**"を作りました。

> Yourcontributions: GitHub Contribution widget  
> https://ikuwow.github.io/yourcontributions/

![Yourcontributions](/img/2016-01-16_yourcontributions.png)

フォームにGitHubのユーザー名（`https://github.com/[:username:]`の部分）を入力すると
以下の様な自分のpublic contribution chartが見られるウィジェットが出力できます。

<a href="http://github.com/ikuwow" class="gh-contributions" data-gh-username="ikuwow" target="_blank">ikuwow's contributions</a><script src="https://ikuwow.github.io/yourcontributions/widget.min.js"></script>

前に書いた記事の
[毎日コードを書いてGitHubのcontributionを途切らせないようにしている](/entry/everyday-commit/)で、
自分の現在のcontributionを出していけるとよいなと思ったのがきっかけです。

横に長いウィジェットなので、多分ブログパーツとしてはあんまり使いやすくないですが、
常に見えるところに出していくとコミットを途切らせない危機感が芽生えてとてもよいです。
