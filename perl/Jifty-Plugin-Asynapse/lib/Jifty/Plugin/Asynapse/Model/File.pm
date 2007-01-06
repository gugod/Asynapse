package Jifty::Plugin::Asynapse::Model::File;
use Jifty::DBI::Schema;
use Jifty::DBI::Record schema {
    column name => type is 'text';
    column content => type is 'text';
}

1;
