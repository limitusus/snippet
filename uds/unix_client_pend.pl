#!/usr/bin/env perl

use strict;
use warnings;
use 5.012;

use Socket;
use Getopt::Long;

my %arg;
my $num;
GetOptions(
    \%arg,
    'num|n=i',
);

my $uds_path = $ARGV[0];
$num = $arg{num};

if ($num <= 0) {
    die "Specify positive number for --num";
}
for (my $i = 0; $i < $num; $i++) {
    my $pid = fork;
    if (!defined $pid) {
        die "fork: $!";
    } elsif ($pid) {
        next;
    }
    # child
    warn "child $$";
    socket(my $sock, PF_UNIX, SOCK_STREAM, 0) or die "socket: $!";
    connect($sock, sockaddr_un($uds_path)) or die "connect; $!";
    
    #my $line;
    #while (defined ($line = <$sock>)) {
    #    print $line;
    #}
    sleep 10000;
}

my $child_pid = 0;
do {
    $child_pid = waitpid(-1, 0);
} while $child_pid > 0;
exit;

