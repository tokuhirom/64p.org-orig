#!/usr/bin/perl
use strict;
use warnings;
use utf8;
use 5.010000;
use Digest::MD5 qw/md5_hex/;
use autodie;

open my $fh, '<:utf8', 'tmpl/index.tt';
while (<$fh>) {
    /url\s*=>\s*['"](.+)['"]/ and do {
        my $url = $1;
        printf("processing '%s'\n", $url);
        system "webkit2png", '-C', "--dir=static/img/screen_shot/", "--md5", $url;
    };
}

