#!/usr/bin/perl -w
# Determines the percent similarity between two dna strings.
# Input sequences must be in separate plain text files.
# Sequences must also be properly aligned and trimmed to the same length.
# Usage: percent_identity.pl [filename1] [filename2]
# JP Tomkins (jtomkins@icr.org) | 6-21-2011

use strict;

# Check for arguments (see usage above)
unless( $ARGV[0] && $ARGV[1] ) {	
	print "Sequences must be in separate files. They must also\n";
	print "be properly aligned and trimmed to the same length.\n";
	print "Usage: percent_identity.pl [filename1] [filename2]\n";
	exit;
}

# Process input file & data
my $filename1 = $ARGV[0];
open (DNAFILE1,$filename1) || die "Can't Open File: $filename1\n";

my $filename2 = $ARGV[1];
open (DNAFILE2,$filename2) || die "Can't Open File: $filename2\n";

my @dna1 = <DNAFILE1>; # Put file input into an array
close DNAFILE1;
my $dnastring1 = join('', @dna1); # Remove newlines and make a string variable
$dnastring1 =~ s/\s//g; # Remove whitespace

my @dna2 = <DNAFILE2>; # Put file input into an array
close DNAFILE2; 
my $dnastring2 = join('', @dna2); # Remove newlines and make a string variable
$dnastring2 =~ s/\s//g; # Remove whitespace

# Check strings to make sure they are trimmed to equal lengths
# Also remind user that they should also be aligned
my $a = length($dnastring1);
my $b = length($dnastring2);
unless($a eq $b) {
	print "Sequences from files must be aligned and same length!\n";
	exit;
}

# Main routine
###################

# Declare vars
my @percentages;
my $percent;
my $result;

# Store DNA in array - initialize to empty list
# Add DNA strings as elements to array
my @random_DNA = ();
push(@random_DNA,$dnastring1);
push(@random_DNA,$dnastring2);

# Iterate through all pairs of sequences
for (my $k = 0; $k < scalar @random_DNA - 1; ++$k) {
	for (my $i = ($k + 1); $i < scalar @random_DNA; ++$i) {
		
		# Calculate and save the matching percentage in array
		$percent = matching_percentage($random_DNA[$k], $random_DNA[$i]);
		push(@percentages, $percent);
	}
}

# Average result and get %
$result = 0;

foreach $percent (@percentages) {
	$result += $percent;
}

$result = $result / scalar(@percentages);
	$result = int ($result * 100);
	
	print "Matching positions: $result%\n\n";
	
exit;

####################################################
## SUBROUTINES
####################################################

sub matching_percentage {

	my($string1, $string2) = @_;
	
	my($length) = length($string1);
	my($position);
	my($count) = 0;
	
	for ($position=0; $position < $length; ++$position) {
	
		if(substr($string1,$position,1) eq substr($string2,$position,1)) {
			++$count;
		}
	}
	
	return $count / $length;
}