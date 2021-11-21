###ADAPTED FROM: custom script by Elizabeth Lee

###INSTALLATION
#install.packages("remotes")
#remotes::install_github("zakrobinson/RLDNe")

#if (!requireNamespace("BiocManager", quietly = TRUE))
#install.packages("BiocManager")
#BiocManager::install("SNPRelate")

#if (!requireNamespace("BiocManager", quietly = TRUE))
#  install.packages("BiocManager")
#BiocManager::install("qvalue")

#library("devtools")
#install_github("jdstorey/qvalue")

###CLEAR BUFFERS
rm(list=ls())
###SET DIRECTORY
setwd("C:/Users/vaufe36p/Documents/R/otago-rdata")

###LOAD LIBRARIES (these call on adegenet)
library(dartR)
library(hierfstat)
library(vcfR)

#LOAD DATA FOR MAIN DATASET
#kaik-ant-7-p1-r70-B
vcf <- vcfR::read.vcfR("kaik-ant-7-p1-r70-B.vcf")
popInFile <- read.csv("kaik-ant-7-p1-r70-B-P15.csv", header=FALSE) #Using 15 groups
popNames <- c("A", "B","C","D","E","F","G","H","I","J","K","M","N","O")

#MAKE GENIND OBJECT FROM VCF
x <- vcfR2genind(vcf)
x

#POP NAMES FOR GENIND
pop.names <- popInFile$V1
length(pop.names)
pop(x)= pop.names

#MAKE HIERFSTAT FROM GENIND
x2 <- genind2hierfstat(x) 

#SUMMARY STATISTICS OVERALL
basicstat <- basic.stats(x2, diploid = TRUE, digits = 2) 
names(basicstat)   

allelic<-allelic.richness(x2,diploid=TRUE)
colnames(allelic$Ar) <- popNames
obs.het<-data.frame(basicstat$Ho)
exp.het<-data.frame(basicstat$Hs)
pop.freq<-data.frame(basicstat$pop.freq)
fis<-data.frame(basicstat$Fis)
perloc<-data.frame(basicstat$perloc)
overall<-data.frame(basicstat$overall)
overall

#SUMMARY STATS PER POP (allows NA values)
obs.het.Mean <- colMeans(obs.het, na.rm = FALSE, dims = 1)
obs.het.Mean
exp.het.Mean <- colMeans(exp.het, na.rm = FALSE, dims = 1)
exp.het.Mean
fis.Mean <- colMeans(fis, na.rm = FALSE, dims = 1)
fis.Mean
allelic.Mean <- colMeans(allelic$Ar, na.rm = FALSE, dims = 1)
allelic.Mean

#SUMMARY STATS PER POP (NA values removed)
obs.het.Mean <- colMeans(obs.het, na.rm = TRUE, dims = 1)
obs.het.Mean
exp.het.Mean <- colMeans(exp.het, na.rm = TRUE, dims = 1)
exp.het.Mean
fis.Mean <- colMeans(fis, na.rm = TRUE, dims = 1)
fis.Mean
allelic.Mean <- colMeans(allelic$Ar, na.rm = TRUE, dims = 1)
allelic.Mean

#CONFIDENCE INTERVALS FOR FIS PER POP
fis.CI <- boot.ppfis(x2)
fis.CI