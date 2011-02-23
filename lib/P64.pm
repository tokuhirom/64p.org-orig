package P64;
use strict;
use warnings;
use parent qw/Amon2/;
our $VERSION='0.01';
use 5.008001;

use Amon2::Config::Simple;
sub load_config { Amon2::Config::Simple->load(shift) }

use P64::DBI;
sub dbh {
    my ($self) = @_;

    if (!defined $self->{dbh}) {
        my $conf = $self->config->{'DBI'} or die "missing configuration for 'DBI'";
        $self->{dbh} = P64::DBI->connect(@$conf);
    }
    return $self->{dbh};
}

1;
