
# How to replicate our data

1. Install dependencies
  - stempel: https://github.com/RRZE-HPC/stempel
  - Kerncraft: https://github.com/RRZE-HPC/kerncraft
  - LIKWID: https://github.com/RRZE-HPC/likwid
2. Clone the INSPECT repository and switch to the 'sc19-artifacts' branch
  - https://github.com/RRZE-HPC/INSPECT.git
  - fetch all submodules `git ...`
  - `git checkout sc19-artifacts`
3. Machine file
  - existing machine files can be found in the `machine_files` folder of the INSPECT repository, if no suitable machine file exists for your machine:
    - run `likwid_bench_auto` from Kerncraft and fill in all missing data (may be copied from existing machine files)
4. Execute a benchmark
  - edit benchmark script
    - edit paths to folders and executables (`STEMPEL_BINARY`, `KERNCRAFT_BINARY`, `INSPECT_DIR` and `OUTPUT_DIR`)
    - edit path to machine_file (`MACHINE_FILE`)
   - make sure intel compiler and
   - run benchmarck script
5. Inspect results
