#! /usr/bin/perl -w
use strict;

my @chans = qw(MSSPT ISk3T MCelP ICel1T MSG1T ICel2T MRv1T ISk1T MCel2T
  Sk1T ISk2T MSk3T AIC48 MCel1T CRv1T AICD4 CCel2T CSk3T
  ICD6 CCel1T);

my %chans = map { ($_ => 1) } @chans;
my %rates;
my %chanrates;

open(AIO, "<AIO.tmc") || die "Cannot read AIO.tmc\n";
while (<AIO>) {
  if ( m/^TM ([0-9]+) Hz\s+\S+\s+([^;]+);/ ) {
    my $chan = $2;
    my $rate = $1;
    if ($chans{$chan}) {
      # print "$chan $rate Hz\n";
      $rates{$rate} = 1;
      $chanrates{$chan} = $rate;
    }
  }
}

my @rates = sort keys %rates;
for my $rate (@rates) {
  my @rchans = sort grep $chanrates{$_} == $rate, keys %chanrates;
  my $nrows = @rchans + 1;
  print "csv HCIraw_$rate $nrows\n",
    "  condition depending on ($rate Hz)\n",
    "  0 THCIraw_$rate %.3lf\n";
  my $row = 0;
  for my $i (1 .. $nrows-1) {
    print("  $i $rchans[$i-1]_raw\n");
  }
}

