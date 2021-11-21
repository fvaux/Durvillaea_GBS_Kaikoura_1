#!/bin/sh
#SBATCH -A uoo02915
#SBATCH -t 00:15:00
#SBATCH --mem=3G
#SBATCH -J vcf2-kaik-ant-7-p1-r70-B
#SBATCH --hint=nomultithread
#SBATCH -D /nesi/nobackup/uoo02915/vcf2phylip

module load Miniconda3
python vcf2phylip.py  -i kaik-ant-7-p1-r70-B.vcf