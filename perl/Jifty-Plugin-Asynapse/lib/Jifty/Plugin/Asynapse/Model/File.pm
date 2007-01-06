package Jifty::Plugin::Asynapse::Model::File;
use strict;
use warnings;
use Jifty::DBI::Schema;

use Jifty::Record schema {
    column name => type is 'text';
    column content => type is 'text';
};

1;
