#!/bin/sh
#Takes show-coords text output and converts to csv R compatible file
#JP Tomkins 11-26-14

#Check for input file arg
if [ $# -lt 1 ] ; then
    echo 'Enter show-coords outfile!'
    exit 0
fi

#Gets alignment length and identity columns from nucmer/show-coords/*.delta table
#and cleans up the first five lines of extraneous text
#and adds column headers for R
cat $1|awk '{print $7","$8","$10}'|\
sed 's/,,$//g'|\
sed 's/\[LEN,1\],2\]/Reference,Query,Perc_Ident/'|\
sed '/^$/d' > $1.csv
