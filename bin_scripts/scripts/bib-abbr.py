#!/usr/bin/python3
import os, sys

from Clerical.latex import abbrev_author_list, simple_process_bib
from functools import partial

process_bib=partial(simple_process_bib,
    exclude=["abstract","file","keywords"],
    commentify=["booktitle","publisher","month","url","urldate","address","series"]
)

def parse_args():
    import argparse
    parser = argparse.ArgumentParser(description='Bibtxt Helper')
    parser.add_argument('f', metavar='...', type=str, nargs='*',
                    help='<File> or <Author list ...>')
    parser.add_argument("-a","--keep-author", action='store_true',
                    default=False,
                    help='Set to not to shorten author list.')
    parser.add_argument("-i","--stdin", action='store_true',
                    default=False,
                    help='Set to read from Stdin.')
        
    args = parser.parse_args()
    if not args.stdin and not args.f:
        parser.print_usage()
    return args

if __name__=="__main__":
    """
    """
    args=parse_args()

    if args.stdin:
        print("[NOTE] read input from stdin",file=sys.stderr)
        instream=sys.stdin
    elif len(args.f)==1 and os.path.isfile(args.f[0]):
        instream=open(args.f[0],"r")
    else:
        input_str=" ".join(args.f)
        print(abbrev_author_list(input_str))
        exit(0)

    for outline in process_bib(instream,perserve_author=args.keep_author):
        print(outline,end="")
    instream.close()