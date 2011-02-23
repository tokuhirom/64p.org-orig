#!/usr/bin/perl
use strict;
use warnings;
use utf8;
use 5.010000;
use Digest::MD5 qw/md5_hex/;
use autodie;
use Log::Minimal;

open my $fh, '<:utf8', 'tmpl/index.tt';
while (<$fh>) {
    /screen_shot\(['"](.+)['"]\)/ and do {
        my $url = $1;
        infof("processing '%s'", $url);
        system "webkit2png", '-C', "--dir=htdocs/static/img/screen_shot/", "--md5", $url;
    };
}

