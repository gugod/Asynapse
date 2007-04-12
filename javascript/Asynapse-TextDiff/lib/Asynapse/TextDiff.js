if ( typeof Asynapse == 'undefined' ) {
    Asynapse = {}
}

Asynapse.TextDiff = function() {
    this.init.apply(this, arguments)
}

Asynapse.TextDiff.config = {
    url: "/=/action/TextDiff.json"
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
        var req = new Ajax.Request(this.config.url, {
            method: 'post',
            asynchronous: false,
            postBody: $H({
                'text1': one,
                'text2': two
            }).toQueryString()
        });
        eval("this.result = " + req.transport.responseText);
        this.data = this.result.content.diff
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

