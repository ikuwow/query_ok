(function(){
'use strict';

var img_tags = document.getElementById('article-body').getElementsByTagName('img');

var click_event = function(tag){
    return function(){

        var modal_window = document.createElement('section');
        modal_window.className = 'modal-window';

        var modal_inner = document.createElement('div');
        modal_inner.className = 'modal-inner';

        // バツボタン生成
        var modal_vanish = document.createElement('span');
        modal_vanish.innerHTML = '×';

        var modal_image = tag.cloneNode();

        modal_inner.appendChild(modal_image);
        modal_window.appendChild(modal_inner);
        modal_window.appendChild(modal_vanish);

        tag.parentNode.appendChild(modal_window);

        // このモーダルをゆっくり出現させる

        // バツ押したらmodalをゆっくり閉じる
    };
};

for (var itr=0; itr < img_tags.length; itr++) {
    // console.log(img_tags[itr]);
    var img_tag = img_tags[itr];
    img_tag.addEventListener('click',click_event(img_tag));
}

})();
