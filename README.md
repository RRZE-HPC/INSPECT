- main folder: "stencils"
-- dimension: "3D" / "2D" ...
--- stencil radius: "1r" / "2r" ...
---- weighting factors: "isotropic" / "heterogeneous" / "homogeneous" / "point-symmetric"
----- stencil kind: "star" / "box"
------ coefficient type: "constant" / "variable"
------- datatype: "double" / "float"
-------- machine name: "BroadwellEP_E5-2697" (a suitable machine file should exist)

each folder contains (at least):
- results.csv: width all benchmark data
- stencil.c: (or similar name) stencil source code
