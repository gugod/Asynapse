use Test::More tests => 2;

BEGIN {
use_ok( 'Asynapse' );
use_ok( 'Asynapse::Record' );
}

diag( "Testing Asynapse $Asynapse::VERSION" );
diag( "Testing Asynapse::Record $Asynapse::Record::VERSION" );
