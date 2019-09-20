#########
## Required R Functions from ggplot and reshape
#########
library(reshape2)
library(ggplot2)


##########
## Read in Data
##########
geneExp <- read.table("GSE4051_data.tsv", stringsAsFactors = FALSE, sep = "\t", header=T)
head(geneExp[,1:5])

sampleInfo <- read.table("GSE4051_design.tsv", stringsAsFactors = FALSE, sep = "\t", header=T)
head(sampleInfo)


##########
## Melt then Merge 
##########
# Keeping it simple and just getting expression of two genes
geneExp_twoGene<-geneExp[c("1429028_at","1416119_at"),]
geneExp_twoGene$gene<-rownames(geneExp_twoGene)

# Melt it!
geneExp_twoGene_longform<-melt(geneExp_twoGene)
colnames(geneExp_twoGene_longform)<-c("gene", "sidChar","expression")

# What did melt even do tho?
geneExp_twoGene
head(geneExp_twoGene_longform)

# what about sample information, that is important for the plotting
head(sampleInfo)

# Now we want one big dataframe
data_for_plot<-merge(sampleInfo,geneExp_twoGene_longform, by="sidChar" )
head(geneExp_twoGene_longform)
head(data_for_plot)



### Scatter plot
ggplot(data_for_plot, aes(devStage, expression))+
  geom_point()

#what are the two obvious groups?
ggplot(data_for_plot, aes(devStage, expression, color=gene))+
  geom_point()

#different plot type maybe?
ggplot(data_for_plot, aes(devStage, expression, color=gene))+
  geom_boxplot()


#reorganize, nothing wrong with the boxplots 
#but maybe we want to focus on the changes over development and not the differences between genes. 
# so we can shift how we show the same data to emphasize those difference over development

ggplot(data_for_plot, aes(devStage, expression))+
  geom_point()

# facets splits the data 
ggplot(data_for_plot, aes(devStage, expression))+
  geom_point()+
  facet_wrap(~gene)

# color can now be something else
ggplot(data_for_plot, aes(devStage, expression, color=gType))+
  geom_point()+
  facet_wrap(~gene)

#pick better colors? 
#http://colorbrewer2.org
ggplot(data_for_plot, aes(devStage, expression, color=gType))+
  geom_point()+
  facet_wrap(~gene)+
  scale_color_manual(values=c("#41ab5d","#bdbdbd"))

# I love ggplot but I don't like the default grey background
ggplot(data_for_plot, aes(devStage, expression, color=gType))+
  geom_point()+
  facet_wrap(~gene)+
  scale_color_manual(values=c("#41ab5d","#bdbdbd"))+
  theme_bw()

# bigger points
ggplot(data_for_plot, aes(devStage, expression, color=gType))+
  geom_point(size=2)+
  facet_wrap(~gene)+
  scale_color_manual(values=c("#41ab5d","#bdbdbd"))+
  theme_bw()

# since we have longtidunal data a trend line makes sense
ggplot(data_for_plot, aes(devStage, expression, color=gType))+
  geom_point(size=2)+
  facet_wrap(~gene)+
  scale_color_manual(values=c("#41ab5d","#bdbdbd"))+
  theme_bw()+
  geom_line()

# Nope that isn't right - then you google image search for what you want 

#https://www.google.com/search?q=ggplot+mean+trend+line&sxsrf=ACYBGNT6yeAGJDpZJqYUVZ01edmJDhBuEg:1568731452990&source=lnms&tbm=isch&sa=X&ved=0ahUKEwjEjoOIjNjkAhXKTcAKHfL5B_QQ_AUIEigB&biw=1853&bih=976#imgrc=iATwiRkb9oyWGM:
#https://digibio.blogspot.com/2016/09/box-plots-and-connect-by-median.html

ggplot(data_for_plot, aes(devStage, expression, color=gType, group=gType))+
  geom_point(size=2)+
  facet_wrap(~gene)+
  scale_color_manual(values=c("#41ab5d","#bdbdbd"))+
  theme_bw()+
  stat_summary(fun.y=median, geom="smooth", aes(group=gType), lwd=1)

#geom_line tries to connect all the individual data points, where stat summary, summarizes the groups to a value here we said median


