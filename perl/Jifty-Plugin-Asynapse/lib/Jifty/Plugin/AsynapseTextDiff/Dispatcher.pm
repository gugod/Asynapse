package Jifty::Plugin::AsynapseTextDiff::Dispatcher;
use strict;
use warnings;
use Jifty::Dispatcher -base;
use Algorithm::Diff qw(sdiff);
use Jifty::YAML ();
use Jifty::JSON ();

our $VERSION = 0.01;

on '/=/diff/' => \&run_diff;

sub run_diff {
    my $req = Jifty->handler->apache;

    my $data = Jifty::JSON::jsonToObj $req->params("POSTDATA")->{POSTDATA};
    my $text1 = [split "\n", $data->{text1}];
    my $text2 = [split "\n", $data->{text2}];
    my $diff  = sdiff($text1, $text2);

    $req->header_out('Content-Type' => 'application/json; charset=UTF-8');
    $req->send_http_header;
    print( Jifty::JSON::objToJson($diff) );

    last_rule;
}

1;
