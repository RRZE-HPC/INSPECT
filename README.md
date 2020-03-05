![INSPECT](assets/img/inspect-large-black.svg)

# INSPECT
---
## Intranode Stencil Performance Evaluation Collection

This repository contains benchmark results of stencil codes generated with the [
Stencil TEMPlate Engineering Library](https://github.com/RRZE-HPC/stempel "stempel") using [kerncraft](https://github.com/RRZE-HPC/kerncraft) and [LIKWID](https://github.com/RRZE-HPC/likwid).

All collected data can be viewed live on the [Intranode Stencil Performance Evaluation Collection website](https://rrze-hpc.github.io/INSPECT/).

### Data Generation and Post Processing
1. Data can be generated with the script: `scripts/stempel.sh` (change data at the beginning as needed)
2. Postprocessing of data with the script: `scripts/postprocess.sh` (will automatically be called by `scripts/stempel.sh`)
3. (optional) View local version by building the website:
  a. Copy postprocessed data to the `stencils` folder, if not already specified in `scripts/stempel.sh`
  b. Setup metadata: `sh scripts/cibuild`
  c. Install [jekyll](https://github.com/jekyll/jekyll)
  d. Build website: `bundle exec jekyll serve`
4. Push data to this repository

### Data Folder Scheme

1. main folder: "stencils"
2. dimension: "3D" / "2D" ...
3. stencil radius: "r1" / "r2" ...
4. coefficient weighting: "isotropic" / "heterogeneous" / "homogeneous" / "point-symmetric"
5. stencil kind: "star" / "box"
6. coefficient type: "constant" / "variable"
7. datatype: "double" / "float"
8. machine name: "BroadwellEP_E5-2697" (a suitable machine file should exist)

For example:
```
stencils/3D/r1/isotropic/star/constant/double/BroadwellEP_E5-2697
```
---

### License

AGPLv3
