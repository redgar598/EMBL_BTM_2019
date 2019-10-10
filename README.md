# Welcome Basic Teaching Module 2019

In the BTM 2019 current predocs prepare modules and lectures to help the new predocs to get started with the predoc course and the rest of their PhD at EMBL.

## Recommended Software
### Anaconda
- Most software we will use can be easily installed together with [Anaconda](https://www.anaconda.com/distribution/)
- Once you have Anacaonda, then install [JupyterLab](https://jupyterlab.readthedocs.io/en/stable/getting_started/installation.html) using conda 
> conda install -c conda-forge jupyterlab
- And install git with 
> conda install -c anaconda git 

#### Options to use R Studio
1. With conda
> conda install -c r rstudio 
2. Download [R Studio](https://www.rstudio.com/products/rstudio/download/#download) to your local machine 
3. Alternatively you can run an Rstudio session in the [cloud](https://rstudio.cloud/) by signing up for an account

___


<br/><br/>
## Session Materials

### [Data Visualization](https://redgar598.github.io/EMBL_BTM_2019/data_visualization/)
Here we will run through some basic ggplot examples in R. Using gene expression data across development in WT and mutant lines, to understand the utility of the ggplot system and inform about resources to go to for help in future plotting endeavours. 

### [Network Visualization](https://redgar598.github.io/EMBL_BTM_2019/network_visualization/)
Here we look at how to visualize networks in Cytoscape. Will we work through the basic file format for cytoscape, how to import data and how to display data on both the nodes and edges of a built network. Will give workshop examples on gene expression, cell connectivity data and connection of authors on publications. Networks will be built elsewhere this will just be visualizing how networks are built is not covered.


### [Not So Scary Shell](https://redgar598.github.io/EMBL_BTM_2019/not_so_scary_shell/)
A session aimed at predocs unfamiliar with the UNIX shell. We will open the shell and learn how it is nothing but a portal into the inner workings of your laptop. You will learn how to make your life easier and that sometimes it can be a good idea to know how to use the shell.


### [UNIX oneliner](https://redgar598.github.io/EMBL_BTM_2019/unix_oneliner/)
In this session predocs will get familiar with UNIX one-liners. It is important for any bioinformatician to get the concept of these code snippets as you will stumble across them and might want to use them as well. So we will cover a short introduction into tools like awk, sort, grep and xargs. You can also come and chat about complex regex with other advanced computer scientists, if you feel like it.

### [Workflow manager workshop](https://redgar598.github.io/EMBL_BTM_2019/workflows/)
We will get familiar with the concept of workflow managers. Workflow managers have become popular in the bioinformatics community as they facilitate reproducible workflows. We will learn how to write small workflows using snakemake and make them reproducible and shareable using conda and singularity.

### [Advanced Python](https://github.com/redgar598/EMBL_BTM_2019/tree/master/python_datascience)
Everyone that used python before and will be using it again might be interested in: What else is there. We will look into best practice and advanced code structures such as classes and modules. We can also discuss useful packages for data scientists and how to manage different python environments (python 2 and 3)

### [Beginner Machine Learning](https://github.com/redgar598/EMBL_BTM_2019/tree/master/beginner_machine_learning)
This session will begin with an introduction to the concept of machine learning and how a basic machine learning pipeline looks like. In this practical, we will interactively solve a binary classification problem on 2D data. This will include loading the data in a jupyter notebook, visualizing the data in 2D space to identify outliers/missing values, if any, and getting an intuition of the decision boundary separating the two classes. Final step would be to train a classifier using cross-validation. Basic knowledge of Python or attending the Beginner Python course recommended.


