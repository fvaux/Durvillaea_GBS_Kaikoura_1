#!/bin/sh
#SBATCH -A uoo02915
#SBATCH -t 10:00:00
#SBATCH --mem=6G
#SBATCH -c 10
#SBATCH -J IQT-kaik-ant-7-p1-r70-C
#SBATCH -D /nesi/nobackup/uoo02915/IQTREE2

module load Miniconda3 #load Miniconda3
source activate iqtree # access your environment

iqtree -nt 10 -s kaik-ant-7-p1-r70-C.min4.phy -st DNA -bb 10000 -pre inferred -redo