use inc::Module::Install;
all_from "lib/P64.pm";

license 'unknown';
author  'unknown';

tests 't/*.t t/*/*.t t/*/*/*.t';
requires 'Amon2';
requires 'Text::Xslate';
requires 'Text::Xslate::Bridge::TT2Like';
requires 'Plack::Middleware::ReverseProxy';
requires 'HTML::FillInForm::Lite';
requires 'Time::Piece';
requires 'HTTP::Parser::XS';
requires 'DBI';
requires 'DBIx::TransactionManager';
requires(
	'SQL::Interp' => 0,
	'Carp::Clan' => 0,
);
recursive_author_tests('xt');

WriteAll;
