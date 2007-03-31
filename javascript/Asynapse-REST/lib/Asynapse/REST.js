Asynapse = {}

Asynapse.REST = {}

Asynapse.REST.Model = function(model) {
    this._model = model
    this._attributes = {}
}

Asynapse.REST.Model.prototype = {
    /* ActiveRecord-like API */
    new: function() {
        return this;
    },
    
    find: function(param) {
        if ( typeof param == 'number' ) {
            return this.show_item("id", param)
        }
    },

    find_by_id: function(id) {
        return this.show_item("id", id)
    },

    write_attribute: function(attr, value) {
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

    create_item: function(item) {
        var url ="/=/model/*.js"
            .replace("*", this._model)

        new Ajax.Request(url, {
            method: 'post',
            asynchronous: false,
            postBody: $H(item).toQueryString()
        });
    },
    
    replace_item: function(item) {
        var url = "/=/action/update" + this._model + ".js"
        new Ajax.Request(url, {
            method: 'post',
            contentType: 'application/x-www-form-urlencoded',
            postBody: $H(item).toQueryString()            
        });
    },

    delete_item: function(column, key) {
        var url = "/=/model/*/*/*"
            .replace("*", this._model)
            .replace("*", column)
            .replace("*", key)
        
        new Ajax.Request(url, {
            method: 'DELETE',
            contentType: 'application/x-www-form-urlencoded'
        });
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

