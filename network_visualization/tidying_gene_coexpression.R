

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


library(gridExtra)
library(reshape2)
library(ggplot2)

PCs_to_view<-10

pca_df<-data.frame(variance=Importance, PC=seq(1:length(Importance)))

scree<-ggplot(pca_df[which(pca_df$PC<=(PCs_to_view)),],aes(PC,variance))+
  geom_bar(stat = "identity",color="black",fill="grey")+theme_bw()+
  theme(axis.text.y = element_text(size =15, color="black"),
        axis.text.x = element_blank(),
        axis.ticks.x = element_blank(),
        axis.title = element_text(size =18),
        plot.margin=unit(c(1.25,2.8,-0.2,2.8),"cm"))+ylab("Variance")+
  scale_x_continuous(breaks = seq(1,PCs_to_view,1))+xlab("")


#### Heat
## correlate meta with PCS
## Run anova of each PC on each meta data variable
aov_PC_meta <- lapply(2:ncol(sampleInfo), function(covar) {
  sapply(1:ncol(Loadings),function(PC) summary(aov(Loadings[, PC] ~ sampleInfo[, covar]))[[1]]$"Pr(>F)"[1])
  })

names(aov_PC_meta) <- colnames(sampleInfo)[2:ncol(sampleInfo)]
aov_PC_meta <- do.call(rbind, aov_PC_meta)
aov_PC_meta <- as.data.frame(aov_PC_meta)

#reshape
avo<-aov_PC_meta[,1:PCs_to_view]
avo_heat_num<-apply(avo,2, as.numeric)
avo_heat<-as.data.frame(avo_heat_num)
avo_heat$meta<-rownames(avo)
avo_heat_melt<-melt(avo_heat, id=c("meta"))


# color if sig
avo_heat_melt$Pvalue<-sapply(1:nrow(avo_heat_melt), function(x) if(avo_heat_melt$value[x]<=0.001){"<=0.001"}else{
  if(avo_heat_melt$value[x]<=0.01){"<=0.01"}else{
    if(avo_heat_melt$value[x]<=0.05){"<=0.05"}else{">0.05"}}})

levels(avo_heat_melt$variable)<-sapply(1:PCs_to_view, function(x) paste("PC",x, sep="" ))

heat<-ggplot(avo_heat_melt, aes(variable,meta, fill = Pvalue)) +
  geom_tile(color = "black",size=0.5) +
  theme_gray(8)+scale_fill_manual(values=c("#084594","#4292c6","#9ecae1","#deebf7"), name="P Value")+
  theme(axis.text = element_text(size =16, color="black"),
        axis.title = element_text(size =18),
        legend.text = element_text(size =16),
        legend.title = element_text(size =16),
        legend.position = c(1.23, 0.75), legend.justification = c(1,1),
        plot.margin=unit(c(-0.3,3.2,1,2.5),"cm"),
        panel.background = element_blank(),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank())+
  xlab("Principal Component")+ylab(NULL)

grid.arrange(scree, heat, ncol=1,heights = c(3, 4))#

