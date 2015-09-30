#!/usr/bin/perl -w
# Randomly mutates a DNA sequence for specified number of cycles
# Implements random nt replacement - string length maintained
# Uses a text file containing a single DNA sequence
# Usage: mutate.pl [filename] [number_of_mutates]
# JP Tomkins (jtomkins@icr.org) | 6-14-2011
# Modified outfile naming, JP Tomkins, 8-26-2015

use strict;

# Check for arguments (see usage above)
unless( $ARGV[0] && $ARGV[1] ) {
	print "Usage: mutate.pl [filename] [number_of_mutates]\n";
	exit;
}

my $filename = $ARGV[0];  # First arg is filename
open (DNAFILE,$filename) || die "Can't Open File: $filename\n";

my @dna = <DNAFILE>; # Put file input into an array
close DNAFILE;

my $dnastring = join('', @dna); # Remove newlines and make a string variable
$dnastring =~ s/\s//g; # Remove whitespace

my $number_mutate_runs = $ARGV[1];  # Second arg is number of mutation cycles
print "$ARGV[1] mutate cycles - see file 'mutate.out'\n"; # Send msg to stdout

my $outputfile = "$filename.$number_mutate_runs";  # Create output file 'mutate.out'
open(MUTATE, ">$outputfile") || die "Error: Can't open outputfile to write!\n";
	
my $i; # Counter var
my $mutant = mutate($dnastring); # Feed to sub mutate

# Seed the random number generator
srand(time|$$); # Combine time with current process id for rand

# Mutate DNA string for specified number of cycles
for ($i=0; $i<$number_mutate_runs; ++$i) {
    $mutant = mutate($mutant); 
    }

print MUTATE "$mutant\n"; # Send to file mutate.out
exit;


####################SUBROUTINES####################

#-----------------mutate------------------#
#Makes a mutation in a dna string
sub mutate {

	my($dna) = @_;

	my(@nucleotides) = ('A','C','G','T');

	# Pick a random position in the DNA
	my($position) = randomposition($dna);

	#Pick a random nucleotide
	my($newbase);

	do {
		$newbase = randomnucleotide(@nucleotides);		
	#Make sure it's different than the nucleotide we are mutating
	} until 
		( $newbase ne substr($dna, $position, 1) );

	# Insert the random nucleotide into the random position
	substr($dna, $position, 1, $newbase);

	return $dna;
}

#-------randomelement--------------#
#Randomly selects element from array
sub randomelement {
	my(@array) = @_;
	return $array[rand @array];
}

#-------randomnucleotide-----------#
#Randomly selects 1 of 4 (A,C,G,T) nucleotides
sub randomnucleotide {
my(@nucleotides) = ('A','C','G','T');
	return randomelement(@nucleotides);
}

#-------randomposition-------------#
#Randomly selects a position in a string
sub randomposition {
	my($string) = @_;
	return int rand length $string;
}
