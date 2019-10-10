# Small task

## Merging many files

Imagine you measured the OD for a bunch of samples. That took ages and the
machine created a single `.csv` file for each measurement.

How can you copy paste all the files into one large table?

Go into the folder task_1 and merge all files ending with `.csv` into one table.

<details>
  <summary>Solution (spoiler)</summary>
  Simple solution:

  ```
  # we just open all files and write to a new one
  cat *.csv > all.csv
  ```
  
  But this way we get all the header lines inbetween.

  Using a small awk script we can
  merge the files, retaining only the header from the first one:
  ```
  awk '(NR == 1) || (FNR > 1)' OD_*.csv > all.csv
  ```
  This way bash will expand the expression `OD_*.csv` to be a list of many files.
  awk will then open each file and only print the first line of the first file 
  but not the rest. Soltuions like this you can google, no need to know this
  if you don't use it everyday.
  
</details>


## Use google to fix a problem
Say you got an email from the cluster team and they told you:

```
You have used 81.24% (12.19 GB of 15.00 GB) on /vol/vol_homes/homes as user [NAME]
```

This usually hapens to me once every while, as I download something and forgot
about it and now I need to figure out where to go to remove the large
file that I probably don't need anymore.

How do you figure out which folders take up most space and what to delete? 

**Task:** Go to the folder task2 and find the largest folder.

Use google to help you (unix find folder size)

<details>
  <summary>Solution (spoiler)</summary>
  We can let the shell count the files and the size of them in byte by using the command
  `du`

  ```
  du -d 2 | sort -n
  ```
  By using the `-d` flag, we tell how many different leves we care for.
  By piping the output into the sort command we can sort it so the largest number 
  is the lowest line.

  If you ran this in the folder you would get something like this:

  ```
  44	./S/M
  48	./S
  42120	./L/A
  42124	./L
  42176	.
  ```
  Indicating that the large file must be somewhere in folder `L/A`
  So now we can just look there:
  ```
  du -d 3 L/A | sort -n
  ```
  And we see the largest folder is in the directory `L/A/R/G/E` and now we can go there
  and delete it and use the cluster again. Jay


  


