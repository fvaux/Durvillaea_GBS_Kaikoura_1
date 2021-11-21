###CLEAR BUFFERS
rm(list=ls())
###SET DIRECTORY
setwd("C:/Users/vaufe36p/Documents/R/otago-rdata")

###LOAD LIBRARIES
library(LEA)

###INPUT FILE AND CONVERSION
#LEA uses the lfmm and geno formats, and provides functions to convert from other formats (ped, vcf, ancestrymap)

##Conversion of a STACKS structure file to the lfmm and geno formats
#Manually need to add 'ID' and 'Pop' column labels to structure file
#Manually need to change file extension from structure.tsv to .str?
#FORMAT 2 = two rows per individual
#help(struct2geno)
struct2geno("kaik-ant-7-p1-r70-B.str", ploidy = 2, FORMAT = 2, extra.row = 1, extra.column = 2) #EXAMPLE DATASET, CHANGE INPUT FILENAME AS NECESSARY


##LEA ADMIXTURE ANALYSIS
##Inference of individual admixture coeficients using snmf
#main options
#K = number of ancestral populations
#entropy = TRUE: computes the cross-entropy criterion,
#CPU = 4 the number of CPUs.
project = NULL
project = snmf("kaik-ant-7-p1-r70-B.str.geno",
               K = 1:10,
               entropy = TRUE,
               repetitions = 10,
               project = "new",
               CPU = 4)

par(mfrow=c(1,1))  #ensure that cross entropy is printed alone (recommend printing to PDF 10 x 10)
#plot cross-entropy criterion for all runs in the snmf project
#lowest value = best supported model
plot(project, col = "blue", pch = 19, cex = 1.2)


##Plot all assignment probability plots
par(mfrow=c(4,1))  #plot PCs in grid

#K = 2
best = which.min(cross.entropy(project, K = 2))
my.colors <- c("blue1", "red1",
               "goldenrod1", "cyan", "magenta",
               "green1", "deepskyblue","yellow", "green4", "black")
barchart(project, K = 2, run = best, sort.by.Q = FALSE,
         border = NA, space = 0,
         col = my.colors,
         xlab = "Individuals",
         ylab = "Ancestry proportions",
         main = "Ancestry matrix") -> bp
axis(1, at = 1:length(bp$order),
     labels = bp$order, las=1,
     cex.axis = .4)

#K = 3
best = which.min(cross.entropy(project, K = 3))
my.colors <- c("blue1", "red1",
               "goldenrod1", "cyan", "magenta",
               "green1", "deepskyblue","yellow", "green4", "black")
barchart(project, K = 3, run = best, sort.by.Q = FALSE,
         border = NA, space = 0,
         col = my.colors,
         xlab = "Individuals",
         ylab = "Ancestry proportions",
         main = "Ancestry matrix") -> bp
axis(1, at = 1:length(bp$order),
     labels = bp$order, las=1,
     cex.axis = .4)

#K = 4
best = which.min(cross.entropy(project, K = 4))
my.colors <- c("blue1", "red1",
               "goldenrod1", "cyan", "magenta",
               "green1", "deepskyblue","yellow", "green4", "black")
barchart(project, K = 4, run = best, sort.by.Q = FALSE,
         border = NA, space = 0,
         col = my.colors,
         xlab = "Individuals",
         ylab = "Ancestry proportions",
         main = "Ancestry matrix") -> bp
axis(1, at = 1:length(bp$order),
     labels = bp$order, las=1,
     cex.axis = .4)

#K = 5
best = which.min(cross.entropy(project, K = 5))
my.colors <- c("blue1", "red1",
               "goldenrod1", "cyan", "magenta",
               "green1", "deepskyblue","yellow", "green4", "black")
barchart(project, K = 5, run = best, sort.by.Q = FALSE,
         border = NA, space = 0,
         col = my.colors,
         xlab = "Individuals",
         ylab = "Ancestry proportions",
         main = "Ancestry matrix") -> bp
