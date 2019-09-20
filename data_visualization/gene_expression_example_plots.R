#########
## Required R Functions from ggplot and reshape
#########
library(reshape2)
library(ggplot2)


##########
## Read in Data
##########
geneExp <- read.table("data/GSE4051_data.tsv", stringsAsFactors = FALSE, sep = "\t", header=T)
head(geneExp[,1:5])

sampleInfo <- read.table("data/GSE4051_design.tsv", stringsAsFactors = FALSE, sep = "\t", header=T)
head(sampleInfo)


##########
## Melt then Merge 
##########
# Keeping it simple lets just look at the expression of two genes
geneExp_twoGene<-geneExp[c("1429028_at","1416119_at"),]
geneExp_twoGene$gene<-rownames(geneExp_twoGene)

# Melt it! Take wide format data and make it long format
geneExp_twoGene_longform<-melt(geneExp_twoGene)
colnames(geneExp_twoGene_longform)<-c("gene", "sidChar","expression")

# What did melt even do tho?
geneExp_twoGene
head(geneExp_twoGene_longform)
# Smushed it pretty much... this format is generally what ggplot prefers. 
# Factors (like gene) that you might like as catagories along the X or values along the y (expression) should be in columns not rows

# what about sample information, that is important for the plotting
head(sampleInfo)

# We want one big dataframe, whihc contains the sample information and the expression values
# Here were will merge the sample information and expression values (melted) into one data frame
# Melting then merging is a common steps for data managing into ggplot
data_for_plot<-merge(sampleInfo,geneExp_twoGene_longform, by="sidChar" )
head(geneExp_twoGene_longform)
head(data_for_plot)



### Scatter plot
# basic format: ggplot(data, aes(x_axis, y_axis))
ggplot(data_for_plot, aes(devStage, expression))+
  geom_point()# plot data as points

# what are those two obvious groups?
ggplot(data_for_plot, aes(devStage, expression, color=gene))+
  geom_point()

# but you can color by any column
ggplot(data_for_plot, aes(devStage, expression, color=devStage))+
  geom_point()

# Lets try different plot type
ggplot(data_for_plot, aes(devStage, expression, color=gene))+
  geom_boxplot()




# Nothing wrong with the boxplots, but lets go back to the points and try another way to split the data
# Instead of coloring by gene lets make a plot per gene
# This will focus the view on the changes over development and not the differences between genes. 
# so we can shift how we show the same data to emphasize those difference over development

ggplot(data_for_plot, aes(devStage, expression))+
  geom_point()

# facets splits the data into several of the same plot type
ggplot(data_for_plot, aes(devStage, expression))+
  geom_point()+
  facet_wrap(~gene)

# Now color has been freed up and can now be used for something else
# Remember we also have to genotpes of animals
ggplot(data_for_plot, aes(devStage, expression, color=gType))+
  geom_point()+
  facet_wrap(~gene)


# Pick better colors? 
# http://colorbrewer2.org
ggplot(data_for_plot, aes(devStage, expression, color=gType))+
  geom_point()+
  facet_wrap(~gene)+
  scale_color_manual(values=c("#41ab5d","#bdbdbd"))

# I love ggplot but I don't like the default grey background
# Probably cause I like to use grey for the WT or control in my plots to suggest it is the less interesting group
ggplot(data_for_plot, aes(devStage, expression, color=gType))+
  geom_point()+
  facet_wrap(~gene)+
  scale_color_manual(values=c("#41ab5d","#bdbdbd"))+
  theme_bw()

# bigger points please
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


# Nope that isn't right! - then you google image search for what you want 

#https://tinyurl.com/y244dd4t
#https://digibio.blogspot.com/2016/09/box-plots-and-connect-by-median.html

ggplot(data_for_plot, aes(devStage, expression, color=gType, group=gType))+
  geom_point(size=2)+
  facet_wrap(~gene)+
  scale_color_manual(values=c("#41ab5d","#bdbdbd"))+
  theme_bw()+
  stat_summary(fun.y=median, geom="smooth", aes(group=gType), lwd=1)

#geom_line tries to connect all the individual data points, where as stat summary, summarizes the groups to a value. Here we chose median



