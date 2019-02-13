#!/usr/bin/env python3
from glob import glob
import os
from copy import copy
import readline  # requires py3x-gnureadline on OS X
import sys
import textwrap
import re
import atexit
from subprocess import CalledProcessError

import yaml

from generate_comments import get_latest_commit_hash, load_comment


patterns_to_comment = ["machine_files/**/*[!.][!c][!o][!m][!m][!e][!n][!t].yml",
                       "stencils/**/*.c",
                       "stencils/**/*.svg"]
default_comment = load_comment(os.path.join(os.path.dirname(__file__), 'template_comment.yml'))


def input_with_prefill(prompt, text):
    # from https://stackoverflow.com/a/8505387/2754040
    # does not work in an interactive shell
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

    # Compile list of files to process
    files = []
    for glob_pattern in patterns_to_comment:
        files += list(filter(lambda x: re.match(path_filter, x), glob(glob_pattern, recursive=True)))
    files.sort()

    print('Selected files:', len(files))
    print()

    saved_comment_files = []
    # atexit handler
    def print_saved_comment_files():
        if saved_comment_files:
            print('Saved comment files:')
            print(' '.join(saved_comment_files))
            print('Add, commit and push them to git repo.')
        else:
            print('Nothing changed.')
    atexit.register(print_saved_comment_files)

    for n, file_to_comment in enumerate(files):
        print('{:>4}/{:<4} '.format(n+1, len(files)), file_to_comment)
        print('Status: ', end='')

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
        orig_comment = copy(comment)

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

        if comment['author']:
            print('previous author:', comment['author'])

        # commithash
        print('{}: {} -> {} (latest commit hash)'.format(
            'commithash', comment['commithash'], latest_commit_hash))
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

        # Skip if:
        # comment and review are empty
        if not (comment['comment'] or orig_comment['review']):
            print('nothing changed. Not saving.\n')
            continue

        if author:
            print('new author: {}'.format(author))
            comment['author'] = author

        # confirm saving
        try:
            first = True
            valid_inputs = {'yes': True, 'no': False, 'y': True, 'n': False, '1': True, '0': False}
            while first or save not in valid_inputs:
                if not first:
                    print('Valid inputs are: {}'.format(', '.join(valid_inputs.keys())))
                else:
                    first = False
                save = input('Save? [y/n] ')
        except EOFError:
            print(' [skipped]\n')
            continue
        save = valid_inputs[save]
        if not save:
            print('not saved.\n')
            continue

        # save
        with open(comment_file, 'w') as f:
            yaml.dump(comment, f)
        print('saved to {}'.format(comment_file))
        saved_comment_files.append(comment_file)
        print()

if __name__ == '__main__':
    try:
        main()
    except KeyboardInterrupt:
        print('\n')