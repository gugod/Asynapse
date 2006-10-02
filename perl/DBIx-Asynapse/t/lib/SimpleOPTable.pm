use strict;
use warnings;

package SimpleOPTable;
use DBIx::Asynapse;

op ( 'getAll' => 'SELECT * FROM [% table %]' );

1;
