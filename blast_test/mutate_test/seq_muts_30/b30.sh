#!/bin/sh

blastn \
-query 300_30.fa \
-task blastn \
-db ../chr22.fa \
-out 300_30_muts.csv \
-evalue 10 \
-word_size 11 \
-outfmt "10 pident nident length qlen" \
-max_target_seqs 1 \
-dust no \
-soft_masking false \
-ungapped \
-num_threads 4
