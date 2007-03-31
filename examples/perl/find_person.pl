#!/usr/bin/perl

package Person;
use LWP::UserAgent;
use YAML::Syck;
$YAML::Syck::ImplicitUnicode=1;

sub find {
    my ($self, $id) = @_;
    Load( _get("http://localhost:8888/=/model/person/id/${id}.yaml") );
}

sub _get {
    my $url = shift;
    my $ua = LWP::UserAgent->new;
    $ua->timeout(10);
    $ua->env_proxy;
    my $response = $ua->get($url);
    if ($response->is_success) {
        return $response->content;
    }
    else {
        die $response->status_line . ": $url\n";
    }
}

package main;
use Data::Dumper;

print Dumper(Person->find(1));
print Dumper(Person->find(2));


