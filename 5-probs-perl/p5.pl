#!/usr/bin/env perl

use 5.012;

my $MAX = 9;
my $EXP_RESULT = 100;
my @ops = ("+", "-", "NOP");

sub make_expression {
    my ($begin, $pre_exp) = @_;
    for my $op (@ops) {
        my @exp = (@$pre_exp, $op, $begin);
        shift @exp if $begin == 1;
        if ($begin == $MAX) {
            if (evaluate_expression(\@exp) == $EXP_RESULT) {
                dump_expression(@exp);
            }
        } else {
            make_expression($begin + 1, [@exp]);
            last if $begin == 1;
        }
    }
}

sub dump_expression {
    my @exp = @_;
    print "DUMP: ";
    print join " ", @exp;
    print "\n";
}

sub evaluate_expression {
    my ($e) = @_;
    my ($p, $o, $q);
    my @e = @$e;
    my $v;
    # NOP
    my @t_e;
  PROC_NOR:
    for my $i (0 .. $#e) {
        if ($e[$i] eq "NOP") {
            splice @e, $i, 1;
            #dump_expression(@e);
            my ($j, $k) = splice @e, $i - 1, 2;
            splice @e, $i - 1, 0, ($j * 10 + $k);
            #dump_expression(@e);
            goto PROC_NOR;
        }
    }
    # CALC
    while (@e) {
        return $e[0] if @e == 1;
        my @r;
        ($p, $o, $q, @r) = @e;
        if ($o eq "+") {
            @e = ($p + $q, @r);
        } elsif ($o eq "-") {
            @e = ($p - $q, @r);
        }
    }
}

make_expression(1, []);
