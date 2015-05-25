package ModCaller;

use strict;
use warnings;

use DynaLoader;
use Exporter;

our @ISA = qw(DynaLoader Exporter);
our @EXPORT = ();
our @EXPORT_OK = qw/show_message/;

our $VERSION = "1.0";

my $libref = DynaLoader::dl_load_file("callee.so", 0x01);
if (!$libref) {
    die "failed to load shared object";
}
my $symref = DynaLoader::dl_find_symbol($libref, "show_message");
if (!$symref) {
    die "failed to find symbol";
}
my $show_mes_ref = DynaLoader::dl_install_xsub("show_message", $symref, "callee.c");
if (!$show_mes_ref) {
    die "failed to install xsub";
}

1;

