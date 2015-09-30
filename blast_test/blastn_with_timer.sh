#!/bin/sh
#Run blastn job
#Get job execution time and output to csv file
#This script was copied and modified accordingly for each job

#Script start time
START=$(date +%s)

blastn \
-query rep1/Pan_troglodytes.CHIMP2.1.4.71.dna.chromosome.3.fa_split_300.fa_100000_seqs.fa \
-task blastn \
-db /home/jtomkins/homo_chroms/Homo_sapiens.GRCh37.71.dna.chromosome.3.fa \
-out chr3_pan_100000_seqs_blast-2.2.30.csv \
-evalue 10 \
-word_size 11 \
-outfmt "10 pident nident length qlen" \
-max_target_seqs 1 \
-max_hsps 1 \
-dust no \
-soft_masking false \
-ungapped \
-num_threads 6

#Script end time
END=$(date +%s)

#Get script run time and send to csv file
DIFF=$(( $END - $START ))
echo $(basename $0),$DIFF >> blast_2.2.30_time_dat.csv


