#!/usr/bin/env python3
import csv
from glob import glob
import os
import sys
import subprocess
from collections import defaultdict
import re

import yaml


def find_commented_files(base_path, comment_extension=".comment.yml"):
    """Return list of tuple with base and comment file pairs."""
    commented_files = []
    comment_files = glob(os.path.join(base_path, '**/*'+comment_extension), recursive=True)
    for cf in comment_files:
        # Ignoring all files starting with _
        if cf[len(base_path):].startswith('_'): continue
        base_file = cf[:-len(comment_extension)]
        if os.path.isfile(base_file):
            commented_files.append((
                base_file, cf))
    return commented_files


def load_comment(comment_file):
    """Return data from comment_file."""
    with open(comment_file) as f:
        return yaml.load(f)


def get_latest_commit_hash(base_file):
    """Return base_file's latest commit hash."""
    return subprocess.check_output('git log -n 1 --pretty=format:%H'.split(' ') + [base_file],
                                   universal_newlines=True)


def main():
    # If an argument was passed, use that as base_path:
    if len(sys.argv) >= 2:
        base_path = os.path.join(os.chdir(sys.argv[1]), '')
    else:
        base_path = './'

    data = {}
    # 1. find all comment files
    for base_file, comment_file in find_commented_files(base_path):
        comment = load_comment(comment_file)
        # 2. check up-to-dateness of commit hash of associated files
        latest_commit_hash = get_latest_commit_hash(base_file)
        if comment['commithash']:
            uptodate = latest_commit_hash.startswith(comment['commithash'])
        else:
            uptodate = False
        # 3. include into data table
        d = data
        # Recursivly get to leaf for comment insertion
        for sub in base_file[len(base_path):].split('/'):
            if sub not in d:
                d[sub] = {}
            d = d[sub]
        d.update(comment)
        d['uptodate'] = uptodate
        d['latest_commithash'] = latest_commit_hash
    # 4. export csv
    print(yaml.dump(data))


if __name__ == "__main__":
    main()
