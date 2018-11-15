res <- read.table("XIXJvsAdult_DE_genessiggenes.txt", header=TRUE)
head(res)

# Make a basic volcano plot
with(res, plot(Log_fold_change, -log(Pvalue), pch=20, main="X gene expression in juvenile fish", xlim=c(-6.5,6)))

# Add colored points: red if padj<0.05, orange of log2FC>1, green if both)
with(subset(res, Pvalue >0.05 ), points(Log_fold_change, -log(Pvalue), pch=20, col="red"))
with(subset(res, abs(Log_fold_change)>1), points(Log_fold_change, -log(Pvalue), pch=20, col="orange"))
with(subset(res, Pvalue <0.05 & abs(Log_fold_change)>1), points(Log_fold_change, -log(Pvalue), pch=20, col="green"))

# Label points with the textxy function from the calibrate plot
library(calibrate)
with(subset(res, Pvalue <0.05 & abs(Log_fold_change)>1), textxy(Log_fold_change, -(Log10_Pvalue), labs=Gene, cex=.8))
