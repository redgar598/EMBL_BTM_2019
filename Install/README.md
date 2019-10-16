# Install software for the BTM

## Conda or mini-conda
You will need conda for most sessions, if you do not have it installed yet you
cat download it from here:

[https://docs.conda.io/en/latest/miniconda.html](https://docs.conda.io/en/latest/miniconda.html)

Miniconda is a small version, which has no nice user interface, but is what most
people use. But you can also use Anaconda but we can give less ehlp there:

[https://www.anaconda.com/distribution/#download-section](https://www.anaconda.com/distribution/#download-section)

## Install the enviorements:

In this folder you see two files: BTM.yaml and BTM-R.yaml

You can install them like this:

1. Open any shell with the conda (Mac and Linux: terminal, Windows: open conda)

2. To install the python environment:

```
conda env create -f BTM.yml
```

3. Install the R environment:

```
conda env create -f BTM-R.yml
```
