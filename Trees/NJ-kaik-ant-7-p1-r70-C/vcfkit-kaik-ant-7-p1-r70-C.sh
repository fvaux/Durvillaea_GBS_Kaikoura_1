#!/bin/sh
#SBATCH -A uoo02915
#SBATCH -t 10:00:00
#SBATCH --mem=8G
#SBATCH --hint=nomultithread
#SBATCH -J vcfk-kaik-ant-7-p1-r70-C
#SBATCH -D /nesi/nobackup/uoo02915/VCF-kit2

module load VCF-kit/0.2.6-gimkl-2020a-Python-3.8.2 #load VCF-kit
vk phylo tree nj kaik-ant-7-p1-r70-C.vcf #Generate NJ tree from vcf file