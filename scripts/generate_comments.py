#!/usr/bin/env python3
import csv
from glob import glob
import os
import sys
import subprocess
from collections import defaultdict
import re

import yaml


def find_comment_files(base_path, comment_file="comments.yml"):
    """Return list of tuple with base and comment file pairs."""
    commented_files = []
    comment_files = glob(os.path.join(base_path, '**/'+comment_file), recursive=True)
    for cf in comment_files:
        # Ignoring all files starting with _
        if not cf[len(base_path):].startswith('_'):
            commented_files.append(cf)
    return commented_files


def load_comment(comment_file):
    """Return data from comment_file."""
    with open(comment_file) as f:
        return yaml.load(f)


def get_latest_commit_date(base_file):
    """Return base_file's latest commit hash."""
    result = subprocess.check_output('git log -n 1 --pretty=format:%ct'.split(' ') + [base_file],
                                     universal_newlines=True)
    if not result:
        return -1
    return result


def check_if_comments_uptodate(comments_filename):
    folder = comments_filename[:-len('comments.yml')]
    comments_date = get_latest_commit_date(comments_filename)
    for file in os.listdir(os.fsencode(folder)):
        filename = os.fsdecode(file)
        if filename != comments_filename:
            file_date = get_latest_commit_date(folder + filename)
            if int(comments_date) < int(file_date):
                return False
    return True


def main():
    # If an argument was passed, use that as base_path:
    if len(sys.argv) >= 2:
        base_path = os.path.join(os.chdir(sys.argv[1]), '')
    else:
        base_path = './'

    data = {}
    # 1. find all comment files
    for comment_file in find_comment_files(base_path):
        comment = load_comment(comment_file)
        # 2. check up-to-dateness of commit hash of associated files
        uptodate = check_if_comments_uptodate(comment_file)
        # 3. include into data table
        d = data
        # Recursivly get to leaf for comment insertion
        for sub in comment_file[len(base_path):-len('/comments.yml')].split('/'):
            if sub not in d:
                d[sub] = {}
            d = d[sub]
        d.update(comment)
        d['uptodate'] = uptodate
    # 4. export csv
    print(yaml.dump(data))


if __name__ == "__main__":
    main()
