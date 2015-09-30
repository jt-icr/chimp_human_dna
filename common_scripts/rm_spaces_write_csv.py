#!/usr/bin/python3
#Strip input file of white space and add commas to make csv
import sys

args = sys.argv[1:]
if len(args) != 1 :
    print("Error!  Argument needed: input file name")
    sys.exit()

inFileName = args[0]
fi = open(inFileName, 'r')
fo = open(inFileName + ".csv", 'w')
		
#For each line in input file
for line in fi:
	outLine = ''
	outLine = ','.join(line.split())
	fo.write(outLine + '\n')

#Close write file and exit
fi.close()
fo.close()
exit()
