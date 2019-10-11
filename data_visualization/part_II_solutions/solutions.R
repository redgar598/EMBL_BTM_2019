###########################
## EXAMPLE 1
###########################
library(dslabs)
library(dplyr)
library(ggplot2)
data(us_contagious_diseases)
head(us_contagious_diseases)

the_disease <- "Measles"
dat <- us_contagious_diseases %>%
  filter(!state%in%c("Hawaii","Alaska") & disease == the_disease) %>%
  mutate(rate = count / population * 10000 * 52 / weeks_reporting) 

jet.colors <- colorRampPalette(c("#F0FFFF", "cyan", "#007FFF", "yellow", "#FFBF00", "orange", "red", "#7F0000"), bias = 2.25)

dat %>% mutate(state = reorder(state, desc(state))) %>%
  ggplot(aes(year, state, fill = rate)) +
  geom_tile(color = "white", size = 0.35) +
  scale_x_continuous(expand = c(0,0)) +
  scale_fill_gradientn(colors = jet.colors(16), na.value = 'white') +
  geom_vline(xintercept = 1963, col = "black") +
  theme_minimal() + 
  theme(panel.grid = element_blank()) +
  coord_cartesian(clip = 'off') +
  ggtitle(the_disease) +
  ylab("") +
  xlab("") +  
  theme(legend.position = "bottom", text = element_text(size = 8)) + 
  annotate(geom = "text", x = 1963, y = 50.5, label = "Vaccine introduced", size = 3, hjust = 0)


###########################
## EXAMPLE 2
###########################


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




###########################
## EXAMPLE 3
###########################
bar <- ggplot(data, aes(x = pt_id, y = freq)) + geom_bar(stat = "identity", color="#293c59", fill="#293c59") +theme_classic()+     
  theme(axis.title.x = element_blank(), axis.ticks.x = element_blank(), axis.text.x = element_blank()) + 
  ylab("Number of Mutations")
# DEFINE BINARY PLOTS

smoke_status <- ggplot(data, aes(x=pt_id, y=smoke)) + geom_bar(fill="#bf1e15",stat="identity") + 
  theme(legend.position = "none", axis.title.x = element_blank(), axis.ticks.x = element_blank(), axis.text.x = element_blank(),
        panel.grid.major = element_blank(), panel.grid.minor = element_blank()) + ylab("Smoking\nStatus")

hpv_status <- ggplot(data, aes(x=pt_id, y = hpv)) + geom_bar(fill="#bf1e15",stat="identity") + 
  theme(legend.position = "none", axis.title.x = element_blank(), axis.ticks.x = element_blank(), axis.text.x = element_blank(),
        panel.grid.major = element_blank(), panel.grid.minor = element_blank()) + ylab("HPV\nStatus")

site_status <- ggplot(data, aes(x=pt_id, y=site_known, fill = site)) +     geom_bar(stat="identity")+
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank())+ 
  scale_fill_brewer(palette = "Spectral", name="Sample Site")+
  xlab("Patient ID")+ylab("Sample\nSite")


# move legend to the side
get_leg = function(a.gplot){
  tmp <- ggplot_gtable(ggplot_build(a.gplot))
  leg <- which(sapply(tmp$grobs, function(x) x$name) == "guide-box")
  legend <- tmp$grobs[[leg]]
  legend
}

# Get legend as a separate grob
leg = get_leg(site_status)

# Add a theme element to change the plot margins to remove white space between the plots
thm = theme(plot.margin=unit(c(0,0,0,0),"lines"))

# Left-align the four plots 
# Adapted from: https://stackoverflow.com/a/13295880/496488
gA <- ggplotGrob(bar + thm)
gB <- ggplotGrob(smoke_status + thm)
gC <- ggplotGrob(hpv_status + thm)
gD <- ggplotGrob(site_status + theme(plot.margin=unit(c(0,0,0,0), "lines")) + 
                   guides(fill=FALSE))

maxWidth = grid::unit.pmax(gA$widths[2:5], gB$widths[2:5], gC$widths[2:5], gD$widths[2:5])
gA$widths[2:5] <- as.list(maxWidth)
gB$widths[2:5] <- as.list(maxWidth)
gC$widths[2:5] <- as.list(maxWidth)
gD$widths[2:5] <- as.list(maxWidth)

# Lay out plots and legend
p = grid.arrange(arrangeGrob(gA,gB,gC,gD, heights=c(0.5,0.1,0.1,0.2)),
                 leg, ncol=2, widths=c(0.8,0.2))



###########################
## EXAMPLE 3
###########################
## define colors for clustering labels
sampleInfo$col_devstage<-as.factor(sampleInfo$devStage)
colors<-c("#440154FF", "#31688EFF", "#21908CFF", "#35B779FF","#B8DE29FF")

levels(sampleInfo$col_devstage)<-colors
sampleInfo$col_devstage<-as.character(sampleInfo$col_devstage)

# make the color bar at the bottom
dend <- as.dendrogram(hc)
rectanle<-ggplot()+geom_rect(aes(xmin=1:nrow(sampleInfo), xmax=1:nrow(sampleInfo)+1, ymin=0, ymax=1, 
                                 fill=sampleInfo$devStage[match(labels(dend),sampleInfo$sidChar)]), color="black", alpha=0.5) +
  theme_bw()+scale_fill_manual(values=colors, name="Developmental\nStage")+theme(legend.position = c(1.07, 6),
                                       axis.title=element_blank(),
                                       axis.text=element_blank(),
                                       axis.ticks=element_blank(),
                                       panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
                                       panel.background = element_blank(), axis.line = element_blank(),
                                       panel.border = element_blank())+
  geom_vline(xintercept=17, size=1)+geom_vline(xintercept=24, size=1)+
  geom_vline(xintercept=34, size=1)+ylim(-0.5,1.5)



par(mfcol = c(1,1), mar=c(5,6,3,6), oma=c(0,0,0,0))
plot.new()

# plot dendogram
myplclust(hc, labels=sampleInfo$sidNum, lab.col=sampleInfo$col_devstage, cex=1.2, main="")

# combine all elements
vp <- viewport(height = unit(0.1,"npc"), width=unit(0.77, "npc"), 
               just = c("center","top"), y = 0.14, x = 0.5)
print(rectanle, vp = vp)

