package Asynapse::Record;
use strict;
use warnings;
use Moose;
use LWP::UserAgent;
use JSON::Syck;
$JSON::Syck::ImplicitUnicode = 1;

has url_root => ( is => 'rw', isa => 'Str' );
has model => ( is => 'rw', isa => 'Str' );

sub find {
    my $self = shift;
    $self = $self->new unless ref($self);
    my $id = shift;
    return _get("@{[$self->url_root]}/=/model/@{[$self->model]}/id/${id}.json");
}

sub udpate {
    my $self = shift;
}

sub delete {
    my $self = shift;
}

sub _get {
    my $url = shift;
    my $ua = LWP::UserAgent->new;
    my $r = $ua->get($url);
    if ($r->is_success) {
        return JSON::Syck::Load($r->content);
    } else {
        die $r->status_line;
    }
}

1;

