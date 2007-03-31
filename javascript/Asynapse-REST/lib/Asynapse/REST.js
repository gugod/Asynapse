Asynapse = {}

Asynapse.REST = {}

Asynapse.REST.Model = function(model) {
    this._model = model
}

Asynapse.REST.Model.prototype = {
    /* ActiveRecord-like API */
    find: function(id) {
        return this.show_item("id", id)
    },

    /* Jifty API */
    show_item: function(field, value) {
        var url = "/=/model/%MODEL/%FIELD/%VALUE.js"
            .replace("%MODEL", this._model)
            .replace("%FIELD", field)
            .replace("%VALUE", value)

        var req = new Ajax.Request(url, {
            method: 'GET',
            asynchronous: false
        })
        eval( req.transport.responseText );
        return $_;
    }
}

