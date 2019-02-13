# stempel data

This repository contains benchmark results obtained with the [
Stencil TEMPlate Engineering Library](https://github.com/RRZE-HPC/stempel "stempel").

## folder scheme

1. main folder: "stencils"
2. dimension: "3D" / "2D" ...
3. stencil radius: "1r" / "2r" ...
4. weighting factors: "isotropic" / "heterogeneous" / "homogeneous" / "point-symmetric"
5. stencil kind: "star" / "box"
6. coefficient type: "constant" / "variable"
7. datatype: "double" / "float"
8. machine name: "BroadwellEP_E5-2697" (a suitable machine file should exist)

For example:
```
stencils/3D/1r/isotropic/star/constant/double/BroadwellEP_E5-2697
```

### Data Generation an processing
1. Data can be generated with the script: `scripts/stempel.sh` (change data at the beginning as needed)
1. Postprocessing of data with the script: `scripts/postprocess.sh`
1. Plots can be generated with the gnuplot script by running: `gnuplot scripts/plot.gnuplot` in the respective folders
