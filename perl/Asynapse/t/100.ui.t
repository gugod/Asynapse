#!/usr/bin/env perl

use strict;
use warnings;
use Asynapse;
use Test::More;

plan tests => 1;

{
    my $ui = Asynapse->UI;

    $ui->Tabs(
        # Static content. Pre-load in the page in the beginning.
        about => "We are blahblahblah.",

        # dynamic content, re-generate every time.
        math => sub {
            my ($n, $o) = (int(rand(10)), int(rand(10)));
            "$n + $o = @{[$n+$o]}";
        }
    );

    ok($ui->as_html);

    diag $ui->as_html;
}
