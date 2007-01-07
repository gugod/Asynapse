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

Asynapse.File.prototype = {}

var _ = Asynapse.File.prototype

_.url_for = function ( op ) {
}

_.setConfig = function (config) {
    this.config = {};
    for(key in config) {
        this.config[key] = config[key]
    }
}

_.exists = function ( path ) {
    var uri = this.config.model + "/name/" + path + "/name";
    var req = new HTTP.Request({
        method: 'get',
        asynchronous: 'false',
        uri: uri
    });

    if ( req.is_success ) {
        return true;
    }
    return false;
}

_.open = function ( path, mode ) {
    var req = new HTTP.Request({
        method: 'get',
        asynchronous: 'false',
        uri: this.config.model + "/name/" + path + "/name"
    });

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
    var req = new HTTP.Request({
        method: 'get',
        asynchronous: 'false',
        uri: this.config.model + "/name/" + this.handle.path + "/content"
    });
    
    if ( req.isSuccess() ) {
        this.handle.file_content = req.transport.responseText;
        return this.handle.file_content;
    } else {
    }
}

_.write = function (  ) {
    
}

_.seek = function ( pos ) {
    
}

_.slurp = function (  ) {
    
}