axis(1, at = 1:length(bp$order),
     labels = bp$order, las=1,
     cex.axis = .4)

#K = 6
best = which.min(cross.entropy(project, K = 6))
my.colors <- c("blue1", "red1",
               "goldenrod1", "cyan", "magenta",
               "green1", "deepskyblue","yellow", "green4", "black")
barchart(project, K = 6, run = best, sort.by.Q = FALSE,
         border = NA, space = 0,
         col = my.colors,
         xlab = "Individuals",
         ylab = "Ancestry proportions",
         main = "Ancestry matrix") -> bp
axis(1, at = 1:length(bp$order),
     labels = bp$order, las=1,
     cex.axis = .4)

#K = 7
best = which.min(cross.entropy(project, K = 7))
my.colors <- c("blue1", "red1",
               "goldenrod1", "cyan", "magenta",
               "green1", "deepskyblue","yellow", "green4", "black")
barchart(project, K = 7, run = best, sort.by.Q = FALSE,
         border = NA, space = 0,
         col = my.colors,
         xlab = "Individuals",
         ylab = "Ancestry proportions",
         main = "Ancestry matrix") -> bp
axis(1, at = 1:length(bp$order),
     labels = bp$order, las=1,
     cex.axis = .4)

#K = 8
best = which.min(cross.entropy(project, K = 8))
my.colors <- c("blue1", "red1",
               "goldenrod1", "cyan", "magenta",
               "green1", "deepskyblue","yellow", "green4", "black")
barchart(project, K = 8, run = best, sort.by.Q = FALSE,
         border = NA, space = 0,
         col = my.colors,
         xlab = "Individuals",
         ylab = "Ancestry proportions",
         main = "Ancestry matrix") -> bp
axis(1, at = 1:length(bp$order),
     labels = bp$order, las=1,
     cex.axis = .4)

#K = 9
best = which.min(cross.entropy(project, K = 9))
my.colors <- c("blue1", "red1",
               "goldenrod1", "cyan", "magenta",
               "green1", "deepskyblue","yellow", "green4", "black")
barchart(project, K = 9, run = best, sort.by.Q = FALSE,
         border = NA, space = 0,
         col = my.colors,
         xlab = "Individuals",
         ylab = "Ancestry proportions",
         main = "Ancestry matrix") -> bp
axis(1, at = 1:length(bp$order),
     labels = bp$order, las=1,
     cex.axis = .4)

#K = 10
best = which.min(cross.entropy(project, K = 10))
my.colors <- c("blue1", "red1",
               "goldenrod1", "cyan", "magenta",
               "green1", "deepskyblue","yellow", "green4", "black")
barchart(project, K = 10, run = best, sort.by.Q = FALSE,
         border = NA, space = 0,
         col = my.colors,
         xlab = "Individuals",
         ylab = "Ancestry proportions",
         main = "Ancestry matrix") -> bp
axis(1, at = 1:length(bp$order),
     labels = bp$order, las=1,
     cex.axis = .4)

#Recommend printing each page of assignment plots to portrait orientation A4

#############################################################
#reload a previous project
project = load.snmfProject("cook-3-p6-p4-r70-Bstr.snmfProject") #example

#Formatting for figures
par(mfrow=c(4,1))  #plot PCs in grid
#select the best run for K = 4
best = which.min(cross.entropy(project, K = 10))
my.colors <- c("grey80", "purple1", "grey40", "grey70", "gold","turquoise1","dodgerblue1","black","red1","turquoise3") #Example, will need to change order manually as group order changes across values of K
barchart(project, K = 10, run = best, sort.by.Q = FALSE,
         border = NA, space = 0,
         col = my.colors,
         xlab = "Individuals",
         ylab = "Ancestry proportions",
         main = "Ancestry matrix") -> bp
axis(1, at = 1:length(bp$order),
     labels = bp$order, las=1,
     cex.axis = .4)