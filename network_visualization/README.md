
# BTM Network Visualization
In order to follow along with this session you will need [Cytoscape](https://cytoscape.org/download.html), but you can also just watch the walkthrough if you can't to install something. 


<p align="left">
  <img src="figures/SocialNetworkAnalysis.png" alt="cookbook" width="400" height="300">
    <figcaption> <sup>Martin Grandjean [<a href="https://creativecommons.org/licenses/by-sa/4.0">CC BY-SA 4.0</a>], <a href="https://commons.wikimedia.org/wiki/File:SocialNetworkAnalysis.png">via Wikimedia Commons</a></sup></figcaption>
</p>



#### Networks you can try out
We will walk through an example together then you are free to work through one example network visulization on either:
- Gene co-expression 
- Cell-cell connectivity
- Authorship network
- Affinity purification-mass spectrometry 

### Data for Building Networks
- Set up with git up? clone the BTM repo
```
git clone https://github.com/redgar598/EMBL_BTM_2019.git
```
- Want everything but don't have git? Download [this](https://github.com/redgar598/EMBL_BTM_2019/archive/master.zip)
- Collect the data files individually [here](https://github.com/redgar598/EMBL_BTM_2019/tree/master/network_visualization/data) individually

___


<br/><br/>

## Gene Coexpression Data 
The gene expression and sample information data were collected from the Gene Expression Omnibus (GEO), under study ID [GSE4051](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE4051). The coexpression weights are from a Weighted Gene Coexpression Netwrok Analysis ( [WGCNA](https://horvath.genetics.ucla.edu/html/CoexpressionNetwork/Rpackages/WGCNA/) ). Only the 95 most variable genes were used for calculating coexpression. Genes were sorted into two coexpression clusters (turquoise and grey), which represent genes expressed with a similar pattern as cross samples. 

Suggested network building:
> - File -> Import -> Network from File -> gene_coexpression_edges.txt 
> - Label "fromNode" as the source for node connections and "toNode" as the target.
> - File -> Import -> Table from File -> gene_coexpression_nodes.txt 
> - "nodeName" should automatically be the key to merge the edge and node tables. 
> - Under the Style tab and Node settings try Fill Color as "nodeAttr". Try and match cluster name to actual color.
> - Then layout so the grey and turquiose modules are seperate
> - Find the clearest way to weight the edges by the coexpression weight (i.e transparency, color, width)


<p align="left">
  <img src="figures/bbw139f1p.jpg" width="400" height="200">
  <figcaption> <sup>van Dam S, Võsa U, van der Graaf A, Franke L, de Magalhães JP. (2017) Gene co-expression analysis for functional classification and gene-disease predictions. Brief Bioinform</sup></figcaption>
  
</p>



## Brain Cell Connectivity
Complete information on the data set is available on the [Allen Institute Site](http://alleninstitute.github.io/AllenSDK/connectivity.html). In short, the data collected consists of axonal projections targeting adult mouse brain structures. Selected experiments are from wild-type injections into the hypothalamus (HY) and into primary visual area (VISp).

[Information on the fields available in the network](http://alleninstitute.github.io/AllenSDK/unionizes.html)

If you would like to explore the connections of projections in mouse brain structures download both csv files [here](https://github.com/redgar598/EMBL_BTM_2019/tree/master/network_visualization/data)

Suggested network building:
> - File -> Import -> Network from File -> edges_allen.csv 
> - File -> Import -> Table from File -> nodes_allen.csv 
> - "id" should automatically be the key to merge the edge and node tables. 
> - Under the Style tab and Node settings try Label as "acronym" since these are a bit more meaningful. 

According to the Allen Institute page "<em>Most commonly used for analysis are measures of the <strong>density of projection signal</strong> </em>"


<p align="left">
  <img src="figures/brain-2022398_960_720.png" width="250" height="200">
</p>


## Co-authorship Network
This network is less biologically relevant and more of a social analysis. It generates a networks based on one author (indexed in pubmed) and connects them to their co-authors. 

This will be a bit more advanced because it requires the install of an app within Cytoscape. Detailed instructions are available [here](http://baderlab.org/Software/SocialNetworkApp#Installation).



<p align="left">
  <img src="figures/redgar_network.png" width="400" height="400">
</p>


<br/><br/>


## Affinity purification-mass spectrometry 
This is an example from the cytoscape website. I am not familiar with this [tutorial](https://cytoscape.org/cytoscape-tutorials/protocols/AP-MS-network-analysis/#/) but wanted to include it in case there is interest in this type of network. Happy to help with any issues with the tutorial. From the website:

>This protocol describes how to use data from an affinity purification-mass spectrometry experiment to to generate relevant interaction networks, enriching the networks with information from public resources, analyzing the networks and creating effective visualizations.
