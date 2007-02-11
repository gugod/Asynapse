if ( typeof Asynapse == 'undefined' ) {
    Asynapse = {}
}

Asynapse.Emoticon = function ( type, options ) { }

Asynapse.Emoticon.prototype = {
        filter: function(text) {
            var self = this;
            return text.replace(this.pattern(), function(icon) {
                return self.do_filter(icon)
            });
        },
        do_filter: function(icon) {
            var xhtml = this.config.xhtml ? " /" : ""
            var img_class = this.config.class ?
                (' class="' + this.config.class + '"') : ""

            return "<img src=\""
                + this.config.imgbase + "/"
                + this.map[icon]
                + '" '
                + img_class
                + xhtml
                + '>'
        },
        pattern: function () {
            if ( !this._pattern ) {
                var icons = [];
                for(i in this.map) {
                    icons.push( this.quotemeta(i) )
                }
                this._pattern = new RegExp( "(" + icons.join("|") +")"  ,"g")
            }
            return this._pattern
        },
        quotemeta: function ( str ) {
            var safe = str;
            var bs=String.fromCharCode(92);  
            var unsafe= bs + "|-.+*?[^]$(){}=!<>¦:";  
            for ( i=0; i<unsafe.length; ++i ){  
                safe = safe.replace(new RegExp("\\"+unsafe.charAt(i),"g"),
                                    bs + unsafe.charAt(i));
            }
            return safe;
        }
}

Asynapse.Emoticon.GoogleTalk = new Asynapse.Emoticon();

Asynapse.Emoticon.GoogleTalk.config = {
        'imgbase' : "http://mail.google.com/mail/help/images/screenshots/chat",
        'xhtml'   : 1,
        'strict'  : 0,
        'class'   : null
}

Asynapse.Emoticon.GoogleTalk.map = {
        "<3" : "heart.gif",
        ":(|)" : "monkey.gif",
        "\\m/" : "rockout.gif",
        ":-o" : "shocked.gif",
        ":D" : "grin.gif",
        ":(" : "frown.gif",
        "X-(" : "angry.gif",
        "B-)" : "cool.gif",
        ":'(" : "cry.gif",
        "=D" : "equal_grin.gif",
        ";)" : "wink.gif",
        ":-|" : "straightface.gif",
        "=)" : "equal_smile.gif",
        ":-D" : "nose_grin.gif",
        ";^)" : "wink_big_nose.gif",
        ";-)" : "wink_nose.gif",
        ":-)" : "nose_smile.gif",
        ":-/" : "slant.gif",
        ":P" : "tongue.gif"
}
