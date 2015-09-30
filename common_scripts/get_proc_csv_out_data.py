#!/usr/bin/python3
#Input text from proc_csv_out concatenated output(s) and puts in *csv file for R analysis
#JP Tomkins <jtomkins@icr.org>, 7-14-2015

import sys
import re

args = sys.argv[1:]
if len(args) != 1 :
    print("Error!  Argument needed: input file name")
    sys.exit()
inFileName = args[0]
fo = open(inFileName + "parsed.csv", 'w')

#Grab numerical data from input file and put into separate arrays
ail, aal, aql, nqs, nqh, phf, pqi, odi = ([] for i in range(8))

def getNums(searchText, arrayName):
	with open(inFileName, 'r') as f:
		for line in f.readlines():
			if line.startswith(searchText):
				num = re.findall(r"[-+]?\d*\.*\d+", line) # Not always a decimal number
				arrayName.append(str(''.join(num))) #re.findall returns num as list - convert to string with .join()
				f.close()					  		#and make total result a string for easy printing later

getNums('Ave % identity align', ail)
getNums('Ave alignment length', aal)
getNums('Ave query seq length', aql)
getNums('Number of query seqs', nqs)
getNums('Number of query hits', nqh)
getNums('Ave % hit frequency', phf)
getNums('Ave % query identity', pqi)
getNums('Overall DNA identity', odi)

#Grab the data set name and and put in array
dsn = [] 
with open(inFileName, 'r') as fi:
	for line in fi.readlines(): 
		if 'proc_csv_out' in line:
			dataSetName = re.findall(r"chr\d.*csv", line)
			dsn.append(str(''.join(dataSetName)))
			fi.close()

#Write headers for csv file
fo.write('data_set,ident_aln,aln_len,qseq_len,num_qseqs,num_qhits,hit_freq,query_ident,overall_ident\n')

#Print the csv file data line by line by popping each array
for i in range(len(ail)): 
	fo.write(dsn.pop(0)+','+ail.pop(0)+','+aal.pop(0)+','+aql.pop(0)+','+nqs.pop(0)+','+nqh.pop(0)+','+phf.pop(0)+','+pqi.pop(0)+','+odi.pop(0)+'\n')

# Close write file and exit
fo.close()
sys.exit()