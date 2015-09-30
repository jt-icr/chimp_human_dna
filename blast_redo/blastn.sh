#!/bin/sh
#Shell script and blastn params used

blastn \
-query Pan_troglodytes.CHIMP2.1.4.71.dna.chromosome.1.fa_split_300.fa \
-task blastn \
-db /home/jtomkins/homo_chroms/Homo_sapiens.GRCh37.71.dna.chromosome.1.fa \
-out chr1_pan_on_homo_300.csv \
-evalue 10 \
-word_size 11 \
-outfmt "10 pident nident length qlen" \
-max_target_seqs 1 \
-dust no \
-soft_masking false \
-ungapped \
-num_threads 8
