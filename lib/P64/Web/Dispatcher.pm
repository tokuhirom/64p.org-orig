package P64::Web::Dispatcher;
use strict;
use warnings;

use Amon2::Web::Dispatcher::Lite;
use DirHandle;
use autodie;
use File::Basename qw/basename/;
use Text::Xatena;
use Text::Xslate qw/mark_raw/;

any '/' => sub {
    my ($c) = @_;
    $c->render('index.tt');
};

any '/about' => sub {
    my ($c) = @_;
    $c->render('about.tt');
};

any '/memo/' => sub {
    my ($c, $p) = @_;

    my @files = sort glob( File::Spec->catfile( $c->base_dir, "data/", '*.txt' ) );
    @files = map {
        +{
            title => do { open my $fh, '<:utf8', $_; my $line = <$fh>; $line },
            file => do { local $_ = basename($_); s/\.txt/.html/; $_ },
          }
    } @files;

    $c->render('memo-list.tt', { files => \@files });
};

any '/memo/{name:[a-z0-9_-]+}.html' => sub {
    my ($c, $p) = @_;
    open my $fh, '<:utf8', File::Spec->catfile($c->base_dir, "data/$p->{name}.txt");
    my $title = <$fh>;
    my $body = do { local $/; <$fh> };
    my $xatena = Text::Xatena->new();
    $c->render( 'memo.tt',
        { entry_title => $title, body => mark_raw( $xatena->format($body) ) } );
};

1;
