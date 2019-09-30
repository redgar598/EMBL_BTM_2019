library(limma)

geneExp <- read.table("data/GSE4051_data.tsv", stringsAsFactors = FALSE, sep = "\t", header=T)
head(geneExp[,1:5])

sampleInfo <- read.table("data/GSE4051_design.tsv", stringsAsFactors = FALSE, sep = "\t", header=T)
head(sampleInfo)

designMatrix <- model.matrix(~gType, sampleInfo)
genotypeFit <- lmFit(geneExp, designMatrix)
ebfit <- eBayes(genotypeFit)

tab <- topTable(ebfit, n=Inf)

write.csv(tab, file="differential_expression.csv" )
