import requests

def get_genomic_content(chrom, start, end, species = 'human'):
    server = "https://rest.ensembl.org"
    ext = f"/sequence/region/{species}/{chrom}:{start}..{end}:1?"

    r = requests.get(server+ext, headers={ "Content-Type" : "text/plain"})

    if not r.ok:
      r.raise_for_status()

    return r.text

def calculateGC(seq):
    '''
    takes a genomic sequence and only counts AGCT items and returns simple GC content
    Ambigious bases are ignored
    '''
    seq = seq.lower()
    d = {}
    for c in "agct":
        d[c] = seq.count(c)
    gc = (d['g'] + d['c'])/(d['a'] + d['g'] + d['c'] + d['t'])
    return gc
