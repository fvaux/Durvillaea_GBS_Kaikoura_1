###ADAPTED FROM: http://popgen.nescent.org/DifferentiationSNP.html
###CREDIT: Stephanie Manel (author), Zhian Kamvar (edits)

###CLEAR BUFFERS
rm(list=ls())
###SET DIRECTORY
setwd("C:/Users/vaufe36p/Documents/R/otago-rdata")

###LOAD LIBRARIES
library(adegenet)
library(vegan)
library(car)
library(rgl)

###DATA FORMAT
###PACKAGE WANTS FSTAT .DAT INPUT FILE
#1. SAVE GENEPOP FILE AS GENEPOP.TXT
#2. CONVERT GENEPOP FILE TO FSTAT .DAT FILE USING PGDSPIDER

###IMPORT DURVILLAEA ANTARCTICA DATA
data<-read.fstat("kaik-ant-7-p1-r70-B-P15.dat", quiet=FALSE) #main dataset with 15 groups
data<-read.fstat("kaik-ant-7-p1-r70-C-P15.dat", quiet=FALSE) #alternative dataset with 15 groups


#PCA 15 REGIONS FOR KAIKOURA D. ANTARCTICA ~~~~~~~~RECOLOURED
pop <- data$pop
#print(pop)
X <- tab(data, NA.method="mean")
temp <- as.integer(pop(data))
#***~~~~~~~explore only PC1 and PC2
pca1 <- dudi.pca(X,scannf=FALSE,scale=FALSE, nf=2)
myCol <- transp(c("turquoise3","turquoise1", "chartreuse2","chartreuse4","dodgerblue1","dodgerblue4","red1","red3","purple1","purple4","gold","goldenrod","grey70","grey40","black"),.5)[temp]
myPch <- c(18,18,16,16,16,16,16,16,16,16,16,16,18,18,18)[temp]
plot(pca1$li, col=myCol, cex=3, pch=myPch)

#***~~~~~~~change nf to explore additional axes (e.g. nf=3) ~~~~~~~~RECOLOURED
pca1 <- dudi.pca(X,scannf=FALSE,scale=FALSE, nf=3)
myCol <- transp(c("turquoise3","turquoise1", "chartreuse2","chartreuse4","dodgerblue1","dodgerblue4","red1","red3","purple1","purple4","gold","goldenrod","grey70","grey40","black"),.5)[temp]
myPch <- c(18,18,16,16,16,16,16,16,16,16,16,16,18,18,18)[temp]
plot(pca1$li, col=myCol, cex=3, pch=myPch)
#ADD SCATTER PLOT TO PCA PLOT (IF DESIRED)
add.scatter.eig(pca1$eig[1:25], xax=1, yax=2)

#############################################################
#export PC loadings for samples
#Export loadings for multiple PCs (need to change nf= in dudi.pca function above)
write.csv(pca1$li$Axis1,file="pc1-load.csv",row.names=TRUE,quote=FALSE)
write.csv(pca1$li$Axis2,file="pc2-load.csv",row.names=TRUE,quote=FALSE)
write.csv(pca1$li$Axis3,file="pc3-load.csv",row.names=TRUE,quote=FALSE)

##export list of eigen values and percentage variances for each PC
#eigen values for PCs
eig.val<-pca1$eig
eig.val
#percentages of variance for each PC
eig.perc <- 100*pca1$eig/sum(pca1$eig)
eig.perc
eigen<-data.frame(eig.val,eig.perc)
eigen
#writing file with both
write.csv(eigen,file="eigen-summary.csv",row.names=TRUE,quote=FALSE)

#############################################################
#broken stick test to determine number of 'meaningful' PCs
#(technically no such thing as statistical significance for PCs)
#Load .csv file with listed PCs and eigen values
xx<-read.csv("eigen-summary.csv")
#xx is the eigenvalues
zz<-as.data.frame(bstick(50,tot.var=sum(xx$eig.val)))
# zz is the broken stick model
components<-seq(from=1, to=nrow(xx), by=1)
xx$comp<-components
components2<-seq(from=1, to=nrow(zz), by=1)
zz$comp<-components2
plot(xx$comp, xx$eig.val, type="h")
lines(zz$comp, zz[,1], col="red")
#If above red line = meaningful according to broken-stick test
#If below red line = non-meaningful according to broken-stick test
###Generally this corresponds to PCs that explain >5% of variance among samples

#If no PCs are meaningful, it is likely that variance among samples is low, and that there is limited genetic structuring
#There may still be weak trends or minor structure among your samples
#Important: still worth exploring non-meaningful PCs to check data, especially if there is an obvious step change in eigen values

#############################################################
#'allele contributions' i.e. PC loading plot for each locus
#PC1
loadingplot(pca1$c1^2)

#Export PC1 loadings to csv file
PC1_loci<-pca1$c1^2
write.csv(PC1_loci,file="PC1_loci.csv",row.names=TRUE,quote=FALSE)
