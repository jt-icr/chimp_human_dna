setwd("/Users/jtomkins/data/blast_test")

#Reset R
rm(list=ls())

#Get and check data
bd <- read.csv("blast_results_expanded.csv")

#Create new column with percent hits
bd$perc_hits <- (bd$num_hits / bd$num_query_seqs) * 100
#create new column with seqs per second
bd$seqs_per_sec <- bd$num_query_seqs / bd$run_time

#Modify ident for plotting purposes 
bd$ident <- bd$ident*100

#Set factors and labels
bd$blast_ver <- factor(bd$blast_ver, order=TRUE)
bd$data_sets <- factor(bd$num_query_seqs, labels=c("10","100","1,000","10,000","100,000"), order=TRUE)

#Add dataframe to R search path
attach(bd)

#check data
head(bd)
tail(bd)
dim(bd)
str(bd)

#get means of treatment combos
with(bd, tapply(perc_hits, list(blast_ver,num_query_seqs), mean))
with(bd, tapply(run_time, list(blast_ver,num_query_seqs), mean))
with(bd, tapply(seqs_per_sec, list(blast_ver,num_query_seqs), mean))
with(bd, tapply(ident, list(blast_ver,num_query_seqs), mean))

#run basic aov
aov.hits = aov(perc_hits ~ blast_ver * num_query_seqs, data=bd)
summary(aov.hits)
summary.lm(aov.hits)

aov.time = aov(run_time ~ blast_ver * num_query_seqs, data=bd)
summary(aov.time)
summary.lm(aov.time)

aov.ident = aov(ident ~ blast_ver * num_query_seqs, data=bd)
summary(aov.ident)
summary.lm(aov.ident)

aov.seqs_per_sec = aov(seqs_per_sec ~ blast_ver * num_query_seqs, data=bd)
summary(aov.seqs_per_sec)
summary.lm(aov.seqs_per_sec)

#post hoc tests
#Tukey multiple comparisons of means for different blast versions
TukeyHSD(aov.hits)
with(bd, pairwise.t.test(blast_ver, num_query_seqs,
                               p.adjust.method="bonferroni"))
TukeyHSD(aov.time)
with(bd, pairwise.t.test(blast_ver, num_query_seqs,
                         p.adjust.method="bonferroni"))

TukeyHSD(aov.ident)
with(bd, pairwise.t.test(blast_ver, num_query_seqs,
                         p.adjust.method="bonferroni"))

TukeyHSD(aov.seqs_per_sec)
with(bd, pairwise.t.test(blast_ver, num_query_seqs,
                         p.adjust.method="bonferroni"))

TukeyHSD(aov.perc_hits)
with(bd, pairwise.t.test(blast_ver, num_query_seqs,
                         p.adjust.method="bonferroni"))

#glm
lm.hits <- lm(perc_hits ~ blast_ver + num_query_seqs + blast_ver:num_query_seqs, data=bd)
summary(lm.hits)
plot(perc_hits ~ blast_ver, data=bd)

lm.time <- lm(run_time ~ blast_ver + num_query_seqs + blast_ver:num_query_seqs, data=bd)
summary(lm.time)

lm.seqs_per_sec <- lm(seqs_per_sec ~ blast_ver + num_query_seqs + blast_ver:num_query_seqs, data=bd)
summary(lm.seqs_per_sec)

lm.ident <- lm(ident ~ blast_ver + num_query_seqs + blast_ver:num_query_seqs, data=bd)
summary(lm.ident)

lm.ident <- lm(ident ~ blast_ver + num_query_seqs + blast_ver:num_query_seqs, data=bd)
summary(lm.ident)

#Plot and correlation
opar <- par(no.readonly=TRUE)
par(fig=c(0,0.8,0,0.8))
plot(perc_hits~seqs_per_sec, xlab="Sequences per Second", ylab="Percent Hits", col.lab="darkgreen",
     cex.lab=1.3, pch=17, fg="darkblue")
#title(main="Regression of Percent Hits on BLASTN Speed", col.main="darkred", cex.main=2)
abline(lm(perc_hits~seqs_per_sec), lty=2, lwd=2) #Fit a broken line, twice default width
par(fig=c(0,0.8,0.55,1), new=TRUE) #Add boxplot
boxplot(perc_hits, horizontal=TRUE, axes=FALSE)
par(fig=c(0.65,1,0,0.8), new=TRUE) #Add boxplot
boxplot(seqs_per_sec,axes=FALSE)

