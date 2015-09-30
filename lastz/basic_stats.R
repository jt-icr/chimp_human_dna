#Basic nucmer stats

#Reset R
rm(list=ls())
#Tell R where to go
setwd("/Users/jtomkins/data/new_chimp_analysis/lastz")

#Confirm location
getwd()

#List files in directory
dir(path = ".")

#Read in data from csv file
chrY <- read.csv("chrY_homo_vs_chimp_10000slice.dat.csv")

names(chrY)

summary(chrY$ident)
sd(chrY$ident)

summary(chrY$aln_len)
sd(chrY$aln_len)

#Get basic statistics
summary(chrY)

    