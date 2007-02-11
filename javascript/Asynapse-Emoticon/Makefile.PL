#!/usr/bin/perl
use strict;
use Module::Build::JSAN;

my $build = Module::Build::JSAN->new(
    module_name => 'Asynapse.Emoticon',
    license     => 'perl',
    keywords    => [qw(Asynapse Emoticon)]
);

$build->create_build_script;
