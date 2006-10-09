use strict;
use warnings;

use Test::More tests => 1;

use lib 't/lib';
use SimpleOPTable;

my $sth = SimpleOPTable->statementOf("getAll", "ThatTable");

ok ( $sth );

use YAML;
print YAML::Dump($sth);

