#!/bin/sh
#SBATCH -A uoo02915
#SBATCH -t 20:00:00
#SBATCH --mem=10G
#SBATCH -c 12
#SBATCH -J kaik-ant-7
#SBATCH -D /nesi/nobackup/uoo02915/STACKS/stacks_out/kaik-ant-7

module load Stacks/2.53-gimkl-2020a
denovo_map.pl -T 12 -o /nesi/nobackup/uoo02915/STACKS/stacks_out/kaik-ant-7 --popmap /nesi/nobackup/uoo02915/STACKS/maps/kaik-ant-3.txt --samples /nesi/nobackup/uoo02915/STACKS/kaikoura-paired --paired -X "ustacks: -m 3 -M 2 --model_type bounded --bound_high 0.05" -X "cstacks:-n 2" -X "populations: -r 0.6 -p 1 --min-maf 0.05 --write-single-snp --structure --fstats --genepop --plink --vcf --hzar --fasta-loci --fasta-samples --phylip --phylip-var"