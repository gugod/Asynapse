#!/usr/bin/perl

use strict;
use warnings;
use Test::More qw(no_plan);

use DBIx::Asynapse;

use MyDB;

# SELECT * FROM people;
my $people = MyDB->op("people");

$people.find('all');

__END__

// JS code

// Setup adb.record to have schema and record.
var adb = Asynapse.DB.new({ server: 'http://site.org/adb.cgi' });

// ActiveRecord -like API
var Person = adb.record.Person;

var p = Person.find( "all",
                     "conditions" => {
                         "sex = ? and ? < age < ?",
                         "female", 18, 24
                     }
                   );

p.save
