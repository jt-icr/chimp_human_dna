#!/usr/bin/python
#Gets column averages from a *.csv blastn output file
#JP Tomkins <jtomkins@icr.org>
#Aug 23, 2012
#Supports shell script 'proc_csv_out'

import csv
import sys

csvReader = csv.reader(open(sys.argv[1]), delimiter=',')

values = [map(float,row) for row in csvReader]

def average(l):
    return float(sum(l)) / len(l)

#Averages with decimal places
averages = [float(average(trial)) for trial in zip(*values)]

#Print column averages - space delimited
print(" ".join(str(x) for x in averages))