#!/usr/bin/env perl

use strict;
use warnings;
use 5.012;

use Socket;
use Getopt::Long;

my %arg;
GetOptions(
    \%arg,
    'uds-path=s',
);

my $uds_path = $arg{'uds-path'};
$uds_path //= "/tmp/uds.sock";
if (-S $uds_path) {
    unlink $uds_path or die "cannot unlink UDS $uds_path: $!";
}

my $uaddr = sockaddr_un($uds_path);
my $proto = getprotobyname("tcp");

socket(my $sock, PF_UNIX, SOCK_STREAM, 0) or die "socket: $!";
bind($sock, $uaddr) or die "bind: $!";
listen($sock, SOMAXCONN) or die "listen: $!";

warn "server started on $uds_path";

# REAPER
use POSIX ":sys_wait_h";
sub reap_child {
    my $child;
    while (($child = waitpid(-1, WNOHANG)) > 0) {
        warn "reaped $child";
    }
    $SIG{CHLD} = \&reap_child;  # for SysV
}
$SIG{CHLD} = \&reap_child;

while (1) {
    accept(my $client, $sock) or next;
    my $pid = fork;
    if (!defined $pid) {
        die "fork: $!";
    } elsif ($pid) {
        warn "forked $pid";
        next;
    } else {
        open STDIN, "<&", $client or die "can't dup client to stdin";
        open STDOUT, ">&", $client or die "can't dup client to stdout";
        print "Hello I'm PID $$";
        while (defined (my $line = <$client>)) {
            print $line;
        }
        exit 0;
    }
}

