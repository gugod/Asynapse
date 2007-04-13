use strict;
use warnings;
use inc::Module::Install;

name     'Asynapse',
all_from 'Kang-min Liu <gugod@gugod.org>',
requires 'Moose' => '0.20';
requires 'LWP::UserAgent';
requires 'JSON:Syck';

auto_install;
WriteAll;

