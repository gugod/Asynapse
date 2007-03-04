package Catalyst::Controller::AsynapseTextDiff;
use strict;
use warnings;

use Algorithm::Diff qw(sdiff);
use YAML;
use base 'Catalyst::Controller::REST';

__PACKAGE__->config->{'serialize'}->{'default'} = 'JSON::Syck';
__PACKAGE__->config->{'deserialize'}->{'default'} = 'JSON::Syck';

sub index :Regex('^=/(AsynapseTextDiff|(text)?diff)') :ActionClass("REST") { }

sub index_POST {
    my ( $self, $c ) = @_;

    my $text1 = [split "\n", $c->request->data->{text1}];
    my $text2 = [split "\n", $c->request->data->{text2}];

    my $diff  = sdiff($text1, $text2);
    $self->status_ok(
        $c,
        entity => $diff
    );
}



1;
