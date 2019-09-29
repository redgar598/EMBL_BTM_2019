# UNIX oneliner

Oneliner are cool. As a datascientist you will find them a lot.

In this session you will only need a terminal and together we will 
look at a few complex one line commands and understand what they do.


# Intro to UNIX tools
let me introduce you to yor friends

```
man cat
man cut 
man sed
man awk
man uniq
man sort
man find
man xargs
```

Go here for basic introduction: https://github.com/stephenturner/oneliners


## Simple example 1
Lets quickly introduce pipes and such.

Lets switch to a playground folder, so we don't break anything.
```
mkdir playground
cd playground
```

Lets fetch a small table:
```
wget -O toydata.csv TODO[INSERT url to git dataset]
```
And now we want to fetch all the entries of the session BTM, where people were present.
Then sort it alphabetically using the names and print out the 4th column.

```
cat toydata.csv | awk '{if($1 == "BTM" && $3){print $0}}'  | sort -k 2 | cut -f 4
```
What just happened?

## Simple example 2

Lets get all transcription start sites in the human genome:

```
wget -O gencode.gtf.gz ftp://ftp.ebi.ac.uk/pub/databases/gencode/Gencode_human/release_32/gencode.v32.annotation.gtf.gz 
```
Now that we downloaded the gtf annotation, lets get started
```
cat gencode.gtf.gz| gunzip | awk '$3=="gene" {print $0}' | grep protein_coding | awk -v OFS="\t" '{if ($7=="+") {print $1, $4, $4+1} else {print $1, $5-1, $5}}' > tss.bed

```

Who can explain what happened?


### Tasks

- Output 5kb flanking tss
- 
