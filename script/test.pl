#!/usr/bin/env perl
use strict;
use warnings;
use utf8;
use 5.010000;
use autodie;
use Test::More 0.96;
use Data::Dumper;

use LWP::UserAgent;

my $ua = LWP::UserAgent->new(
    timeout => 5
);
my @TEST = (
    'http://corelist.64p.org/' => 'corelist',
    'http://qrcode.64p.org/' => 'QR',
    'http://64p.org/' => '64p',
    'http://amon.64p.org/' => 'amon',
);
while (my ($url, $keyword) = splice @TEST, 0, 2) {
    my $res = $ua->get($url);
    is($res->code, 200);
    like($res->header('title'), qr{\Q$keyword}i)
        or diag $res->header('title');
}
done_testing;
