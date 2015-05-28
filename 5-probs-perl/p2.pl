#!/usr/bin/env perl

use 5.012;

my @l1 = ("a", "b", "c");
my @l2 = (1, 2, 3);

my @zipped = zip(\@l1, \@l2);

for my $x (@zipped) {
    warn $x;
}

sub zip {
    my ($la, $lb) = @_;
    die "size different" if scalar @$la != scalar @$lb;
    my @z = ();
    my $size = scalar @$la;
    for (0 .. $size - 1) {
        push @z, $la->[$_];
        push @z, $lb->[$_];
    }
    return @z;
}
