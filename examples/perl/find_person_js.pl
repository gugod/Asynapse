#!/usr/bin/perl

package Person;
use JavaScript::Code;

sub find {
    my ($self, $id) = @_;
    my $out = "";

    $out .= "{\n";
    $out .= <<JS;
  new Ajax.Request("http://localhost:8888/=/model/person/id/${id}.json",{
    onSuccess:function(transport) {
      alert(transport.responseText);
    }
  });
JS
    $out .= "}\n";

    print $out;
}

package main;
use Data::Dumper;

Person->find(1);



