#! /usr/bin/perl -w
# Script to generate CellT_raw.cdf
use strict;

my @chans = qw(MSSPT MCelP MSG1T AIC48 AICD4 AICD6
  CCel1T CCel2T
  MCel1T MCel2T
  ICel1T ICel2T
  CSk1T CSk2T CSk3T
  MSk1T MSk2T MSk3T
  ISk1T ISk2T ISk3T
  CRv1T CRv2T CRv3T CRv4T CRv5T
  MRv1T MRv2T MRv3T MRv4T MRv5T
  IRv1T IRv2T IRv3T IRv4T IRv5T
  );

my %chans = map { ($_ => 1) } @chans;
my %rates;
my %chanrates;

open(AIO, "<AIO.tmc") || die "Cannot read AIO.tmc\n";
open(CDF, ">CellT_raw.cdf") || die "Cannot write CellT_raw.cdf\n";
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

for my $chan (@chans) {
  defined($chanrates{$chan}) ||
    warn("Rate for channel '$chan' not found\n");
}

my @rates = sort keys %rates;
for my $rate (@rates) {
  my @rchans = sort grep $chanrates{$_} == $rate, keys %chanrates;
  my $nrows = @rchans + 1;
  print CDF "csv HCIraw_$rate $nrows\n",
    "  condition depending on ($rate Hz)\n",
    "  0 THCIraw_$rate %.3lf\n";
  my $row = 0;
  for my $i (1 .. $nrows-1) {
    print CDF "  $i $rchans[$i-1]_raw\n";
  }
}

