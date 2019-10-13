# Example 1

Of course there are many workflow manager out there. There are for example

- Snakemake
- Nextflow
- CWL
- Galaxy (Web GUI and limited)


But as this is an introduction we focus on Snakemake

## Running workflows
Running a workflow is simple. If you cloned this repro just go into this folder and
run

```
snakemake -n
```

### Question: what does flag **-n** do?

### Question: What did the pipeline do?
Look at the output and look at the pipeline. Can you understand whats happening?

**We will go trough the example together**

<object data="https://raw.githubusercontent.com/redgar598/EMBL_BTM_2019/paul/workflows/1_basicExample/rulegraph.pdf" type="application/pdf" width="700px" height="700px">
   <embed src="https://raw.githubusercontent.com/redgar598/EMBL_BTM_2019/paul/workflows/1_basicExample/rulegraph.pdf">
        <p>This browser does not support PDFs. Please download the PDF to view it: <a href="https://raw.githubusercontent.com/redgar598/EMBL_BTM_2019/paul/workflows/1_basicExample/rulegraph.pdf">Download PDF</a>.</p>
    </embed>
</object>

## Snakemake basics

Snakemake will always look for a file `Snakefile` to find a workflow. You can
also use the `-s` parameter to pass a different filename to it.

### Usefull flags

- `-j [int]`: Paralize to n threads
- `-k`: Continue with independent rules eventhough some might have failed
- `-p`: print the executed shell statements
- `-n`: Dont run just calculate what we would run


Lets move on to [example 2](../2_example/)
