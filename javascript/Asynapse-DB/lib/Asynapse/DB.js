// Setup Namespace
if ( typeof Asynapse == 'undefined' ) {
    var Asynapse = {};
}

Asynapse.DB = function () {
}

Asynapse.DB.VERSION = "0.0.1";

Asynapse.DB.PROTOCOLS = {
    load: {
        action: 'load'
    }
}

Asynapse.DB.prototype = {
    init: function( config ) {
        this.setConfig( config );
    },
    
    setConfig: function( config ) {
// Required config keys:
//    server
        this.config = {};
        for(key in config) {
            this.config[key] = config[key]
        }
    },
    
    requestLoad: function() {
        var self = this;
        var resultJSON = Ajax.get( this.urlFor('load') );
        var result = eval('('+resultJSON+')');
        return result;
    },
    
    urlFor: function( action ) {
        var url = this.config.server + '?';
        for(key in Asynapse.DB.PROTOCOLS[action]) {
            url += key + '=' + Asynapse.DB.PROTOCOLS[action][key] + ';'
        }
        return url;
    }
}

