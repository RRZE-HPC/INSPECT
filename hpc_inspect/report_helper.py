#!/usr/bin/env python3
import html
from collections import defaultdict
from pathlib import Path
import json
from pprint import pformat
from tempfile import NamedTemporaryFile
import sys
from unittest.mock import patch
import io
from math import copysign

from IPython.display import display, HTML, Code
from ipywidgets import widgets
import pandas as pd
import matplotlib.pyplot as plt
import matplotlib.ticker as mticker
import compress_pickle
from tabulate import tabulate
import numpy as np
import machinestate


def divide(numerator, denominator):
    if denominator == 0.0:
        return copysign(float('inf'), denominator)
    return numerator / denominator


def load_pickled_dataframe(fname='dataframe.pickle.lzma'):
    data = compress_pickle.load(fname)
    if data.empty or any([c not in data.columns
                          for c in ['compiler', 'incore_model', 'cache_predictor']]):
        raise SystemExit("No data avilable")
    return data


def get_unique(data, column, no_nones=True):
    return [i for i in data[column].unique() if i is not None or not no_nones]


def get_iterations_per_cacheline(data):
    return int(data.get('iterations per cacheline').dropna().unique()[0])


def get_output(data, **kwargs):
    d = data
    for k, v in kwargs.items():
        d = d.query(k+' == @v')

    if len(d) > 1:
        print("!!! Multiple jobs selected ({}), printing first result:".format(len(d)))
    elif len(d) == 0:
        raise Exception("nothing found")

    return d.iloc[0]['raw output']