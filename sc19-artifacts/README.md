
# How to replicate data

Prerequisit: Python 3.5 or above, Intel Compiler (ICC) 19

0. __Setup Python virtual enviornment__ (optional)

  Execute the following commands, to setup and activate a Python virtual environment:
  ```
  python -m venv virtual_env_dir
  source virtual_env_dir/bin/activate
  ```
  
  For details see: https://packaging.python.org/guides/installing-using-pip-and-virtualenv/

1. __Install dependencies__
  - Install stempel (https://github.com/RRZE-HPC/stempel) by executing:
    `pip install 'git+https://github.com/RRZE-HPC/stempel.git'`
    This will also install other dependencies, such as Kerncraft (https://github.com/RRZE-HPC/kerncraft).
  - Install LIKWID (https://github.com/RRZE-HPC/likwid).
    This step will depend on your Linux distribution, on Debian and Ubuntu use:
    `apt install likiwd`

2. __Clone the INSPECT repository__
  Select sc19-artifacts branch and fetch all submodules:
  - `git clone -b sc19-artifacts --recurse-submodules https://github.com/RRZE-HPC/INSPECT.git`
  - enter newly created directory: `cd INSPECT`

3. __Machine file__

  Proceed with _one_ of the following options:
  - Existing machine files can be found in the `machine_files` folder of the INSPECT repository
  - If no suitable machine file exists for your machine:
    - Run `likwid_bench_auto` installed with Kerncraft and fill in all missing data (may possibly be copied from existing machine files of similar architectures)

4. __Execute a benchmark__
  - The `sc19-artifacts` folder contains all benchmark scripts necessary to replicate data shown in the SC19 SOP paper
  - Select and edit benchmark script which matches your machine's microarchitecture:
    - Edit paths to folders and executables (`STEMPEL_BINARY`, `KERNCRAFT_BINARY`, `INSPECT_DIR` and `OUTPUT_DIR`)
    - Edit path to machine_file (`MACHINE_FILE`)
  - Make sure the Intel Compiler and Python are available and virtual environment (Step 0) is activated
  - Run benchmarck script

5. __Inspect results__

  Proceed with _one_ of the following options:
  - The previously specified `OUTPUT_DIR` contains all postprocessed data in csv files, data can be compared to the according csv files in the `stencils` folder of the INSPECT github repository
  - You can fork the INSPECT repository, setup travis with your account and push the postprocessed data to that repository. Travis will then generate the website that can be viewed online.
  - Build the website locally:
    - Install [jekyll](https://github.com/jekyll/jekyll)
    - Build website: `bundle exec jekyll serve`
    - Visit website locally under [http://localhost:4000/INSPECT](http://localhost:4000/INSPECT)
