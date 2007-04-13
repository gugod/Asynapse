
use strict;
use warnings;
use inc::Module::Install;

name     'Asynapse',
all_from 'lib/Asynapse.pm',

requires 'Moose' => '0.17';
requires 'JSON::Syck' => '0.23';
requires 'LWP::UserAgent' => 0;

auto_install;
WriteAll;

