---
title:  "INSPECT: Intranode Stencil Performance Evaluation Collection"
---

# {{site.title}}

The goal of this website is the collection and presentation of reproducible intranode stencil performance data.

Automatic generation of loop kernels for several kinds of stencil patterns (see [below](#navigation) for configuration details) is done via [STEMPEL](https://github.com/RRZE-HPC/stempel 'stempel'). In combination with [Kerncraft](https://github.com/RRZE-HPC/kerncraft 'kerncraft') and [LIKWID](https://github.com/RRZE-HPC/likwid 'LIKWID'), the INSPECT tool-chain provides a framework to generate and perform static analysis of the stencil code. Data collection can be done with a simple [batch script](https://github.com/RRZE-HPC/INSPECT/blob/master/scripts/stempel.sh). The presented data allows easy matching of the measured performance data with the automatically generated single- and multicore performance models ([ECM](https://hpc.fau.de/research/ecm/) and [Roofline](https://www2.eecs.berkeley.edu/Pubs/TechRpts/2008/EECS-2008-164.html)).

## Machine Descriptions

Detailed descriptions of the machines used on this website can be found [here](machinefiles 'Machine Files'). Machine files specify information about a machine model for each micro architecture. The [Kerncraft](https://github.com/RRZE-HPC/kerncraft 'kerncraft') repository already contains machine files for the most relevant architectures. Machine files for new hardware can be created with the `likwid_bench_auto` command provided by [Kerncraft](https://github.com/RRZE-HPC/kerncraft 'kerncraft').

## Reproducibility

An important topic with this website is the reproducibility of benchmark results. Every stencil provides information on how the exact benchmarks were run. Together with the machine file specification, which is also linked with every stencil, reproducible benchmark results are possible.

Find out how to [replicate data](data_replication) shown on this website.

Information on how to perform reproducible performance benchmarks, can be found on [this page](reproducibility 'Reproducibility').

{% include navigation.md %}

## Reviews

Overview of all available or missing reviews can be found on [this page](reviews).
