#!/bin/sh
#extracts data from a lastz output and formats to csv
#JP Tomkins <jtomkins@icr.org> some time in 2015

ls -1 *dat
echo Enter filename...
read file
#grab columns and put in new file.csv
awk '{print $6","$7}' $file > $file.csv
#split alignment fraction into 2 columns
perl -pi -e 's/\//,/g' $file.csv
#remove '%' char
perl -pi -e 's/%//g' $file.csv
#fix column headings for R
perl -pi -e 's/identity,idPct/aln_bases,aln_len,ident/' $file.csv
echo
#check result with head
echo "===$file.csv==="
echo
head $file.csv