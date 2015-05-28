#!/usr/bin/env perl

use 5.012;
use bigint;

to_fib(100);

sub to_fib {
    my $to = shift;
    my @init = (0, 1);
    printf "0 %d\n", $init[0];
    printf "1 %d\n", $init[1];
    for my $i (2 .. $to) {
        my $s = $init[0] + $init[1];
        print "$i $s\n";
        shift @init;
        push @init, $s;
    }
}
