#PBS -S /bin/bash
#PBS -q batch
#PBS -N htseq
#PBS -l nodes=1:ppn=12:mwnode
#PBS -l mem=10gb
#PBS -l walltime=24:00:00
#PBS -M daniel.shaw@uga.edu
#PBS -m ae


cd /lustre1/des65576/workDir/RNAdata911/tophatbam/
module load HTSeq/0.9.1-foss-2016b-Python-2.7.14


htseq-count -f bam --order pos --mode intersection-strict --minaqual 1 -t exon -r name Liver-1_tophat.bam Glazer.gtf > Liver-1_gene.tsv
htseq-count -f bam --order pos --mode intersection-strict --minaqual 1 -t exon -r name Liver-2_tophat.bam Glazer.gtf > Liver-2_gene.tsv
htseq-count -f bam --order pos --mode intersection-strict --minaqual 1 -t exon -r name Liver-3_tophat.bam Glazer.gtf > Liver-3_gene.tsv
htseq-count -f bam --order pos --mode intersection-strict --minaqual 1 -t exon -r name Testis-1_tophat.bam Glazer.gtf > Testis-1_gene.tsv
htseq-count -f bam --order pos --mode intersection-strict --minaqual 1 -t exon -r name Testis-2_tophat.bam Glazer.gtf > Testis-2_gene.tsv
htseq-count -f bam --order pos --mode intersection-strict --minaqual 1 -t exon -r name Testis-3_tophat.bam Glazer.gtf > Testis-3_gene.tsv
