#conda create --name cytoscape_env
#conda activate cytoscape_env
#conda install -c bioconda cytoscape 

bsub -Is -XF -M 10000 -R 'rusage[mem=10000]' -n 4 /bin/bash

conda activate cytoscape_env
cd /nfs/research1/zerbino/redgar
cytoscape.sh