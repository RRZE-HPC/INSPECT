---
title: How to replicate data
---

# {{page.title}}

Prerequisit: Python 3.5 or above, Intel Compiler (ICC) 19

### __Setup Python virtual enviornment__ (optional)

Execute the following commands, to setup and activate a Python virtual environment:
```
python -m venv virtual_env_dir
source virtual_env_dir/bin/activate
```

For details see: [Installing packages using pip and virtualenv](https://packaging.python.org/guides/installing-using-pip-and-virtualenv/)

### __Install dependencies__
1. Install [STEMPEL](https://github.com/RRZE-HPC/stempel) by executing:
`pip install 'git+https://github.com/RRZE-HPC/stempel.git'`
This will also install other dependencies, such as [Kerncraft](https://github.com/RRZE-HPC/kerncraft).
2. Install [LIKWID](https://github.com/RRZE-HPC/likwid):
This step will depend on your Linux distribution, on Debian and Ubuntu use:
`apt install likiwd`

---

## Replicate only a subset

1. Browse the [INSPECT](https://rrze-hpc.github.io/INSPECT/) website
Find data of interest for reproduction: E.g.: [3D / r1 / homogeneous / star / constant / double / HaswellEP_E5-2695v3_CoD](https://rrze-hpc.github.io/INSPECT/stencils/3D/r1/homogeneous/star/constant/double/HaswellEP_E5-2695v3_CoD/)

2. Go to Section "How to replicate this data" and use the provided commands to generate kernel code, build and apply performance models, and benchmark single-core and in-socket behavior.

---

## Replicate all of INSPECT including plots

### __Clone the INSPECT repository__

1. clone the repository and fetch all submodules:
`git clone --recurse-submodules https://github.com/RRZE-HPC/INSPECT.git`
2. enter newly created directory: `cd INSPECT`

### __Machine file__

Proceed with _one_ of the following options:
1. Existing machine files can be found in the `machine_files` folder of the INSPECT repository
2. If no suitable machine file exists for your machine:
  - Run `likwid_bench_auto` installed with Kerncraft and fill in all missing data (may possibly be copied from existing machine files of similar architectures)

### __Execute a benchmark__

- the script [`scripts/stempel.sh`](https://github.com/RRZE-HPC/INSPECT/blob/master/scripts/stempel.sh) can be used as a template
- Select and edit benchmark script which matches your machine's microarchitecture:
  1. Edit paths to folders and executables (`STEMPEL_BINARY`, `KERNCRAFT_BINARY`, `INSPECT_DIR` and `OUTPUT_DIR`)
  2. Edit path to machine_file (`MACHINE_FILE`)
- Make sure the Intel Compiler and Python are available and virtual environment (Step 0) is activated
- Run benchmarck script

### __Inspect results__

Proceed with _one_ of the following options:
1. The previously specified `OUTPUT_DIR` contains all postprocessed data in csv files, data can be compared to the according csv files in the `stencils` folder of the INSPECT github repository
2. You can fork the INSPECT repository, setup travis with your account and push the postprocessed data to that repository. Travis will then generate the website that can be viewed online.
3. Build the website locally:
- Install [jekyll](https://github.com/jekyll/jekyll)
- Build website: `bundle exec jekyll serve`
- Visit website locally under [http://localhost:4000/INSPECT](http://localhost:4000/INSPECT)
