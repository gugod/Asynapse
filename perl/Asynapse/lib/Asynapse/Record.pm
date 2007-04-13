package Asynapse::Record;
use strict;
use warnings;
use Moose;
use LWP::UserAgent;
use HTTP::Request;
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

sub update {
    my $self = shift;
    $self = $self->new unless ref($self);
    my $id = shift;
    my $attributes = shift;

    my $orig = $self->find($id);
    $orig = { %$orig, %$attributes };

    _ua()->post(
        "@{[$self->url_root]}/=/action/update@{[$self->model]}.json",
        $orig
    );

    return {};
}

sub delete {
    my $self = shift;
}

sub _ua {
    return LWP::UserAgent->new;
}

sub _get {
    my ($url) = @_;
    my $r = _ua->get( $url );

    if ($r->is_success) {
        return JSON::Syck::Load($r->content);
    } else {
        die "$url => " . $r->status_line;
    }
}

1;

