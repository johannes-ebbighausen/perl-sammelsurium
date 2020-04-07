#!/usr/bin/perl

use strict;
use warnings;

my $num_args = $#ARGV + 1;
if ($num_args != 2) {
    print "\nUsage: logfile_timestampe_gap.pl filename gap_in_seconds\n";
    print "Prints all lines of the file where diff between two dates yyyy:hh:mm:ss is bigger than gap_in_seconds \n";
    exit;
}

my $filename = $ARGV[0];
my $minGapSize = $ARGV[1];

my $SEC_PER_MIN = 60;
my $SEC_PER_HOUR = 60 * $SEC_PER_MIN;

open(my $fh, '<:encoding(UTF-8)', $filename)
  or die "Could not open file '$filename' $!";
 
my $last = 0;

while (my $row = <$fh>) {
   chomp $row;
   $row =~ /(\d{4}):(\d{2}):(\d{2}):(\d{2})/;
   my ($y, $h, $m, $s) = ($1, $2, $3, $4);
   
   my $current = $h * $SEC_PER_HOUR + $m * $SEC_PER_MIN + $s;
   
   if ($current - $last > $minGapSize) {
      print "$row\n";
   }

   $last = $current;
}