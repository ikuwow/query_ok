---

# title: gitignore-with-xcode
title: XcodeでiOSアプリ開発をする時の.gitignore
date: 2021-08-14 11:46 JST
tags: Qiita,Xcode,git
thumbnail:

---

この記事は、2014年11月02日にQiitaで投稿した以下の記事を転記したものです。

> XcodeでiOSアプリ開発をする時の.gitignore  
> https://qiita.com/ikuwow/items/4fae81a099bf82f44749

---

開発デバイスごとに落ちる箇所が変わるという謎現象に見舞われ、.gitignoreファイルを見なおしてみた。

http://github.com/github/gitignore というGitHub公式のリポジトリがあり、そこに各言語やIDEのためのgitignoreの書き方が載っているので、ここに従う。
http://gitignore.io という指定したIDEなどのgitignoreを出力してくれるWebインターフェースもある。

最終的に以下のようにして、エラーがでなくなることを確認した。

```
# Xcode (from gitignore.io)
build/
*.pbxuser
!default.pbxuser
*.mode1v3
!default.mode1v3
*.mode2v3
!default.mode2v3
*.perspectivev3
!default.perspectivev3
xcuserdata
*.xccheckout
*.moved-aside
DerivedData
*.hmap
*.ipa
*.xcuserstate

# CocoaPod
Pods/*

# others
*.swp
!.gitkeep
.DS_Store
```

`Xcode`セクションは完全にお手本どおり。`others`は定番の。

それにしても、Xcode側でgitリポジトリを作って管理する機能があるなら、.gitignoreも自動的に生成して欲しいものです。
