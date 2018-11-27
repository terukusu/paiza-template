#!/usr/bin/perl

use strict;
use warnings;
use Data::Dumper;
use Math::Trig;

my $is_debug_enabled = 1;
my $is_read_from_file = 1;
my $data_file = "template.txt";

sub debug {
  my ($msg) = @_;

  if (!$is_debug_enabled) {
    return;
  }

  print($msg."\n");
}

sub read_lines_from_file {
  open (my $fh, "<", $data_file) or die "$!";
  local $/ = undef;
  my $data = <$fh>;
  close ($fh);

  my @lines = split(/\r\n|\r|\n/, $data);
  my @result;

  foreach my $line (@lines) {
    if (length($line)) {
      push(@result, $line);
    }
  }

  return @result
}

sub read_lines_from_stdin {
  local $/ = undef;
  my $data = <STDIN>;

  my @lines = split(/\r\n|\r|\n/, $data);
  my @result;

  foreach my $line (@lines) {
    if (length($line)) {
      push(@result, $line);
    }
  }

  return @lines
}

sub lines_to_list_of_list {
  my @lines = @_;
  my @result;

  foreach my $line (@_) {
    my @values = split(/ /, $line);
    push(@result, \@values);
  }

  return @result;
}

sub main {
  my @lines;

  if ($is_read_from_file) {
      @lines =   read_lines_from_file();
  } else {
      @lines =   read_lines_from_stdin();
  }

  debug("lines=\n".Dumper(\@lines));

  my @values = lines_to_list_of_list(@lines);
  debug("values=\n".Dumper(\@values));

}

main();
