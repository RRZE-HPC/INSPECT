#! /bin/bash -l

DATA_FOLDER=./_data/stencils

RESULTS_HEADER="N^3,Roofline CS GFLOPs,Roofline CS MLUPs,Roofline CS Arithmetic Intensity,Roofline LC GFLOPs,Roofline LC MLUPs,Roofline LC Arithmetic Intensity,Roofline ECM MLUPs,Benchmark MLUPs,ECM CS Tol,ECM CS Tnol,ECM CS Tl1l2,ECM CS Tl2l3,ECM CS Tl3mem,ECM CS cycl,ECM LC Tol,ECM LC Tnol,ECM LC Tl1l2,ECM LC Tl2l3,ECM LC Tl3mem,ECM LC cycl,Benchmark cycl,Benchmark Pheno Tol,Benchmark Pheno Tnol,Benchmark Pheno Tl1l2,ECM LC Tl2l3,Benchmark Pheno Tl3mem,Benchmark Transfer L1L2 load,Benchmark Transfer L1L2 evict,Benchmark Transfer L1L2 total,Benchmark Transfer L2L3 load,Benchmark Transfer L2L3 evict,Benchmark Transfer L2L3 total,Benchmark Transfer L3MEM load,Benchmark Transfer L3MEM evict,Benchmark Transfer L3MEM total,CS Transfer L1L2 load,CS Transfer L1L2 evict,CS Transfer L1L2 total,CS Transfer L2L3 load,CS Transfer L2L3 evict,CS Transfer L2L3 total,CS Transfer L3MEM load,CS Transfer L3MEM evict,CS Transfer L3MEM total,LC Transfer L1L2 load,LC Transfer L1L2 evict,LC Transfer L1L2 total,LC Transfer L2L3 load,LC Transfer L2L3 evict,LC Transfer L2L3 total,LC Transfer L3MEM load,LC Transfer L3MEM evict,LC Transfer L3MEM total"

rm -rf ${DATA_FOLDER}
mkdir -p ${DATA_FOLDER}

for DIM in ./stencils/*; do
	for RADIUS in ${DIM}/*; do
		for WEIGHTING in ${RADIUS}/*; do
			for KIND in ${WEIGHTING}/*; do
				for CONST in ${KIND}/*; do
					for DATATYPE in ${CONST}/*; do
						for MACHINE in ${DATATYPE}/*; do
							for file in ${MACHINE}/*csv; do
								newfilename=$(echo ${file} | sed 's/\.\/stencils\///g;s/\//_/g;')
								filename=$(echo ${newfilename} | sed 's/.*_//')
								case ${filename} in
								"results.csv")
										echo ${RESULTS_HEADER} > ${DATA_FOLDER}/${newfilename}
								    tail -n +4 ${file} >> ${DATA_FOLDER}/${newfilename}
								    ;;
								"scaling.csv")
								    cp ${file} ${DATA_FOLDER}/${newfilename}
								    ;;
								*)
								    cp ${file} ${DATA_FOLDER}/${newfilename}
								    ;;
								esac
							done
						done
					done
				done
			done
		done
	done
done
