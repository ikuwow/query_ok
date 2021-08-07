---

# title: http-request-using-simple-js
title: ピュアなJSでAPIリクエストをするメモ（jsonとjsonp）
date: 2021-08-07 11:43 JST
tags: Qiita,HTTP,JavaScript
thumbnail:

---

この記事は2016年1月6日Qiitaに投稿した以下の記事を転記したものです。

> ピュアなJSでAPIリクエストをするメモ（jsonとjsonp）
> https://qiita.com/ikuwow/items/ed5f3c9ee0bd6147b7f3

---


いつも忘れるので、メモ。

フロントエンドJavaScriptからAPIを叩いてレスポンスを受け取って、コールバックを呼び出すまで。

## JSONのデータをリクエスト

```js
(function(){
var xhr = new XMLHttpRequest();
xhr.onreadystatechange = function(){
    if (this.readyState==4 && this.status==200) {
        // responseをhogehogeする
    }
};
xhr.responseType = 'json';
xhr.open('GET',endpoint,true);
xhr.send();
})();
```

毎回書くのは面倒なので、簡単でよいなら以下の様な関数を作ったりしている。

```js
(function(){

var requestAjax = function(endpoint, callback) {
    var xhr = new XMLHttpRequest();
    xhr.onreadystatechange = function(){
        if (this.readyState==4 && this.status==200) {
            callback(this.response);
        }
    };
    xhr.responseType = 'json';
    xhr.open('GET',endpoint,true);
    xhr.send();
};
})();

requestAjax("http://example.com/endpoint1", function(response){
    // responseをhogehogeする
});
requestAjax("http://example.com/endpoint2", function(response){
    // responseをhogehogeする
});
```

## JSONP

APIがCORSに対応していない場合はJSONPのオプションが用意されていたりします。

JSONPの場合scriptタグからリクエストします。

（InstagramのAPIを触った時のコードをそのまま入れます）

```js
(function(){
    var script = document.createElement('script');
    script.src = 'https://api.instagram.com/v1/users/5001435/media/recent/?access_token='+accessToken+'&callback=instaCallback';
    window.instaCallbackFavorites = function(response) {
        // reponseをhogehogeする
    };
    document.body.appendChild(script);
})();
```

（ちなみにアクセストークンをフロントに渡してしまうのは危険なので推奨しません）

