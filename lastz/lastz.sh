#!/bin/sh
#Basic script to run lastz and params used
#JP Tomkins <jtomkins@icr.org> some time in 2015

lastz /home/jtomkins/homo_chroms/Homo_sapiens.GRCh37.71.dna.chromosome.1.fa[unmask] \
Pan_troglodytes.CHIMP2.1.4.71.dna.chromosome.1.fa_split_10000.fa \
--step=10 --seed=match12 --notransition --exact=20 --noytrim --ambiguous=n \
--filter=coverage:50 --filter=identity:50 \
--format=general:start1,end1,length1,length2,strand2,identity \
> chr1_homo_vs_chimp_10000slice.dat \
