#!/usr/env python3
# -*- coding: utf-8 -*-
#coding=utf-8

import os, sys, time
import argparse

tm_str = time.strftime("%d%b_%H:%M:%S") 
DAT_PATH="."



def system_check(cmd):
    ret=os.system(cmd)
    if ret:
        print("[ERROR] cmd failed: "+cmd,file=sys.stderr)
    return ret


def main(args):
    out_file=tm_str+".jpg"
    cmd="ffmpeg -v {verbose} -f video4linux2 -s 1280x720 -i /dev/video0 -vf \"drawtext=fontfile=/usr/share/fonts/truetype/freefont/FreeMono.ttf: text='%{{localtime}}': x=(w-tw)/2: y=2*lh: fontcolor=black: box=1: boxcolor=white@0.65: fontsize=20\" -ss 0:0:2 -frames 1 -n \"{out}\""
    cmd=cmd.format(
        verbose="36" if args.verbose else "24",
        # text=tm_str,
        out=os.path.join(DAT_PATH,out_file)
    )
    ret=os.system(cmd)
    if ret:
        print("[ERROR] cmd failed: "+cmd,file=sys.stderr)
    return ret
    
def parse_args():
    parser = argparse.ArgumentParser(description='cam task')
    parser.add_argument('-v','--verbose',action='store_true', default=False,
        help='verbose')
    args = parser.parse_args()
    return args


if __name__ == "__main__":
    args=parse_args()
    r=main(args)
    exit(r)
