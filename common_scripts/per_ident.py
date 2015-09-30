#!/usr/bin/env python
"""proc_blastn_output.py
	Creator :     Jeff Tomkins
	Create date :  April 28, 2015 
	Last modified: 
	Description :  Processes blastn output
	Modifications since original:
"""

import sys
import pandas

args = sys.argv[1:]

if len(args) != 1:
    print("Error!  *.csv file needed")
    sys.exit()

inFile = sys.argv[1]

#Open *csv as a pandas data frame
df = pandas.read_csv(inFile, header = None)

#Assign column headings - replaces default [0,1,2...etc]
df.columns = ['pident','nident', 'length', 'qlen']

#Get the overall aln identity and put in new column called 'ident'
df['ident'] = df.apply(lambda row: (row['nident']/row['length'] \
if row['length'] > row['qlen'] else row['nident']/row['qlen']), axis=1)

#Print average identity
print round(df['ident'].mean(),2)