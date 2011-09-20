use File::Spec;
use File::Basename;
use lib File::Spec->catdir(dirname(__FILE__), 'extlib', 'lib', 'perl5');
use lib File::Spec->catdir(dirname(__FILE__), 'lib');
use P64::Web;
use Plack::Builder;

builder {
    enable 'Plack::Middleware::ReverseProxy';
    enable 'Plack::Middleware::Static',
        path => qr{^(?:/robots\.txt$|/favicon.ico$|^/debian\.txt$)},
        root => File::Spec->catdir(dirname(__FILE__), 'static');
    mount '/static/' => Plack::App::File->new(
        root => File::Spec->catdir(dirname(__FILE__), 'static')
    )->to_app;
    mount '/' => P64::Web->to_app();
};
