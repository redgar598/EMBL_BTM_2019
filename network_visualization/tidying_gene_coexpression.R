

geneExp <- read.table("data_visualization/data/GSE4051_data.tsv", stringsAsFactors = FALSE, sep = "\t", header=T)
head(geneExp[,1:5])


#GS1= cor(geneExp[1:1000,], method="spearman")

Variation<-function(x) {quantile(x, c(0.9), na.rm=T)[[1]]-quantile(x, c(0.1), na.rm=T)[[1]]}

ref_range_exp<-sapply(1:nrow(geneExp), function(x) Variation(geneExp[x,]))
variable_gene_expression<-geneExp[which(ref_range_exp>=4),]



library("WGCNA")
net = blockwiseModules(t(variable_gene_expression), power = 6,
                       TOMType = "unsigned", minModuleSize = 30,
                       reassignThreshold = 0, mergeCutHeight = 0.25,
                       numericLabels = TRUE, pamRespectsDendro = FALSE,
                       saveTOMs = TRUE,
                       saveTOMFileBase = "MouseTOM", 
                       verbose = 3)


moduleColors = labels2colors(net$colors)
modules = net$colors


# Recalculate topological overlap if needed
TOM = TOMsimilarityFromExpr(t(variable_gene_expression), power = 6)

probes = rownames(variable_gene_expression)
modProbes = probes

cyt = exportNetworkToCytoscape(TOM,
                               edgeFile = "../network_visualization/data/gene_coexpression_edges.txt",
                               nodeFile = "../network_visualization/data/gene_coexpression_nodes.txt",
                               weighted = TRUE,
                               threshold = 0.02,
                               nodeNames = modProbes,
                               nodeAttr=moduleColors)




#### PCA for heat scree
geneExp <- read.table("data/GSE4051_data.tsv", stringsAsFactors = FALSE, sep = "\t", header=T)
head(geneExp[,1:5])

sampleInfo <- read.table("data/GSE4051_design.tsv", stringsAsFactors = FALSE, sep = "\t", header=T)
head(sampleInfo)

pca_res <- prcomp(t(geneExp))
Loadings<-as.data.frame(pca_res$x)
vars <- pca_res$sdev^2
Importance<-vars/sum(vars)

 

save(Loadings, Importance,sampleInfo, file="data/gene_expression_PCA_data.RData")


