use strict;
use warnings;
use inc::Module::Install;

name 'DBIx-Asynapse';
all_from 'lib/DBIx/Asynapse.pm';

requires
    'Exporter::Lite' => 0,
    'Test::Perl::Critic' => 0,
    'Test::More' => 0,
    'version' => 0;

auto_install;
WriteAll;
