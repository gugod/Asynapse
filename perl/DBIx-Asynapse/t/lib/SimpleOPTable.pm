use strict;
use warnings;

package SimpleOPTable;
use DBIx::Asynapse::Table;

op 'getAll' => 'SELECT * FROM [% table %]';

1;
