(function(d){

    lazyload_css = function(filename,add_querystring) {

        if (filename.substr(-4,4)!=='.css') {
            filename = filename+'.css';
        }

        var c = d.createElement('link');
        c.type = 'text/css';
        c.rel = 'stylesheet';

        if (add_querystring===true) {
            var date = new Date();
            var param = date.getFullYear().toString()+(date.getMonth()+1).toString()+date.getDate().toString();
            c.href = filename+'?date='+param;
        } else {
            c.href = filename;
        }
        var s = d.getElementsByTagName('head')[0];
        s.appendChild(c);
    };

    lazyload_css('/stylesheets/highlight',true);
    lazyload_css('//maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css');

})(document);
