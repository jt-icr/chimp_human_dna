#!/bin/sh

blastn \
-query 300_24.fa \
-task blastn \
-db ../chr22.fa \
-out 300_24_muts.csv \
-evalue 10 \
-word_size 11 \
-outfmt "10 pident nident length qlen" \
-max_target_seqs 1 \
-dust no \
-soft_masking false \
-ungapped \
-num_threads 4
