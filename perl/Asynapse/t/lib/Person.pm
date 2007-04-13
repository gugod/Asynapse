package Person;
use strict;
use warnings;
use Moose;
extends 'Asynapse::Record';

has url_root => ( default => "http://localhost:3001" );
has model => ( default => "person" );

1;

