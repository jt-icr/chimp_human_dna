#!/usr/bin/env python
"""parse_multi_fasta.py
	Creator :     Jeff Tomkins
	Create date :  April 27, 2015 
	Last modified: 
	Description :  Parses a multi fasta file from seqsplit.py into subfiles
	Modifications since original:
"""

import sys
from Bio import SeqIO
import random

args = sys.argv[1:]

if len(args) != 2 :
    print("Error!  2 args: fasta file and number of seqs for new fasta file")
    sys.exit()
    
inFileName = args[0]
numRecords = int(args[1])

#Open files for read/write
fi = open(inFileName, 'rU')
fo = open(inFileName + "_" + str(numRecords) + "_seqs.fa", 'w')

#Parse individual fasta records into a list
records = list(SeqIO.parse(fi, "fasta"))

#Only use sequences of 250 bases or more
records = [rec for rec in records if len(rec) >= 250]

#Make sure there are enough seqs
if len(records) <= 100000:
    print("Error! Need a fasta file of more than 100,000 seqs > 250 bases each")
    sys.exit()

#Randomize
random.shuffle(records)

#Get specified number of fasta records and print to new file
for i in records[0:numRecords] :
	SeqIO.write(i, fo, "fasta")

#Print the new file name
print "New file: " + inFileName + "_" + str(numRecords) + "_seqs.fa"

#Close files and exit
fi.close()
fo.close()
sys.exit()