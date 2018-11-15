working_dir = directory = 'C:/Users/Daniel_2/Documents/Glazer/RNAseq/'
setwd(working_dir)

#Read in gene mapping
mapping=read.table("C:/Users/Daniel_2/Documents/Glazer/RNAseq/ENSG_ID2Name.txt", header=FALSE, stringsAsFactors=FALSE, row.names=1)

# Read in count matrix
rawdata=read.table("C:/Users/Daniel_2/Documents/Glazer/RNAseq/XIXJuvenilevsAdultONE_Testis_gene_read_counts_table_all_final.tsv", header=TRUE, stringsAsFactors=FALSE, row.names=1)

# Check dimensions
dim(rawdata)

# Require at least 25% of samples to have count > 25
quant <- apply(rawdata,1,quantile,0.75)
keep <- which((quant >= 25) == 1)
rawdata <- rawdata[keep,]
dim(rawdata)

#################
# Running edgeR #
#################

# load edgeR

library('edgeR')

# make class labels
class <- factor( c( rep("UHR",3), rep("HBR",1) ))

# Get common gene names
genes=rownames(rawdata)
gene_names=mapping[genes,1]


# Make DGEList object
y <- DGEList(counts=rawdata, genes=genes, group=class)
nrow(y)

# TMM Normalization
y <- calcNormFactors(y)

# Estimate dispersion
y <- estimateCommonDisp(y, verbose=TRUE)
y <- estimateTagwiseDisp(y)

# Differential expression test
et <- exactTest(y)

# Print top genes
topTags(et)

# Print number of up/down significant genes at FDR = 0.05  significance level
summary(de <- decideTestsDGE(et, p=0.5))
detags <- rownames(y)[as.logical(de)]




# Output DE genes
# Matrix of significantly DE genes
mat <- cbind(
  genes,
  sprintf('%0.5f',log10(et$table$PValue)),
  sprintf('%0.9f',(et$table$PValue)),
  sprintf('%0.5f',et$table$logFC)
)[as.logical(de),]
colnames(mat) <- c("Gene", "Log10_Pvalue", "Pvalue", "Log_fold_change")
# Order by log fold change
o <- order(et$table$logFC[as.logical(de)],decreasing=TRUE)
mat <- mat[o,]

# Save table
write.table(mat, file="XIXJvsAdult_DE_genessiggenes.txt", quote=FALSE, row.names=FALSE, sep="\t")
