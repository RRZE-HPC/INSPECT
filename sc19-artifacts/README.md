
# How to replicate data

1. __Install dependencies__
  - stempel: https://github.com/RRZE-HPC/stempel
  - Kerncraft: https://github.com/RRZE-HPC/kerncraft
  - LIKWID: https://github.com/RRZE-HPC/likwid

2. __Clone the INSPECT repository__
  - `git clone https://github.com/RRZE-HPC/INSPECT.git`
  - fetch all submodules `git submodule init && git submodule update`
  - switch to the sc19-artifacts branch: `git checkout sc19-artifacts`

3. __Machine file__
  a) existing machine files can be found in the `machine_files` folder of the INSPECT repository
  b) if no suitable machine file exists for your machine:
    - run `likwid_bench_auto` installed with Kerncraft and fill in all missing data (may possibly be copied from existing machine files of similar architectures)

4. __Execute a benchmark__
  - the `sc19-artifacts` folder contains all benchmark scripts necessary to replicate data shown in the SC19 SOP paper
  - edit benchmark script:
    - edit paths to folders and executables (`STEMPEL_BINARY`, `KERNCRAFT_BINARY`, `INSPECT_DIR` and `OUTPUT_DIR`)
    - edit path to machine_file (`MACHINE_FILE`)
  - make sure intel compiler and python (including sympy) are available
  - run benchmarck script

5. __Inspect results__
  a) the previously specified `OUTPUT_DIR` contains all postprocessed data in csv files, data can be compared to the according csv files in the `stencils` folder of the INSPECT github repository
  b) you can fork the INSPECT repository, setup travis with your account and push the postprocessed data to that repository. Travis will then generate the website that can be viewed online.
  c) build the website locally:
    - Install [jekyll](https://github.com/jekyll/jekyll)
    - Build website: `bundle exec jekyll serve`
    - visit website locally under [http://localhost:4000/INSPECT](http://localhost:4000/INSPECT)
