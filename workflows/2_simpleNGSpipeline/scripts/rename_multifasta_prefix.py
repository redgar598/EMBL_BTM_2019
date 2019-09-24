#!/usr/bin/env python2

import argparse
import sys
import random
import re
bases = {"R": ["A", "G"],
         "Y": ["C", "T"],
         "K": ["G", "T"],
         "M": ["A", "C"],
         "S": ["C", "G"],
         "W": ["A", "T"],
         "B": ["C", "G", "T"],
         "D": ["A", "G", "T"],
         "H": ["A", "C", "T"],
         "V": ["A", "C", "G"],
         "N": ["A", "G", "C", "T"]
         }

dna = re.compile("[^AGCT]{1}")

vbases = ["A","C","G","T"]

def randomBASE(l):
    return(random.choice(bases[l]))


def substituteDNA(s):
    s = s.strip("\n")
    s = s.upper()
    it = dna.finditer(s)
    for m in it:
        b = m.group()
        s = "{}{}{}".format(s[:m.start()],
                            randomBASE(b),
                            s[m.end():])
    return(s)

def removeN(s):
    return("".join([i for i in list(s) if i in vbases]))


def ren_fasta(args):
    n = 0
    for line in open(args.fasta_file, "r"):
        if line[0] == ">":
            name = line.strip("\n").replace(">","")
            n += 1
            print(">%s_%i\t%s" % (args.prefix, n, name))
        elif args.substitute:
            print(substituteDNA(line))
        elif args.remove:
            print(removeN(line))
        else:
            print(line.strip("\n"))


if __name__ == '__main__':
        parser = argparse.ArgumentParser(description='Rename multifasta file')
        parser.add_argument('-f', dest='fasta_file', help='Input FASTA file')
        parser.add_argument('-p', dest='prefix', help='Header prefix')
        parser.add_argument('-s', dest='substitute', 
                            help='Substitute ambiguois bases',
                            action='store_true')
        parser.add_argument('-r', dest='remove', 
                            help='remove ambigious bases',
                            action='store_true')
        if len(sys.argv) == 1:
                parser.print_help()
                sys.exit()
        else:
                args = parser.parse_args()
                ren_fasta(args)    

