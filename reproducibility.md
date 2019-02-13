
[« go home](index)

## Why is benchmarking complicated?

- anything has to be documented
- Reduce influences
- anything has to be controlled
- How to make your benchmark reproducable?

## Benchmark Impact Factors

### Hardware

- CPU: type, name, model, frequencies, CoD/SNCm...
- Memory
- Vendors
- IO subsystem
- pinning

### Software

- OS
  - relevant OS settings (`numa_balancing`)
  - Environment Variables
- Compiler
 - Version with all options specified
- Libraries
 - Version / DL source (original, patched)
- Bios settings

## How to obtain Information

- `likwid-topology`
- `likwid-powermeter`
- `likwid-setFrequencies`

## Benchmark preparation

- Reliable timer/timing granularity
- if possible: Establish a (basic) performance model (roofline, ECM, ...)
- get some reference numbers to decide if your results are reasonable
  - micro benchmarks: `likwid-bench`
  - documentation of the hardware vendor

## Good Performance Metrics

- simple performance metric: time to solution, 1/walltime

## Let's do it!

...

## Why does my runtime vary?

- no/wrong task placement (-> pinning)
  - eliminate performance variation
  - making use of architectural features
  - avoid resource contention
  - `likwid-pin`, `numactl`, `sched.h`, `taskset`, OPENMP/MPI-specific settings
- Did you set the correct thread count?
- Too short runtime
  - depends on the workingset size
  - should be atleast a second
  - timer granularity problems
  - too few repetition

<!-- ## Reproducibility

- Anzahl der eingeloggten User auf dem System (users, w, ...)
- Aktuelles CPUset (procfs oder likwid-pin -p)
- CPU Frequenz auf eine bestimmte Frequenz gepinnt? Turbo? (likwid-setFrequencies)
- Uncore Frequenzgrenzen oder gepinnt? (likwid-setFrequencies)
- Prefetcher (likwid-features)
- Topologie (likwid-topology, lscpu, numactl, ...)
- Numa Balancing? (procfs)
- Huge pages (procfs)
- Aktuelle Load (falls noch andere Prozesse laufen)
- Energielimits (sysfs)
- Performance energy bias (likwid-powermeter -i) -->
