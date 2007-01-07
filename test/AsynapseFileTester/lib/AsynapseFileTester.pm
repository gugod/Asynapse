package AsynapseFileTester;

use Jifty;
use strict;
use warnings;

sub start {
    Jifty->web->javascript_libs(
        [   @{ Jifty->web->javascript_libs },
            "jsan/Test/Builder.js",
            "jsan/HTTP/Request.js",
            "Asynapse/File.js"
        ]
    );
}

1;
