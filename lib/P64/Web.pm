package P64::Web;
use strict;
use warnings;
use parent qw/P64 Amon2::Web/;
use File::Spec;

# load all controller classes
use Module::Find ();
Module::Find::useall("P64::Web::C");

# custom classes
use P64::Web::Request;
use P64::Web::Response;
sub create_request  { P64::Web::Request->new($_[1]) }
sub create_response { shift; P64::Web::Response->new(@_) }

# dispatcher
use P64::Web::Dispatcher;
sub dispatch {
    return P64::Web::Dispatcher->dispatch($_[0]) or die "response is not generated";
}

# setup view class
use Tiffany::Text::Xslate;
{
    my $view_conf = __PACKAGE__->config->{'Text::Xslate'} || die "missing configuration for Text::Xslate";
    unless (exists $view_conf->{path}) {
        $view_conf->{path} = [ File::Spec->catdir(__PACKAGE__->base_dir(), 'tmpl') ];
    }
    my $view = Tiffany::Text::Xslate->new(+{
        'syntax'   => 'TTerse',
        'module'   => [ 'Text::Xslate::Bridge::TT2Like' ],
        'function' => {
            c => sub { Amon2->context() },
            uri_with => sub { Amon2->context()->req->uri_with(@_) },
            uri_for  => sub { Amon2->context()->uri_for(@_) },
        },
        %$view_conf
    });
    sub create_view { $view }
}

# load plugins
use HTTP::Session::Store::File;
__PACKAGE__->load_plugins(
    'Web::FillInFormLite',
    'Web::NoCache', # do not cache the dynamic content by default
    'Web::CSRFDefender',
    'Web::HTTPSession' => {
        state => 'Cookie',
        store => HTTP::Session::Store::File->new(
            dir => File::Spec->tmpdir(),
        )
    },
);

# for your security
__PACKAGE__->add_trigger(
    AFTER_DISPATCH => sub {
        my ( $c, $res ) = @_;
        $res->header( 'X-Content-Type-Options' => 'nosniff' );
    },
);

__PACKAGE__->add_trigger(
    BEFORE_DISPATCH => sub {
        my ( $c ) = @_;
        # ...
        return;
    },
);

1;
