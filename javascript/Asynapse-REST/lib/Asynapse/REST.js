Asynapse = {}

Asynapse.REST = {}

Asynapse.REST.Model = function(model) {
    this._model = model
}

Asynapse.REST.Model.prototype = {
    /* ActiveRecord-like API */
    find: function(param) {
        if ( typeof param == 'number' ) {
            return this.show_item("id", param)
        }
    },

    find_by_id: function(id) {
        return this.show_item("id", id)
    },

    /* Jifty API */
    show_item: function(column, value) {
        var url = "/=/model/%MODEL/%COLUMN/%VALUE.js"
            .replace("%MODEL", this._model)
            .replace("%COLUMN", column)
            .replace("%VALUE", value)

        return this.eval_ajax_get(url);
    },

    list_model_items: function(column) {
        var url = "/=/model/%MODEL/%COLUMN.js"
            .replace("%MODEL", this._model)
            .replace("%COLUMN", column)

        return this.eval_ajax_get(url);
    },

    /* Internal Helpers */
    eval_ajax_get: function(url) {
        eval(this.ajax_get(url));
        return $_;
    },
    ajax_get: function(url) {
        var req = new Ajax.Request(url, {
            method: 'GET',
            asynchronous: false
        })
        return req.transport.responseText;
    }

}

