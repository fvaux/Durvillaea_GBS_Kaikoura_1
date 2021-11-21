#!/bin/sh
#SBATCH -A uoo02915
#SBATCH -t 00:30:00
#SBATCH --mem=3G
#SBATCH -J ld-kaik-ant-7-p1-r70-1
#SBATCH --hint=nomultithread
#SBATCH -D /nesi/nobackup/uoo02915/PLINK

module load PLINK

plink --file kaik-ant-7-p1-r70-1.plink --r2 --ld-window-r2 0.8 --out ld-kaik-ant-7-p1-r70-1 --allow-extra-chr
