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
    show_item_field: function(column, key, field) {
        var url = "/=/model/*/*/*/*.js"
            .replace("*", this._model)
            .replace("*", column)
            .replace("*", key)
            .replace("*", field)

        return this.eval_ajax_get(url);        
    },
    
    show_item: function(column, key) {
        var url = "/=/model/*/*/*.js"
            .replace("*", this._model)
            .replace("*", column)
            .replace("*", key)

        return this.eval_ajax_get(url);
    },

    list_model_items: function(column) {
        var url = "/=/model/*/*.js"
            .replace("*", this._model)
            .replace("*", column)

        return this.eval_ajax_get(url);
    },

    list_model_columns: function() {
        var url = "/=/model/*.js"
            .replace("*", this._model)

        return this.eval_ajax_get(url);
    },

    list_models: function() {
        var url = "/=/model.js"

        return this.eval_ajax_get(url);
    },

    /* Internal Helpers */
    eval_ajax_get: function(url) {
        console.log(url)
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

