# Workflow manager workshop

This repro is the bassis for the workshop. You should not need much more.


## Install and work along
To run the examples in this workshop please install Snakemake (>= 5) 
and also conda. If you created the BTM enviorement, please load it with

```
conda activate BTM
```
Then you can **skip** all installation steps. Juhee

### Install Conda
If you have not yet installed conda please install miniconda:
https://docs.conda.io/en/latest/miniconda.html

This should be self explanatory, but please ask your neighbors for help
or any of the volunteers.

### Install Snakemake
Once conda is installed you can install snakemake by running:

```
conda install -c bioconda -c conda-forge snakemake
```

### Install pandas
```
conda install -c anaconda pandas
```

### Install singularity (optional)
Either using conda:
```
conda install -c conda-forge singularity
```
Or using your package manager (e.g. on Ubuntu apt).


# Now lets get to the content
## How do we analyse data?

If we have a NGS file `experiment_1.fastq` we often need multiple steps 
to get a usable result. This will involve quality control
alignment to a reference, removing contamiantion, maybe peak or SNP calling. So this could look something like:

```
$ mkdir experiment1
$ cd experiment1
$ mkdir QC
$ mkdir fastq
$ cp ~/Downloads/experiment1.fastq fastq/raw.fastq
$ demultiplexIt -i fastq/raw.fastq -o demultiplexed/...
...
....
.....
......
# and finally:
$ Rscript makemyplot.R
```

Then often during a PhD or any long term project, another analysis will be
added or a step inbetween, because you forgot to add adapter trimming or 
something similar.

Often this can get busy and hard to manage. Thus Workflowmanager!


## What do workflow manager do?

Given you wrote a nice pipeline, they will figure out what step to 
run before which. If you insert a new step into the process or change
an input file, they will figure out what to rerun and what not.

### Cluster
They will also automatically be able to sent your jobs to a cluster once your
analysis is to large for your laptop.


# So how does it work?
Find out in [example1](1_basicExample/README.md)
