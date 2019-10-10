
def countNucs(p):
    # result saving
    freq = {}
    with open(p) as f:
        for line in f:
            # skip names
            if line.startswith(">"):
                continue
            # Upper case all the things
            s = line.strip().upper()
            for c in s:
                if c in freq.keys():
                    freq[c] += 1
                else:
                    freq[c] = 1
    return(freq)

raw = countNucs(snakemake.input['genome'])
cleaned = countNucs(snakemake.input['cleaned'])
with open(snakemake.output[0], "w") as f:
    # all possible keys
    keys = list(set(raw.keys()) | set(cleaned.keys()))
    keys.sort()

    for k in keys:
        # add missing keys
        if k not in cleaned.keys():
            cleaned[k] = 0
        s = f"{k}\t{raw[k]}\t{cleaned[k]}\t{snakemake.wildcards['genome']}\n"
        f.write(s)
    # write sum as well
    raw_sum = sum([v for k,v in raw.items()])
    cleaned_sum = sum([v for k,v in cleaned.items()])
    s = f"sum\t{raw_sum}\t{cleaned_sum}\t{snakemake.wildcards['genome']}\n"
    f.write(s)
