#!/usr/bin/env perl

use strict;
use warnings;
use 5.012;

use Socket;
use Getopt::Long;

my %arg;
GetOptions(
    \%arg,
);

my $uds_path = $ARGV[0];

socket(my $sock, PF_UNIX, SOCK_STREAM, 0) or die "socket: $!";
connect($sock, sockaddr_un($uds_path));

my $line;
while (defined ($line = <$sock>)) {
    print $line;
}
exit;

