if ( typeof Asynapse == 'undefined' ) {
    Asynapse = {}
}

Asynapse.TextDiff = function() {
    this.init.apply(this, arguments)
}

Asynapse.TextDiff.config = {
    url: "/=/diff/"
}

Asynapse.TextDiff.setConfig = function ( config ) {
    var k
    for(k in config) {
        Asynapse.TextDiff.config[k] = config[k]
    }
}

Asynapse.TextDiff.prototype = {
    init: function(one, two) {
        this.config = Asynapse.TextDiff.config
        var req = new XMLHttpRequest()
        req.open('POST', this.config.url , false)
        req.setRequestHeader("Content-Type", "text/x-json; charset=UTF-8")
        req.send(JSON.stringify({ text1: one, text2: two }));
        if ( req.readyState == 4 )
            if ( req.status == 200 )
                eval("this.data = " + req.responseText);
        return this;
    },
    to_html: function() {
        var classmap = { '+': 'added', '-': 'deleted', 'u': 'unified', 'c': 'changed' };
        var ret = "<table class=\"asynapse-textdiff\"><tr><th>Left</th><th>&nbsp;</th><th>Right</th></tr>";
        for(var i = 0; i < this.data.length; i++) {
            ret += "<tr class=\"%\">".replace(/%/, classmap[this.data[i][0]]);
            ret += "<td class=\"left\">" + this.data[i][1] + "&nbsp;</td>";
            ret += "<td class=\"op\">" + this.data[i][0] + "&nbsp;</td>";
            ret += "<td class=\"right\">" + this.data[i][2] + "&nbsp;</td>";
            ret += '</tr>'
        }
        ret += '</table>';
        return ret;
    }
}

if (window.ActiveXObject && !window.XMLHttpRequest) {
    window.XMLHttpRequest = function() {
        var name = (navigator.userAgent.toLowerCase().indexOf('msie 5') != -1)
            ? 'Microsoft.XMLHTTP' : 'Msxml2.XMLHTTP';
        return new ActiveXObject(name);
    }
}
