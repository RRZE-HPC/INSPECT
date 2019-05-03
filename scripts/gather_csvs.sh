#! /bin/bash -l

DATA_FOLDER=./_data/stencils
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
								newfilename=$(echo ${file} | sed 's/\.\/stencils\///g;s/\//_/g;s/_512/_avx512/')
						    cp ${file} ${DATA_FOLDER}/${newfilename}
							done
						done
					done
				done
			done
		done
	done
done
