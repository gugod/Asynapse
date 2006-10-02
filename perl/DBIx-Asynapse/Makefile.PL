use strict;
use warnings;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME                => 'DBIx::Asynapse',
    AUTHOR              => 'Kang-min Liu <gugod@gugod.org>',
    VERSION_FROM        => 'lib/DBIx/Asynapse.pm',
    ABSTRACT_FROM       => 'lib/DBIx/Asynapse.pm',
    PL_FILES            => {},
    PREREQ_PM => {
        'Test::More' => 0,
        'version'    => 0,
    },
    dist                => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean               => { FILES => 'DBIx-Asynapse-*' },
);
