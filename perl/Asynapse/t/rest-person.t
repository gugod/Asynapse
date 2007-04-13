#!/usr/bin/env perl

use strict;
use lib 'lib';
use lib 't/lib/';
use Person;
use Test::More;
use YAML;

plan( tests => 5 );

for my $id (1..5) {
    my $p = Person->find($id);
    is($p->{id}, $id);
}

