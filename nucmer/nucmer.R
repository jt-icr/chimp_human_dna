#Basic nucmer stats

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
#Creat new column with chromosome ID
chrY$Chrom <- as.factor("chrY")

#Described and validate data
head(chrY) #Get first 6 lines of data file
names(chrY) #Get column labels
dim(chrY) #Get number of data lines and columns - dimensions
str(chrY) #Get description of data variables in columns - structure

#Get basic statistics
summary(chrY)

#correlation
cor(chrY$Ave_Aln_Len, chrY$Perc_Ident)

#################
## Plot data
#################
library(ggplot2)
library(scales)

#Data for box and violin
p.chrY.box <- ggplot(chrY, aes(x=Chrom, y=Perc_Ident))

#Display it in a basic violin plot
p.chrY.box + geom_violin()

#Display it in a violin plot overlaid by a boxplot
p.chrY.box + geom_violin(fill="lightblue") + 
  geom_boxplot(position=position_dodge(width=0.5), alpha=0.5, fill="cornsilk") +
  scale_y_continuous(breaks=c(75,80,85,90,95,100)) +
  labs(x="Alignment Length", y= "Percent Identity", title="Chromosome Y") +
  theme(axis.text = element_text(face="bold", color="firebrick", size=13)) +
  theme(axis.title=element_text(size=14,face="bold")) +
  theme(plot.title = element_text(lineheight=.8, face="bold", size=15))

#Basic scatter plot
###################
p.chrY.scatter <- ggplot(chrY, aes(x=Ave_Aln_Len, y=Perc_Ident))

p.chrY.scatter + geom_point(size=1.5) +
  scale_x_continuous(labels=comma, breaks=c(0,10000,30000,60000,90000,120000,150000)) +
  scale_y_continuous(breaks=c(75,80,85,90,95,100)) +
  labs(x="Alignment Length", y= "Percent Identity", title="Chromosome Y") +
  theme(axis.text = element_text(face="bold", color="firebrick", size=13)) +
  theme(axis.title=element_text(size=14,face="bold")) +
  theme(plot.title = element_text(lineheight=.8, face="bold", size=15))