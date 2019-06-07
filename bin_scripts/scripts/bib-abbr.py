#!/usr/bin/python3
import os, sys

from Clerical.latex import abbrev_author_list, simple_process_bib
from functools import partial

simple_process_bib=partial(simple_process_bib,
    exclude=["abstract","file","keywords"],
    commentify=["booktitle","publisher","month","url","urldate","address","series"]
)

def usage():
    print("""Usage:
{self} /path/to/a_paper.bib > /path/to/processed.bib
{self} <author list>

E.g:

$ {self} Family Name, with Given-Names and Apple Juice, Bad and Orange Juice, Good and Lucas, Ahmad-Reza and My Corporation
>>> Family Name, W. G.-N. and Apple Juice, B. and Orange Juice, G. and Lucas, A.-R. and My Corporation
""".format(self=sys.argv[0]))

if __name__=="__main__":
    """
    """
    if len(sys.argv)==2 and sys.argv[1]=="-i":
        print("[NOTE] read input from stdin",file=sys.stderr)
        stream=sys.stdin
        for outline in simple_process_bib(stream):
            print(outline,end="")
    elif len(sys.argv)==2 and os.path.isfile(sys.argv[1]):
        with open(sys.argv[1],"r") as instream:
            for outline in simple_process_bib(instream):
                print(outline,end="")
    elif len(sys.argv)>=2:
        input_str=" ".join(sys.argv[1:])
        print(abbrev_author_list(input_str))
    else:
        usage()