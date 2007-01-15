/**

=head1 NAME

Asynapse.File - Javascript File implementation.

=head1 SYNOPSIS

    # Global configuration
    Asynapse.File.setConfig({
        model: "http://my.foo.bar/=/model/File/"
    });

    # OO way
    f = new Asynapse.File;
    f.open("hello.txt");
    f.println("Hello world");
    f.close();

=head1 DESCRIPTION

=head1 API

=over 4

=item open

Open a file, an internal file handle is created as a reference to that
file. Each Asynapse.File object can only associate to one file at a
time.

Return true on successful opening, false otherwise.

=item close

Close current opening filehandle. If there is no file handle associate
to this object, do nothing and simply return true.

=item getline

Read up to next newline character, and include it.

=item slurp

Slurp whole file content at once. Return a string.

=item size

Return the size in number of unicode characters.

=item print( string )

write given string into the file.

=item println( string )

Same as print, but always append a newline.

=back

=head1 COPYRIGHT

=cut

*/

if ( typeof Asynapse == 'undefined' )
    Asynapse = {};

Asynapse.File = function() {
    this.setConfig( Asynapse.File.config );
    return this;
}

// Configuration stub,
Asynapse.File.config = {
    model: "UNKNOWN"
};

Asynapse.File.setConfig = function (config) {
    for(key in config) {
        Asynapse.File.config[key] = config[key]
    }
}

// Class methods

Asynapse.File.slurp = function ( path ) {
    var f = new Asynapse.File();
    f.open(path);
    return f.slurp();
}

Asynapse.File.exists = function ( path ) {
    var f = new Asynapse.File();
    return f.exists(path);
}


// Object methods.
Asynapse.File.prototype = {}

var _ = Asynapse.File.prototype

// Helper methods
_.setConfig = function (config) {
    this.config = {};
    for(key in config) {
        this.config[key] = config[key]
    }
}

_.uri_for = function ( param ) {
    if ( !param['path'] ) {
        throw("'path' param is reqruied.");
    }
    return this.config.model + "/name/" + param['path']
        + ( param["field"] ? ("/" + param["field"] + ".js")  : "" );
}

_.request_for = function ( param ) {
    return new HTTP.Request({
        method: 'get',
        asynchronous: false,
        uri: this.uri_for( param )
    });
}

// Interface methods
_.exists = function ( path ) {
    var req = this.request_for({ "path": path, "field": 'name' });
    if ( req.isSuccess() ) {
        return true;
    }
    return false;
}

_.open = function ( path, mode ) {
    var req = this.request_for({ "path": path, "field": 'name' });
    this.handle = {
        path: path,
        mode: mode,
        exists: false
    }

    if ( req.is_success ) {
        this.handle.exists = true;
    } else {
    }
    
    this.handle.opened = true;
    return true;
}

_.close = function () {
    this.handle = {}
    return true;
}

_.slurp = function () {
    var req = this.request_for({ "path": this.handle.path, "field": "content" });
    if ( req.isSuccess() ) {
        // This js is jifty-specific. Other framework may not generating
        // js using $_ variable.
        eval(req.transport.responseText);
        this.handle.file_content = $_;
    } else {
        this.handle.file_content = null;
    }
    return this.handle.file_content;
}

_.write = function (  ) {
    
}

_.seek = function ( pos ) {
    
}
