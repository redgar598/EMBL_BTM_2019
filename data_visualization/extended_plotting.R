
# Typically I source complex functions of plots that I will want to use for many different analyses
source("volcano.R")

        # this sourced code call for these libraries
        library(ggplot2)
        library(RColorBrewer)
        library(scales)
        library(gridExtra)


# Pull some data for a volcano plot
toptable<-read.csv("differential_expression.csv")


# make a volcano
# arguments are pvalue, deltabeta, dB_threshold, pval_threshold, legend_title, xlimit
makeVolcano(toptable$P.Value, toptable$logFC, 2, 0.005, "Wildtype vs Mutant", 6)



#So what were the steps?

#############
# 1 set a custom theme for both plots with larger text
#############
th <-   theme(axis.text=element_text(size=12),
              axis.title=element_text(size=14),
              strip.text.x = element_text(size = 12),
              legend.text=element_text(size=12),
              legend.title=element_text(size=14))

#############
# 2 shape the pvalue anf old change data for plotting
#############
    # anywhere is says delta beta it really means fold change

# these were set as arguments to a function in my code so they could be easily and quickly adjusted between analyses
volcano<-data.frame(Pvalue=toptable$P.Value, Delta_Beta=toptable$logFC)

dB<-2 #delta beta cutoff
Pv<-0.005 #Pvalue cutoff



# Pull the significant number of genes for a helpful output statement
sta_delbeta<-toptable$logFC[which(toptable$P.Value<=Pv)] 
sta_delbeta<-sta_delbeta[abs(sta_delbeta)>=dB]
print(paste("Increased Expression", length(sta_delbeta[which(sta_delbeta>=dB)]), sep=": "))
print(paste("Decreased Expression", length(sta_delbeta[which(sta_delbeta<=(-dB))]) , sep=": "))

# Final data shape for scatter and bar plot
volcano<-volcano[complete.cases(volcano),]


#############
# 3 Set the color labels based in the p value and delta bet thresholds
#############
# This makes life so much easier when adjusting colors or levels at which colors change
#set color thresholds
color3<-sapply(1:nrow(volcano), function(x) if(volcano$Pvalue[x]<=Pv){
  if(abs(volcano$Delta_Beta[x])>dB){
    if(volcano$Delta_Beta[x]>dB){"Increased Expression\n(with Potential Biological Impact)"}else{"Decreased Expression\n (with Potential Biological Impact)"}
  }else{if(volcano$Delta_Beta[x]>0){"Increased Expression"}else{"Decreased Expression"}}}else{"Not Significantly Different"})

volcano$color3<-color3

# COLORS! define here so they are consistent between plots
# so even if you don't have genes in a color catagory the pattern will be maintained
myColors <- c(muted("red", l=80, c=30),"red",muted("blue", l=70, c=40),"blue", "grey")

color_possibilities<-c("Decreased Expression",
                       "Decreased Expression\n (with Potential Biological Impact)",
                       "Increased Expression",
                       "Increased Expression\n(with Potential Biological Impact)",
                       "Not Significantly Different")

names(myColors) <- color_possibilities
colscale <- scale_color_manual(name = "Wildtype vs Mutant",
                               values = myColors, drop = FALSE)


############
# 4 make the volcano
############

volcano_plot<-ggplot(volcano, aes(Delta_Beta, -log10(Pvalue), color=color3))+
  geom_point(shape=19, size=1)+theme_bw()+
  colscale+
  geom_vline(xintercept=c(-dB,dB), color="grey60")+
  geom_hline(yintercept=-log10(Pv), color="grey60")+
  ylab("P Value (-log10)")+xlab("Fold Change")+xlim(-6, 6)+
  theme(plot.margin=unit(c(1,1,1,2),"cm"))+ th+
  guides(color = guide_legend(override.aes = list(size = 4)))

# the plot is assigned to and object so it can be combined with other plots in a grid, but to see it in R studio
volcano_plot

############
# 5 make the scree plot
############
pval_dis<-ggplot()+geom_histogram(aes(volcano$Pvalue),fill="grey90", color="black")+theme_bw()+xlab("Nominal P Value")+th+
  theme(plot.margin=unit(c(1,8.75,-0.6,1.5),"cm"))+ylab("CpG Count")

pval_dis


############
# 6 Combine with grid arrange
############
grid.arrange(pval_dis, volcano_plot, ncol=1,heights = c(2, 6))#
