#PBS -S /bin/bash
#PBS -q batch
#PBS -N stringtie
#PBS -l nodes=1:ppn=12
#PBS -l mem=15gb
#PBS -l walltime=48:00:00
#PBS -M daniel.shaw@uga.edu
#PBS -m ae

cd /lustre1/des65576/workDir/RNAdata911/Juvenile_Testis2-46375397/tophat_out

module load StringTie/1.3.4d-foss-2016b

stringtie accepted_hits.bam -g Glazer.gtf -o Testis3.gff
