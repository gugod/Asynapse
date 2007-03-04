if ( typeof Asynapse == 'undefined' ) {
    Asynapse = {}
}

Asynapse.TextDiff = function() {
    this.init.apply(this, arguments)
}

Asynapse.TextDiff.prototype = {
    init: function(one, two) {
        var req = new XMLHttpRequest()
        req.open('POST', "/=/diff/", false)
        req.setRequestHeader("Content-Type", "text/x-json")
        req.send({ text1: one, text2: two }.toJSONString())
        if ( req.readyState == 4 ) {
            if ( req.status == 200 ) {
                var data;
                eval("data = " + req.responseText);
                this.data = data;
            }
        }
        return this;
    },
    to_html: function() {
        var ret = "<table border=\"1\"><tr><td></td><td>Left</td><td>Right</td></tr>";
        for(var i = 0; i < this.data.length; i++) {
            ret += '<tr>'
            ret += "<td>" + this.data[i][0] + "&nbsp;</td>";
            ret += "<td>" + this.data[i][1] + "&nbsp;</td>";
            ret += "<td>" + this.data[i][2] + "&nbsp;</td>";
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
