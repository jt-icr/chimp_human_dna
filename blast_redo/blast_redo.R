#Reset R
rm(list=ls())

#Tell R where to go
setwd("/Users/jtomkins/data/new_chimp_analysis/")

#Confirm location
getwd()

#List files in directory
dir(path = ".")
dir()

#Get data
ident <- read.csv("blast_redo_summary.txtparsed.csv")
#To get proper order for X axis in plot...
#Turn 'Chrom column into a character vector
ident$Chrom <- as.character(ident$Chrom)
#Then turn it back into an ordered factor
ident$Chrom <- factor(ident$Chrom, levels=unique(ident$Chrom))
str(ident)
summary(ident)
names(ident)

#Get graphics library
library(ggplot2)

p.ident <- ggplot(ident, aes (x=factor(Chrom), y=ident$overall_ident)) +
  geom_bar(stat="identity", position="dodge", fill="darksalmon") +
  labs(x="Chimp chromosome", y= "Average (mean) Percent Identity", title="Average Percent Identity - Chimp on Human") +
  theme(axis.text.x = element_text(face="bold", color="darkblue", size=20)) +
  theme(axis.text.x = element_text(angle=60)) +
  theme(axis.text.y = element_text(face="bold", color="firebrick", size=20)) + 
  scale_y_continuous(breaks=c(0,50,85,90,100)) +
  theme(axis.title = element_text(size=20,face="bold")) +
  theme(plot.title = element_text(lineheight=.8, face="bold", size=25, color = "chocolate4")) +
  theme( axis.line = element_line(colour = "black", 
                                  size = 1, linetype = "solid"))
p.ident