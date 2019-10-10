# Example 2

In this example we will introduce may features of snakemake.

## all rule
Just to revisit this point. The first rule of a snakemake workflow
is often named `all`. It only has an input parameter and no output.

Whatever files are requested in the input of the first rule,
snakemake will try to create using the rules below. 

This could look like this:

```python3
rule all:
    input:
        bam  = "data/bams/alignment.bam",
        sorted = "data/bams/sorted.bam"
```

Now snakemake would try to create `alignment.bam` and `sorted.bam`.

Often you will see something like this:

```python3
rule all:
    input:
        bam = expand("{data}/bams/{sample}.bam",
                      data = config['data'],
                      sample = samples)
```
In this case snakemake would first execute the command `expand` to create a 
list of files, which are then requested.

If `samples` were to be a list `['sample1', 'sample2'] `, this could be the same as:

```python3
rule all:
    input:
        bam = ["data/bams/sample1.bam",
               "data/bams/sample2.bam"]
```


## Simple rule

A normal rule will always have an input, output and some action. Snakemake 
works mostly on files and thus input and output are usually paths to 
a file.

The promise of a rule is simple: If you give me this input file I will
create this output file.

```python3
rule align:
    input:
        genome = "genomes/hg38.fa",
        fastq = "{data}/fastq/{sample}.fq.gz"
    output:
        bam = "{data}/bam/{sample}.bam"
        te
    shell:
        """
        bwa mem {input.genome} {input.fastq} | \
              samtools view -bu  > {output.bam}
        """
```
In this rule we expect to find a genome and then we align a fastq file to create a bam file.
For this the shell command will be filled in with the variables
and then executed.

### Other eays to run code

Besides using the shell to run commands, we can also call scripts or run 
python code directly. See the [Snakefile](Snakefile) for examples.


## Task
- Look at the snakefile. What will be created?
- What files are required to be found?
- Execute it


If done, lets move to [example 3](../3_fixme/README.md)
