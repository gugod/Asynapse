#!/usr/bin/perl
use strict;
use Module::Build::JSAN;

my $build = Module::Build::JSAN->new(
    module_name => 'Asynapse',
    license     => 'perl',
    keywords    => [qw(Asynapse REST)]
);

$build->create_build_script;
