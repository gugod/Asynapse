Asynapse = {}

Asynapse.REST = {}

Asynapse.REST.Model = function(model) {
    this._model = model
    return this;
}

Asynapse.REST.Model.prototype = {
    /* Corresponds Jifty's REST Pluing API */
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

        var req = new Ajax.Request(url, {
            method: 'post',
            asynchronous: false,
            postBody: $H(item).toQueryString()
        });
        if ( req.responseIsSuccess() ) {
            eval(req.transport.responseText);
            return $H($_)
        } else {
            return null;
        }
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
        return null;
    },
    
    /* Internal Helpers */
    eval_ajax_get: function(url) {
        eval(this.ajax_get(url));
        return $_ ? $H($_) : null;
    },
    ajax_get: function(url) {
        var req = new Ajax.Request(url, {
            method: 'GET',
            asynchronous: false
        })
        if ( req.responseIsSuccess() ) {
            return req.transport.responseText;
        }
        else {
            return "var $_ = null";
        }
    }
}

Asynapse.REST.Model.ActiveRecord = function(model) {
    Object.extend(this, new Asynapse.REST.Model(model));
    this._attributes = {}
    return this;
}

Asynapse.REST.Model.ActiveRecord.prototype = {
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

    create: function(attributes) {
        var r = this.create_item(attributes);
        if (r.success) {
            return this.find( Number(r.content.id) )
        }
        return null;
    },

    delete: function(id) {
        this.delete_item(id);
        return null;
    },

    update: function(id, attributes) {
        var attr = $H(attributes);
        return this.replace_item( attr );
    },

    write_attribute: function(attr, value) {
    }
}
