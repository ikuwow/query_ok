(function(d){

    lazyload_css = function(filename) {

        if (filename.substr(-4,4)!=='.css') {
            filename = filename+'.css';
        }
        var date = new Date();
        var param = date.getFullYear().toString()+(date.getMonth()+1).toString()+date.getDate().toString();
        var c = d.createElement('link');
        c.type = 'text/css';
        c.rel = 'stylesheet';
        c.href = filename+'?date='+param;
        var s = d.getElementsByTagName('head')[0];
        s.appendChild(c);
    };

    lazyload_css('/stylesheets/highlight');
    lazyload_css('//maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css');
    lazyload_css('//yui.yahooapis.com/pure/0.6.0/grids-responsive-min.css');

})(document);
