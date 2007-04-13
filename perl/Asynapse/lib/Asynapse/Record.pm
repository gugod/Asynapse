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

sub ua { return LWP::UserAgent->new; }

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

    ua()->post(
        "@{[$self->url_root]}/=/action/update@{[$self->model]}.json",
        $orig
    );

    return {};
}

sub create {
    my $self = shift;
    my $attributes = shift;

    $self = $self->new unless ref($self);

    my $r = ua->post(
        "@{[$self->url_root]}/=/model/@{[$self->model]}.json",
        $attributes
    );

    if ($r->is_success) {
        my $data = JSON::Syck::Load( $r->content );
        my $id = $data->{content}{id};
        return $self->find($id);
    } else {
        die $r->status_line;
    }
}

sub delete {
    my $self = shift;
    my $id = shift;

    $self = $self->new unless ref($self);

    ua->request(
        HTTP::Request->new(
            "DELETE",
            "@{[$self->url_root]}/=/model/@{[$self->model]}/id/$id.json",
        )
    );
    return {};
}

sub _get {
    my ($url) = @_;
    my $r = ua->get( $url );

    if ($r->is_success) {
        return JSON::Syck::Load($r->content);
    } else {
        return {}
    }
}

1;

