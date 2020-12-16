#!/usr/bin/perl -w
use strict;
use POSIX;
use IO::File;
use Getopt::Std;
use Encode qw/encode decode/; 

my %opt;
getopts("d", \%opt);
my $recLen = 170+0;

usage(-1) unless @ARGV >= 2;

my $debug = defined($opt{'d'}) || 0;

open (IN, "<", $ARGV[0]) || die "Can't open input file $ARGV[0]\n";
binmode(IN);
open (OUT, ">", $ARGV[1]) || die "Can't open output file $ARGV[1]\n";
#binmode(OUT);

my $rec;

while(read(IN, $rec, $recLen ) > 0) {
                $rec = decode('cp37', $rec);
                if (substr($rec,0,2) eq '47') {
                                print OUT substr($rec,19,140), "\n";
                }

}
close(IN);
close(OUT);

sub usage {
                print << "---"
usage: SRAV_to_TXT [options] in.txt out.txt
                options:
                                -d            Turn on debug messages
---
;
                exit(-1);
}
