#! /bin/bash -l

DATA_FOLDER=./_data/stencils
rm -rf ${DATA_FOLDER}
mkdir -p ${DATA_FOLDER}

for DIM in ./stencils/*; do
	if [ -d ${DIM} ]; then
	if [[ ${DIM} == "./stencils/named" ]]; then
		for STENCIL in ${DIM}/*; do
			if [ -d ${STENCIL} ]; then
			for MACHINE in ${STENCIL}/*; do
				if [ -d ${MACHINE} ]; then
				for file in ${MACHINE}/*csv; do
					newfilename=$(echo ${file} | sed 's/\.\/stencils\/named\///g;s/\//_/g;s/_512/_avx512/')
			    cp ${file} ${DATA_FOLDER}/${newfilename}
				done
				fi
			done
			fi
		done
	else
		for RADIUS in ${DIM}/*; do
			if [ -d ${RADIUS} ]; then
				for WEIGHTING in ${RADIUS}/*; do
					if [ -d ${WEIGHTING} ]; then
					for KIND in ${WEIGHTING}/*; do
						if [ -d ${KIND} ]; then
						for CONST in ${KIND}/*; do
							if [ -d ${CONST} ]; then
							for DATATYPE in ${CONST}/*; do
								if [ -d ${DATATYPE} ]; then
								for MACHINE in ${DATATYPE}/*; do
									if [ -d ${MACHINE} ]; then
									for file in ${MACHINE}/*csv; do
										newfilename=$(echo ${file} | sed 's/\.\/stencils\///g;s/\//_/g;s/_512/_avx512/')
								    cp ${file} ${DATA_FOLDER}/${newfilename}
									done
									fi
								done
								fi
							done
							fi
						done
						fi
					done
					fi
				done
			fi
		done
	fi
	fi
done
