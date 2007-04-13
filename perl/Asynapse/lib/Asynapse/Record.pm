package Asynapse::Record;
use strict;
use warnings;
use v5.8.8;

use Moose;
use LWP::UserAgent;
use HTTP::Request;
use JSON::Syck;
$JSON::Syck::ImplicitUnicode = 1;

our $VERSION = '0.0.1';

has url_root => ( is => 'rw', isa => 'Str' );
has model => ( is => 'rw', isa => 'Str' );

sub _ua { return LWP::UserAgent->new; }

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

sub create {
    my $self = shift;
    my $attributes = shift;

    $self = $self->new unless ref($self);

    my $r = _ua->post(
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

    _ua->request(
        HTTP::Request->new(
            "DELETE",
            "@{[$self->url_root]}/=/model/@{[$self->model]}/id/$id.json",
        )
    );
    return {};
}

sub _get {
    my ($url) = @_;
    my $r = _ua->get( $url );

    if ($r->is_success) {
        return JSON::Syck::Load($r->content);
    } else {
        return {}
    }
}

1;
__END__

=head1 NAME

Asynapse::Record - Asynapse REST Model Client with API similar to ActiveRecord

=head1 VERSION

This document describes Asynapse::Record version 0.0.1

=head1 SYNOPSIS

    # Define Your own AsynapseRecord Class.
    package Person;
    use Moose;
    extends 'Asynapse::Record';
    has url_root => ( default => "http://localhost:3001" );
    has model => ( default => "person" );

    # Use it
    my $p = Person->find(1)

=head1 DESCRIPTION

This module uses similar interface as ActiveRecord to access your
data.  So far it has only 4 useful class methods: find, update,
create, delete.  The major difference between AsynapseRecord and
other DBI abstraction layers are, in fact, AsynapseRecord isn't a
DBD. It manipulate data on an http server using REST requests. It's
a REST client that is specialized for manipulating data.

To use this module, define your own record class like this:

    package Person;
    use Moose;
    extends 'Asynapse::Record';
    has url_root => ( default => "http://localhost:3001" );
    has model => ( default => "person" );

You need to supply the default value of "url_root" and "model" in
there. At this moment, the value of url_root should point to a Jifty
instance with REST plugin installed. And the value of "model" should
be the same name as one of those models in that Jifty instance.

The usage looks like this:

    my $p = Person->find(1)

At this moment, all methods listed below are class methods.

=head1 INTERFACE 

=over

=item new()

Object constructor. But so far it's not useful to you. So don't
call it.

=item find( $id )

Retrieve a record from this model with primary key $id.

=item create( $attr )

Create a new with attributes specified in $attr hash ref.

=item update( $id, $attr )

Update the record with primary key $id with new sets of
attributes specified in $attr hash ref.

=item delete( $id )

Remove the record with primary key $id.

=item url_root ( $url )

Get / set your Jifty instance's URL. You should set this in your own
model class with this:

  has url_root => ( default => '...' );

=item model ( $model_name )

Get / set your associated model name in the Jifty instance.
You should set this in your own model class with this:

  has model => ( default => '...' );

=back

=head1 CONFIGURATION AND ENVIRONMENT

Asynapse requires no configuration files or environment variables.
However, you need a Jifty instance with REST plugin (which is
given by default now.)

=head1 DEPENDENCIES

L<Moose>, L<LWP::UserAgent>, L<JSON::Syck>, and a Jifty instance
that installs L<Jifty::Plugin::REST>

=head1 INCOMPATIBILITIES

None reported.

=head1 BUGS AND LIMITATIONS

See C<Asynapse>

=head1 AUTHOR

Kang-min Liu  C<< <gugod@gugod.org> >>

=head1 LICENCE AND COPYRIGHT

Copyright (c) 2007, Kang-min Liu C<< <gugod@gugod.org> >>. All rights reserved.

This module is free software; you can redistribute it and/or
modify it under the same terms as Perl itself. See L<perlartistic>.


=head1 DISCLAIMER OF WARRANTY

BECAUSE THIS SOFTWARE IS LICENSED FREE OF CHARGE, THERE IS NO WARRANTY
FOR THE SOFTWARE, TO THE EXTENT PERMITTED BY APPLICABLE LAW. EXCEPT WHEN
OTHERWISE STATED IN WRITING THE COPYRIGHT HOLDERS AND/OR OTHER PARTIES
PROVIDE THE SOFTWARE "AS IS" WITHOUT WARRANTY OF ANY KIND, EITHER
EXPRESSED OR IMPLIED, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE. THE
ENTIRE RISK AS TO THE QUALITY AND PERFORMANCE OF THE SOFTWARE IS WITH
YOU. SHOULD THE SOFTWARE PROVE DEFECTIVE, YOU ASSUME THE COST OF ALL
NECESSARY SERVICING, REPAIR, OR CORRECTION.

IN NO EVENT UNLESS REQUIRED BY APPLICABLE LAW OR AGREED TO IN WRITING
WILL ANY COPYRIGHT HOLDER, OR ANY OTHER PARTY WHO MAY MODIFY AND/OR
REDISTRIBUTE THE SOFTWARE AS PERMITTED BY THE ABOVE LICENCE, BE
LIABLE TO YOU FOR DAMAGES, INCLUDING ANY GENERAL, SPECIAL, INCIDENTAL,
OR CONSEQUENTIAL DAMAGES ARISING OUT OF THE USE OR INABILITY TO USE
THE SOFTWARE (INCLUDING BUT NOT LIMITED TO LOSS OF DATA OR DATA BEING
RENDERED INACCURATE OR LOSSES SUSTAINED BY YOU OR THIRD PARTIES OR A
FAILURE OF THE SOFTWARE TO OPERATE WITH ANY OTHER SOFTWARE), EVEN IF
SUCH HOLDER OR OTHER PARTY HAS BEEN ADVISED OF THE POSSIBILITY OF
SUCH DAMAGES.
