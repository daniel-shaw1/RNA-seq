#PBS -S /bin/bash
#PBS -q batch
#PBS -N trim
#PBS -l nodes=1:ppn=24
#PBS -l mem=20gb
#PBS -l walltime=24:00:00



cd /scratch/des65576/2935-145055919/LWL2M/
module load Trimmomatic/0.36-Java-1.8.0_144


for file in *R1*

do
  export iden=${file%%.fastq.gz}
  export log=${iden}.log
  export output=${iden}_trim.fastq.gz
java -jar /usr/local/apps/eb/Trimmomatic/0.36-Java-1.8.0_144/trimmomatic-0.36.jar PE -threads 16 -phred64 -trimlog ${bam}.log -basein ${file} -baseout ${output}_trim.fastq.gz ILLUMINACLIP:/usr/local/apps/eb/Trimmomatic/0.36-Java-1.8.0_144/adapters/NexteraPE-PE.fa:2:30:10 LEADING:0 TRAILING:0 MINLEN:30 SLIDINGWINDOW:4:20
done


cd /scratch/des65576/2935-145055919/LWT2/
for file in *R1*

do
  export iden=${file%%.fastq.gz}
  export log=${iden}.log
  export output=${iden}_trim.fastq.gz
java -jar /usr/local/apps/eb/Trimmomatic/0.36-Java-1.8.0_144/trimmomatic-0.36.jar PE -threads 16 -phred64 -trimlog ${bam}.log -basein ${file} -baseout ${output}_trim.fastq.gz ILLUMINACLIP:/usr/local/apps/eb/Trimmomatic/0.36-Java-1.8.0_144/adapters/NexteraPE-PE.fa:2:30:10 LEADING:0 TRAILING:0 MINLEN:30 SLIDINGWINDOW:4:20
done

