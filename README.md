# kaikoura_d_antarctica_GBS
Commands and input files for the phylogeographic analysis of southern bull kelp Durvillaea antarctica using genotyping-by-sequencing data. Used to analyse population genomic variation for Kaikōura and Rarangi. 

# Associated publications
Vaux F, Parvizi E, Duffy GA, Dutoit L, Craw D, Waters JM. First genomic snapshots of recolonising lineages following a devastating earthquake. (submitted)

Vaux F, Fraser CI, Craw D, Read S, Waters JM. (2023). Integrating kelp genomic analyses and geological data to reveal ancient earthquake impacts. Journal of the Royal Society Interface 20, 20230105. https://doi.org/10.1098/rsif.2023.0105

# Sample details and supplementary methods
## For the Kaikoura analysis:
TBC

## For the Rarangi analysis:
Full sample details (Supplementary A), supplementary methods, results, tables, and figures (Supplementary B) available here.

# Connectivity analysis for the Kaikoura study
Commented R files and log files for the R environment and Moana dataset are provided in the Kaikoura_dispersal_analysis folder here. Since the MetOcean Moana dataset is proprietary, we cannot provide the source data here. If users gain access to the Moana dataset, the R scripts should allow for the data to be full reproducible.

# Genotype, loci fasta and tree files
GBS files (loci consensus sequences, genotype files, phylogenetic alignments, and tree files are available here as 'Kaikoura-Rarangi-genotype-files.zip'.

# Demultiplexed reads
Demultiplexed forward and reverse DNA sequence reads for the southern bull-kelp sequenced in this study are openly available on the NCBI sequence read archive (SRA) under: PRJNA780921, https://www.ncbi.nlm.nih.gov/sra/PRJNA780921

# Raw Illumina reads
Available on request, and we're working to archive all southern bull kelp raw reads on NCBI in the near future.

# Further information
See this page: https://sites.google.com/view/evauxlution/data

# Stacks
Shell files with commands and parameter settings used for each STACKS run.

# maps
Maps used to select individuals and populations in STACKS runs.

# excluded_loci
Lists used to exclude certain loci in STACKS runs.

# plink-ld
Ped and map input files and shell file with settings used by plink to estimate loci in LD.

# vcftools-highly-correlated
Shell file with commands and the recoded VCF files used to estimate highly correlated loci (additional filtering step for alternative filtered dataset). Text file lists loci added for alternative dataset excluded loci list. 

# vcftools-low-coverage
Shell file with commands and the recoded VCF files used to estimate low coverage genotypes and loci (first filtering step). Text file lists loci added for first list of excluded loci.

# R
R files for running loci filtering (e.g. loci coverage depth outliers) and population genetic analyses (e.g. adegenet, LEA). I recommmend viewing original source GitHub pages and tutorials noted in each R file credits. Includes example R project and geno files for LEA analyses.

# Trees
Shell files and commands for estimating maxmimum-likelihood (ML) and neighbour-joining (NJ) trees for both datasets, using IQtree and VCFkit respectively. Each folder includes an annotated tree file.
