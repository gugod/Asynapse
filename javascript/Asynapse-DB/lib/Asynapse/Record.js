/*

=head1 SYNOPSIS

  var db = new Asynapse.DB({ uri: "http://..." });

  var Person = new Asynapse.Record({ DB: db });

  var Person = new Asynapse.Record.Person();

  var bob = Person.find("first", { "name=?", "bob" } );
  bob.salary += 300;
  bob.save();

  var it = Person.find("all");
  

=cut

 */

Asynapse.Record = function() {
    return this.new;
}

Asynapse.Record.prototype.new = function( param ) {
    this.setConfig( param );
}

Asynapse.Record.prototype.setConfig = function( param ) {
}

Asynapse.Record.prototype.find = function( param ) {
    var uri = '/=/model/*/*';
}

