package AsynapseFileTester::Model::Person;
use strict;
use warnings;
use Jifty::DBI::Schema;

use Jifty::Record schema {

    column name =>
        type is 'text';

    column birthday =>
        type is 'datetime';

};

1;
