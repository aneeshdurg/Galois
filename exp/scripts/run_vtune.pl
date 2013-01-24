#!/usr/bin/perl

use strict;
use warnings;

my $vtune = `which amplxe-cl`;
my @vtune_vers = ("2013", "2011");
foreach my $ver (@vtune_vers) {
  my $base = "/opt/intel/vtune_amplifier_xe_" . $ver;
  if (-e $base and not $vtune) {
    $vtune = $base . "/bin64/amplxe-cl";
    last;
  }
}

# TODO: fix this path when kernel and library debug symbols get installed
my $symbol = "/usr/lib/debug/boot/" . `uname -r`;
chomp($symbol);

die("Run as: runvtune.pl [-t N] output app args*") unless ($#ARGV > 1);

my $threads = 1;
my $found_threads = 0;
if ($ARGV[0] eq "-t") {
  shift @ARGV;
  $threads = shift @ARGV;
  $found_threads = 1;
}

my $outfile = shift @ARGV;
my $cmdline = join(" ", @ARGV);

if ($found_threads) {
  $cmdline = $cmdline . " -t $threads";
}

print "*** Executing: " . $cmdline . "\n";

my $uname = `whoami`;
chomp($uname);
# my $type = "nehalem_general-exploration";
# my $type = "nehalem_memory-access";
my $type = "nehalem-memory-access";

my $sys = `hostname`;
chomp($sys);
if ($sys eq "volta") {
    $type = "nehalem_general-exploration";
}

my $dire = "/tmp/$uname.vtune.r$threads";
my $rdir = "-result-dir=$dire";
my $report = "-R hw-events -format csv -csv-delimiter tab";
my $collect = "-analyze-system -collect $type -start-paused";
# my $collect = "-collect-with runsa -knob event-config=CPU_CLK_UNHALTED.REF -start-paused";
my $sdir = "-search-dir all=$symbol";
my $maxsec = 1000;

system("date");
system("set -x ; rm -rf $dire");
system("set -x ; mkdir $dire");
# system("set -x ; $vtune $collect $rdir $sdir -- $cmdline"); 
system("set -x ; $vtune $collect $rdir -- $cmdline");
system("echo \"THREADS\t$threads\" >>$outfile.line.log");
system("set -x ; ulimit -t $maxsec ; $vtune $report $rdir -group-by source-line >> $outfile.line.log");
system("echo \"THREADS\t$threads\" >>$outfile.function.log");
system("set -x ; ulimit -t $maxsec ; $vtune $report $rdir -group-by function >> $outfile.function.log");
