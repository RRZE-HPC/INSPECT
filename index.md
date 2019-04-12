---
title:  "INSPECT: Intranode Stencil Performance Evaluation Collection"
---

# {{site.title}}

The [stempel](https://github.com/RRZE-HPC/stempel 'stempel') tool allows automatic generation of loop kernels for several kind of stencil patterns. Stempel provides a framework to generate, perform static analysis of the code (exploiting kerncraft), generate a full C code and parallelize it via openMP and blocking.

On this site a collection of benchmark data obtained from the [stempel](https://github.com/RRZE-HPC/stempel 'stempel') tool can be found.

## Machine Descriptions

Detailed descriptions of the machines used on this website can be found [here](machinefiles 'Machine Files'). Machine files for new hardware can be created with the `likwid_bench_auto` command provided by [kerncraft](https://github.com/RRZE-HPC/kerncraft 'kerncraft').

## Reproducibility

An important topic with this website is the reproducibility of benchmark results. Every stencil provides information on how the exact benchmarks were run. Together with the machine file specification, which is also linked with every stencil, reproducable benchmark results are possible.

Information on how to perform reproducible performance benchmarks, can be found on [this page](reproducibility 'Reproducibility').

{% include navigation.md %}

## Reviews

Overview of all available or missing reviews can be found on [this page](reviews).
