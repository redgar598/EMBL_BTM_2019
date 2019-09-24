
# BTM Network Visualization
In order to follow along with this session you will need Cytoscape, but you can also just watch the walkthrough if you can't be bothered to install something. 


<p align="left">
  <img src="figures/SocialNetworkAnalysis.png" alt="cookbook" width="400" height="300">
    <figcaption> <sup>Martin Grandjean [<a href="https://creativecommons.org/licenses/by-sa/4.0">CC BY-SA 4.0</a>], <a href="https://commons.wikimedia.org/wiki/File:SocialNetworkAnalysis.png">via Wikimedia Commons</a></sup></figcaption>
</p>



#### Networks We Will Be Using
We will walk through an example together then you are free to work through one example network visulization on either:
- Cell-cell connectivity
- Gene co-expression
- Authorship network


#### How do I get this data?

# Brain Cell Connectivity
Complete information on the data set is available on the [Allen Institute Site](http://alleninstitute.github.io/AllenSDK/connectivity.html). In short, the data collected consists of axonal projections targeting adult mouse brain structures. Selected experiments are from wild-type injections into the hypothalamus (HY) and into primary visual area (VISp).

[Information on the fields available in the network](http://alleninstitute.github.io/AllenSDK/unionizes.html)

If you would like to explore the connections of projections in mouse brain structures download both csv files [here](https://github.com/redgar598/EMBL_BTM_2019/tree/master/network_visualization/data)

Suggested network building:
- File -> Import -> Network from File -> edges_allen.csv 
- Label "injection" as the source for node connections and "structure_id" as the target. For values in injection column 385=VISp_edges and 1097=HY
- File -> Import -> Table from File -> nodes_allen.csv 
- "id" should automatically be the key to merge the edge and node tables. 
- Under the Style tab and Node settings try Label as "acronym" since these are a bit more meaningful. 

According to the Allen Institute page "<em>Most commonly used for analysis are measures of the <strong>density of projection signal</strong> </em>"

