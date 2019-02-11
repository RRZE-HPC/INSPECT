#!/usr/bin/env python3
from glob import glob
import os
from copy import copy
import readline  # requires py3x-gnureadline on OS X
import sys
import textwrap
import re

import yaml

from generate_comments import get_latest_commit_hash, load_comment


patterns_to_comment = ["machine_files/**/*[!.][!c][!o][!m][!m][!e][!n][!t].yml",
                       "stencils/**/*.c",
                       "stencils/**/*.svg"]
default_comment = load_comment(os.path.join(os.path.dirname(__file__), 'template_comment.yml'))


def input_with_prefill(prompt, text):
    # from https://stackoverflow.com/a/8505387/2754040
    def hook():
        readline.insert_text(text)
    readline.set_startup_hook(hook)
    result = input(prompt)
    readline.set_startup_hook()
    return result


def main():
    print(textwrap.dedent("""
        Usage:
            {} "Author's Name" [path/filter]
            When asked to input review, options are: green, orange, red and "nothing".
            Comments may be any markdown formatted string.

            To skip comment AND review (or leave unchanged) hit Ctrl-D.
        """.format(sys.argv[0])))
    if len(sys.argv) < 2:
        sys.exit(1)

    author = sys.argv[1]
    if len(sys.argv) >= 3:
        path_filter = sys.argv[2]
    else:
        path_filter = ''
    path_filter = re.compile(path_filter)

    for glob_pattern in patterns_to_comment:
        # TODO group by folder
        for file_to_comment in glob(glob_pattern, recursive=True):
            # Skip files based on filter
            if not re.match(path_filter, file_to_comment):
                continue
            print('*', file_to_comment, end=': ')

            # Initialize comment with default data
            comment = copy(default_comment)

            # Load already existing comment
            comment_file = file_to_comment+'.comment.yml'
            try:
                comment.update(load_comment(comment_file))
            except FileNotFoundError:
                pass
            except TypeError:
                print('malformed comment file, will overwrite with defaults.')

            # Check if it is up-to-date
            try:
                latest_commit_hash = get_latest_commit_hash(file_to_comment)
            except CalledProcessError:
                print('does not exist or is not in a git repo.')
                continue
            if latest_commit_hash == '':
                print('has not been commited. Commit first and than comment.')
                continue
            if comment['commithash']:
                if latest_commit_hash.startswith(comment['commithash']):
                    print('comment and review is up-to-date. You may update it manually.')
                    continue

            # Ask user to update comment and review
            print('needs review and (optional) comment')
            # commithash
            print('{}: {} -> {} (latest commit hash)'.format(
                'commithash', comment['commithash'],latest_commit_hash))
            comment['commithash'] = latest_commit_hash
            # review
            try:
                first = True
                valid_inputs = ['red', 'orange', 'green', 'grey', None]
                while first or comment['review'] not in valid_inputs:
                    if not first:
                        print('Valid inputs are: {}'.format(valid_inputs))
                    else:
                        first = False
                    comment['review'] = input_with_prefill('review: ', comment['review']) or None
            except EOFError:
                print(' [skipped]\n')
                continue
            # comment
            try:
                comment['comment'] = input_with_prefill('comment: ', comment['comment']) or None
            except EOFError:
                print(' [skipped]\n')
                continue

            # save and show author
            if author:
                print('auther: {}'.format(author))
                comment['author'] = author
            with open(comment_file, 'w') as f:
                yaml.dump(comment, f)
            print('saved to {}'.format(comment_file))
            print()





if __name__ == '__main__':
    main()