mtext("Regression of Percent Hits on BLASTN Speed", side=3, outer=TRUE,line=-3,
      col="darkred", cex=2)

par(opar)

cor(bd$perc_hits, bd$seqs_per_sec)
summary(lm(perc_hits~seqs_per_sec))

#plot the data with ggplot2
library(ggplot2)
library(gridExtra)
library(RColorBrewer)

############
#basic plots
############
p1 <- ggplot(bd, aes(x = factor(blast_ver), y=perc_hits, fill=factor(blast_ver))) +
  stat_summary(fun.y=mean, geom="bar", fill="lightgreen")
p2 <- ggplot(bd, aes(x = factor(blast_ver), y=run_time, fill=factor(blast_ver))) +
  stat_summary(fun.y=mean, geom="bar", fill="lightgreen")
p3 <- ggplot(bd, aes(x = factor(blast_ver), y=seqs_per_sec, fill=factor(blast_ver))) +
  stat_summary(fun.y=mean, geom="bar", fill="lightgreen")
p4 <- ggplot(bd, aes(x = factor(blast_ver), y=ident, fill=factor(blast_ver))) +
  stat_summary(fun.y=mean, geom="bar", fill="lightgreen")

grid.arrange(p3, p1, nrow=2) 
grid.arrange(p1, p2, nrow=1) 
grid.arrange(p2, p3, nrow=1) 
p4

######################
#plots with error bars
#####################
#percent hits
summary.bd.perc_hits <- data.frame(
  blast_ver=levels(as.factor(bd$blast_ver)),
  mean_perc_hits=tapply(bd$perc_hits, bd$blast_ver, mean),
  sd=tapply(bd$perc_hits, bd$blast_ver, sd))
summary.bd.perc_hits
p.phits <- ggplot(summary.bd.perc_hits, aes (x=factor(blast_ver), y=mean_perc_hits)) +
    geom_bar(stat="identity", position="dodge", fill="lightblue") +
    geom_errorbar(aes(ymin=mean_perc_hits-sd, ymax=mean_perc_hits+sd), width=.3, color="darkblue") +
    labs(x="BLASTN version", y= "Percent of query sequences with hits", title="Percent Query Hits for Different Versions of BLASTN") +
    theme(axis.text.x = element_text(face="bold", color="firebrick", size=20)) +
    theme(axis.text.y = element_text(face="bold", color="firebrick", size=20)) +
    theme(axis.title = element_text(size=20,face="bold")) +
    theme(plot.title = element_text(lineheight=.8, face="bold", size=25, color = "darkgreen"))
p.phits

#seqs per sec
summary.bd.seqs_per_sec <- data.frame(
  blast_ver=levels(as.factor(bd$blast_ver)),
  mean_seqs_per_sec=tapply(bd$seqs_per_sec, bd$blast_ver, mean),
  sd=tapply(bd$seqs_per_sec, bd$blast_ver, sd))
summary.bd.seqs_per_sec
p.spc <- ggplot(summary.bd.seqs_per_sec, aes (x=factor(blast_ver), y=mean_seqs_per_sec)) +
    geom_bar(stat="identity", position="dodge", fill="lightblue") +
    geom_errorbar(aes(ymin=mean_seqs_per_sec-sd, ymax=mean_seqs_per_sec+sd), width=.3, color="darkblue") +
    labs(x="BLASTN version", y= "Mean query sequences searched per second", title="Search Speeds for Different Versions of BLASTN") +
    theme(axis.text.x = element_text(face="bold", color="firebrick", size=20)) +
    theme(axis.text.y = element_text(face="bold", color="firebrick", size=20)) +
    theme(axis.title = element_text(size=20,face="bold")) +
    theme(plot.title = element_text(lineheight=.8, face="bold", size=25, color = "darkgreen"))
p.spc

#identity
summary.bd.ident <- data.frame(
  blast_ver=levels(as.factor(bd$blast_ver)),
  mean_ident=tapply(bd$ident, bd$blast_ver, mean),
  sd=tapply(bd$ident, bd$blast_ver, sd))
summary.bd.ident
p.ident <- ggplot(summary.bd.ident, aes (x=factor(blast_ver), y=mean_ident)) +
    geom_bar(stat="identity", position="dodge", fill="lightblue") +
    geom_errorbar(aes(ymin=mean_ident-sd, ymax=mean_ident+sd), width=.3, color="darkblue") +
    labs(x="BLASTN version", y= "Mean percent identity", title="Percent Identity for Different Versions of BLASTN") +
    theme(axis.text.x = element_text(face="bold", color="firebrick", size=20)) +
    theme(axis.text.y = element_text(face="bold", color="firebrick", size=20)) +
    theme(axis.title = element_text(size=20,face="bold")) +
    theme(plot.title = element_text(lineheight=.8, face="bold", size=25, color = "darkgreen"))
