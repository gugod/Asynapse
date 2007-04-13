#!/usr/bin/env perl

use strict;
use lib 'lib';
use lib 't/lib/';
use Person;
use Test::More;
use YAML;

plan( tests => 9 );

for my $id (1..5) {
    my $p = Person->find($id);
    is($p->{id}, $id);
}

{
    my $new_name = "Nanhai Hacking " . rand();
    Person->update(6, { name => $new_name });
    my $p = Person->find(6);
    is($p->{name}, $new_name);
}

{
    my $new_name = "Nanhai Hacking " . rand();
    my $new_p = Person->create({ name => $new_name });
    ok( defined($new_p->{id}) );

    my $p = Person->find($new_p->{id});
    is($p->{name}, $new_name);
}

{
    my $new_name = "Nanhai Hacking " . rand();
    my $new_p = Person->create({ name => $new_name });

    Person->delete($new_p->{id});
    my $p = Person->find($new_p->{id});
    ok( !defined($p->{id}) );
}

