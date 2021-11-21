#!/bin/sh
#SBATCH -A uoo02915
#SBATCH -t 12:00:00
#SBATCH --mem=12G
#SBATCH -c 10
#SBATCH -J kaik-ant-7-p1-r70
#SBATCH -D /nesi/nobackup/uoo02915/STACKS/stacks_out/kaik-ant-7

module load Stacks/2.53-gimkl-2020a

populations -t 10 -P /nesi/nobackup/uoo02915/STACKS/stacks_out/kaik-ant-7 -M /nesi/nobackup/uoo02915/STACKS/maps/kaik-ant-3.txt -r 0.7 -p 1 --min-maf 0.05 --write-single-snp --write-single-snp --structure --fstats --genepop --plink --vcf --hzar --fasta-loci --fasta-samples --phylip --phylip-var