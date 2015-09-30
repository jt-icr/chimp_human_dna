#!/bin/sh
#Standard nucmer shell script with params
#Shell redirection used to disown and logout
#JP Tomkins <jtomkins@icr.org> some time in 2015

{ nucmer -maxmatch -c 100 -p chr4_chimp_on_human ~/homo_chroms/Homo_sapiens.GRCh37.71.dna.chromosome.4.fa ~/chimp_chroms/Pan_troglodytes.CHIMP2.1.4.71.dna.chromosome.4.fa ; } > chr4.log 2>&1
