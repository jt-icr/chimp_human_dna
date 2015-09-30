#!/bin/bash
#Concatenates a bunch of 300 base seq files without fasta headers
#and adds filename as fasta header
head -n 20 seq*|perl -pe 's/^\n$//g'|perl -pe 's/==> />/g'|perl -pe 's/ <==//g'