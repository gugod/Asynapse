#!/usr/bin/env perl

use strict;
use lib 'lib';
use lib 't/lib/';
use Person;
use Test::More;
use YAML;

plan( tests => 6 );

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

