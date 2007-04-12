package Jifty::Plugin::Asynapse::Action::TextDiff;
use strict;
use warnings;
use base 'Jifty::Action';
use Jifty::Param::Schema;
use Algorithm::Diff qw(sdiff);

use Jifty::Action schema {
    param text1 =>
        default is "";
    param text2 =>
        default is "";
};

sub take_action {
    my $self = shift;
    my ( $text1, $text2 )
        = map { [ split "\n", $self->argument_value($_) ]; }
        qw(text1 text2);
    my $diff = sdiff( $text1, $text2 );
    $self->result->content( diff => $diff );
}


1;

