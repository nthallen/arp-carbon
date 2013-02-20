#! /usr/bin/perl -w
use strict;

my $title = <>;
chomp($title);
print "/* $title */\n";

while (my $line = <>) {
  last if $line =~ m/^\s*-99/;
}

my %units = (
  mb => 'MBAR',
  'm/s2' => 'M_S2',
  deg_C => 'CELCIUS',
  '-' => 'mVOLTS'
);
while (my $line = <>) {
  next if $line =~ m/^\s*$/;
  chomp $line;
  my @fld = split(' ', $line, 14);
  last if @fld == 2 && $fld[1] == -99;
  if (@fld == 14) {
    if ($fld[1] == 20) {
      my $name = $fld[0];
      my $units = $fld[4];
      my @cal_coef = ($fld[6], $fld[7]);
      my $span = $fld[11];
      my $offset = $fld[12];
      my $nctype = $fld[10];
      if ($nctype ne 'NC_SHORT') {
        warn "Unrecognized type: '$nctype'\n";
      } elsif (not defined $units{$units}) {
        warn "Unrecognized units: '$units'\n";
      } else {
        my $minraw = -32768;
        my $maxraw = 32767;
        my $min_mV = $minraw * $span + $offset;
        my $max_mV = $maxraw * $span + $offset;
        my $min_eng = $min_mV * $cal_coef[1] + $cal_coef[0];
        my $max_eng = $max_mV * $cal_coef[1] + $cal_coef[0];
        print "Calibration ( BAT_${name}_t, $units{$units} ) { $minraw, $min_eng, $maxraw, $max_eng }\n";
      }
    }
  } else {
    warn "Invalid input: '$line'\n";
  }
}
