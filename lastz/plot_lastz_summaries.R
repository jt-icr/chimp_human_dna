#Reset R
rm(list=ls())

#Tell R where to go
setwd("/Users/jtomkins/data/new_chimp_analysis/lastz")

#Confirm location
getwd()

#List files in directory
dir(path = ".")

ident <- read.csv("lastz_ident_summary.txt.csv")
#To get proper order for X axis in plot...
#Turn 'chrom column into a character vector
ident$chrom <- as.character(ident$chrom)
#Then turn it back into an ordered factor
ident$chrom <- factor(ident$chrom, levels=unique(ident$chrom))
str(ident)
summary(ident)

aln <- read.csv("lastz_aln_len_summary.txt.csv")
#To get proper order for X axis in plot...
#Turn 'chrom column into a character vector
aln$chrom <- as.character(aln$chrom)
#Then turn it back into an ordered factor
aln$chrom <- factor(aln$chrom, levels=unique(aln$chrom))
str(aln)
summary(aln)

library(ggplot2)

p.ident <- ggplot(ident, aes (x=factor(chrom), y=Mean)) +
  geom_bar(stat="identity", position="dodge", fill="darkseagreen") +
  labs(x="Chimp chromosome", y= "Average (mean) Percent Identity", title="Average Percent Identity - Chimp on Human") +
  theme(axis.text.x = element_text(face="bold", color="darkblue", size=20)) +
  theme(axis.text.x = element_text(angle=60)) +
  theme(axis.text.y = element_text(face="bold", color="firebrick", size=20)) + 
  scale_y_continuous(breaks=c(0,50,70,85)) +
  theme(axis.title = element_text(size=20,face="bold")) +
  theme(plot.title = element_text(lineheight=.8, face="bold", size=25, color = "chocolate4")) +
  theme( axis.line = element_line(colour = "black", 
                                  size = 1, linetype = "solid"))
p.ident

p.aln <- ggplot(aln, aes (x=factor(chrom), y=Mean)) +
  geom_bar(stat="identity", position="dodge", fill="darkseagreen") +
  labs(x="Chimp chromosome", y= "Mean alignment length (bases)", title="Average Alignment Length - Chimp on Human") +
  theme(axis.text.x = element_text(face="bold", color="darkblue", size=20)) +
  theme(axis.text.x = element_text(angle=60)) +
  theme(axis.text.y = element_text(face="bold", color="firebrick", size=20)) + 
  scale_y_continuous(breaks=c(0,1000,2000,3000,4000,5000,6000)) +
  theme(axis.title = element_text(size=20,face="bold")) +
  theme(plot.title = element_text(lineheight=.8, face="bold", size=25, color = "chocolate4")) +
  theme( axis.line = element_line(colour = "black", 
                                  size = 1, linetype = "solid"))
p.aln