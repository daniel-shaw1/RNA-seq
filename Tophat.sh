#PBS -S /bin/bash
#PBS -q batch
#PBS -N tophat
#PBS -l nodes=1:ppn=12
#PBS -l mem=15gb
#PBS -l walltime=48:00:00
#PBS -M daniel.shaw@uga.edu
#PBS -m ae

cd /lustre1/des65576/Adult_Liver3-46373394/

module load TopHat/2.1.1-foss-2016b
module load Bowtie2/2.3.4.1-foss-2016b


export btBuild=/home/des65576/Glazer/GAC
export read1_list=`ls -m *1P* | tr -d ' \n'`
export read2_list=`ls -m *2P* | tr -d ' \n'`

tophat   ${btBuild} \
         ${read1_list} \
         ${read2_list} \
         ${outDir}/${bam}.sam
