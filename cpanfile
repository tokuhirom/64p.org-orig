requires 'perl', '5.008001';

requires 'Amon2';
requires 'Carp::Clan';
requires 'DBI';
requires 'DBIx::TransactionManager';
requires 'HTTP::Parser::XS';
requires 'Module::Find';
requires 'Plack::Middleware::ReverseProxy';
requires 'SQL::Interp';
requires 'Text::Xatena';
requires 'Text::Xslate';
requires 'Text::Xslate::Bridge::TT2Like';
requires 'Time::Piece';

on build => sub {
    requires 'ExtUtils::MakeMaker', '6.42';
};
