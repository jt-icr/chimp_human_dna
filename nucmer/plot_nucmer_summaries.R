#Reset R
rm(list=ls())

#Tell R where to go
setwd("/Users/jtomkins/data/new_chimp_analysis/mummer/chimp_on_human/")

#Confirm location
getwd()

#List files in directory
dir(path = ".")
dir()

ident <- read.csv("R_nucmer_summary_perc_ident.txt.csv")
#To get proper order for X axis in plot...
#Turn 'Chrom column into a character vector
ident$Chrom <- as.character(ident$Chrom)
#Then turn it back into an ordered factor
ident$Chrom <- factor(ident$Chrom, levels=unique(ident$Chrom))
str(ident)
summary(ident)

aln <- read.csv("R_nucmer_summary_aln_len.txt.csv")
#To get proper order for X axis in plot...
#Turn 'Chrom column into a character vector
aln$Chrom <- as.character(aln$Chrom)
#Then turn it back into an ordered factor
aln$Chrom <- factor(aln$Chrom, levels=unique(aln$Chrom))
str(aln)
summary(aln)

library(ggplot2)
#library(RColorBrewer)

p.ident <- ggplot(ident, aes (x=factor(Chrom), y=Mean)) +
  geom_bar(stat="identity", position="dodge", fill="darkseagreen") +
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

p.aln <- ggplot(aln, aes (x=factor(Chrom), y=Mean)) +
  geom_bar(stat="identity", position="dodge", fill="darkseagreen") +
  labs(x="Chimp chromosome", y= "Mean alignment length (bases)", title="Average Alignment Length - Chimp on Human") +
  theme(axis.text.x = element_text(face="bold", color="darkblue", size=20)) +
  theme(axis.text.x = element_text(angle=60)) +
  theme(axis.text.y = element_text(face="bold", color="firebrick", size=20)) + 
  scale_y_continuous(breaks=c(0,300,600,900,1200,1500)) +
  theme(axis.title = element_text(size=20,face="bold")) +
  theme(plot.title = element_text(lineheight=.8, face="bold", size=25, color = "chocolate4")) +
  theme( axis.line = element_line(colour = "black", 
                                  size = 1, linetype = "solid"))
p.aln