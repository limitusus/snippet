#!/usr/bin/env perl

use 5.012;

my @is = (50, 2, 1, 9);

my @perm = ();

add_perm([], \@is);

sub add_perm {
    my ($top, $bottom) = @_;
    my @top = @$top;
    my @bottom = @$bottom;
    my $bottom_size = scalar @bottom;
    my @bottom_save = @bottom;
    if (!$bottom_size) {
        push @perm, \@top;  # copy
        return;
    }
    for my $i (0 .. $bottom_size - 1) {
        my $k = splice @bottom, $i, 1;
        add_perm([@top, $k], \@bottom);
        @bottom = @bottom_save;
    }
}

my @ns;
for my $perm (@perm) {
    my $n = join("", @$perm) . "\n";
    push @ns, $n;
}

@ns = sort @ns;
print @ns[$#ns] . "\n";
