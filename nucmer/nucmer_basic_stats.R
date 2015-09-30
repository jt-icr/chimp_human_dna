#Reset R
rm(list=ls())

#Tell R where to go
setwd("/Users/jtomkins/data/new_chimp_analysis/mummer/chimp_on_human/chrY")

#Confirm location
getwd()

#List files in directory
dir(path = ".")
dir()

#Read in data from csv file
chrY <- read.csv("chrY_coords.csv")

#create new column with ave alignment length
chrY$Ave_Aln_Len <- (chrY$Reference + chrY$Query) / 2

summary(chrY$Perc_Ident)
sd(chrY$Perc_Ident)

summary(chrY$Ave_Aln_Len)
sd(chrY$Ave_Aln_Len)
