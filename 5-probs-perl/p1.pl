#!/usr/bin/env perl

use 5.012;

my @list_for_sum = (5, 7, 11);
# sum should be 23

my $sum_for = 0;
for my $k (@list_for_sum) {
    $sum_for += $k;
}

my $while_idx = 0;
my $sum_while = 0;
while ($while_idx <= $#list_for_sum) {
    $sum_while += $list_for_sum[$while_idx++];
}

my $sum_recursive = 0;

$sum_recursive = sum_rec(@list_for_sum);

sub sum_rec {
    my ($k, @rest) = @_;;
    return $k if !@rest;
    return $k + sum_rec(@rest);
}

warn "sum (for)=$sum_for";
warn "sum (while)=$sum_while";
warn "sum (recursive)=$sum_recursive";