p.ident

grid.arrange(p.phits, p.spc, nrow=2) 

##########################
#Plots  with No error bars
##########################

#percent hits
summary.bd.perc_hits <- data.frame(
  blast_ver=levels(as.factor(bd$blast_ver)),
  mean_perc_hits=tapply(bd$perc_hits, bd$blast_ver, mean))
summary.bd.perc_hits
phits <- ggplot(summary.bd.perc_hits, aes (x=factor(blast_ver), y=mean_perc_hits)) +
  geom_bar(stat="identity", position="dodge", fill="lightblue") +
  labs(x="BLASTN version", y= "Percent of query sequences with hits", title="Percent Query Hits for Different Versions of BLASTN") +
  theme(axis.text.x = element_text(face="bold", color="firebrick", size=20)) +
  theme(axis.text.y = element_text(face="bold", color="firebrick", size=20)) +
  theme(axis.title = element_text(size=20,face="bold")) +
  theme(plot.title = element_text(lineheight=.8, face="bold", size=25, color = "darkgreen"))
phits

#seqs per sec
summary.bd.seqs_per_sec <- data.frame(
  blast_ver=levels(as.factor(bd$blast_ver)),
  mean_seqs_per_sec=tapply(bd$seqs_per_sec, bd$blast_ver, mean))
summary.bd.seqs_per_sec
spc <- ggplot(summary.bd.seqs_per_sec, aes (x=factor(blast_ver), y=mean_seqs_per_sec)) +
  geom_bar(stat="identity", position="dodge", fill="lightblue") +
  #geom_errorbar(aes(ymin=mean_seqs_per_sec-sd, ymax=mean_seqs_per_sec+sd), width=.3, color="darkblue") +
  labs(x="BLASTN version", y= "Mean query sequences searched per second", title="Search Speeds for Different Versions of BLASTN") +
  theme(axis.text.x = element_text(face="bold", color="firebrick", size=20)) +
  theme(axis.text.y = element_text(face="bold", color="firebrick", size=20)) +
  theme(axis.title = element_text(size=20,face="bold")) +
  theme(plot.title = element_text(lineheight=.8, face="bold", size=25, color = "darkgreen"))
spc

grid.arrange(phits, spc, nrow=2)

########################
#Some box plots
########################

opar <- par(no.readonly=TRUE)
par(col.lab="red", cex=1.7)

plot(blast_ver, perc_hits)
title(main="Percent Hits", col.main="darkred", cex.main=2)

plot(blast_ver, seqs_per_sec)
title(main="Algorithm Speed", col.main="darkred", cex.main=2)

par(opar)

###############################
#Plot treatment means 
###############################
library(gridExtra)

ph.v25 <- subset(bd, select=c(blast_ver,perc_hits,num_query_seqs), subset=(blast_ver=="2.2.25+")) 
ph.v26 <- subset(bd, select=c(blast_ver,perc_hits,num_query_seqs), subset=(blast_ver=="2.2.26+"))
ph.v27 <- subset(bd, select=c(blast_ver,perc_hits,num_query_seqs), subset=(blast_ver=="2.2.27+"))
ph.v28 <- subset(bd, select=c(blast_ver,perc_hits,num_query_seqs), subset=(blast_ver=="2.2.28+"))
ph.v29 <- subset(bd, select=c(blast_ver,perc_hits,num_query_seqs), subset=(blast_ver=="2.2.29+")) 
ph.v30 <- subset(bd, select=c(blast_ver,perc_hits,num_query_seqs), subset=(blast_ver=="2.2.30+")) 

m.ph.v25 <- tapply(ident, list(blast_ver,num_query_seqs), mean))



p1 <- plot(perc_hits ~ num_query_seqs, data=ph.v25)
p2 <- plot(perc_hits ~ num_query_seqs, data=ph.v26)
p3 <- plot(perc_hits ~ num_query_seqs, data=ph.v27)
p4 <- plot(perc_hits ~ num_query_seqs, data=ph.v28)
p5 <- plot(perc_hits ~ num_query_seqs, data=ph.v29)
p6 <- plot(perc_hits ~ num_query_seqs, data=ph.v30)



