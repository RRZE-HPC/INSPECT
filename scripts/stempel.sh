#! /bin/bash -l
#PBS -l nodes=broadep2:ppn=72,walltime=24:0:0
#PBS -N stempel_bench_broadwell
# stdout and stderr files

# dependencies
# - stempel
# - kerncraft
# - likwid
# - numactl
# - (intel) compiler
# - python + python-sympy
# - grep, sed, awk, bc

export STEMPEL_BINARY=~/.local/bin/stempel
export KERNCRAFT_BINARY=~/.local/bin/kerncraft
export STEMPEL_DIR=~/stempel

export OUTPUT_FOLDER=~/stempel_data_collection

# dimension: 2 or 3 (currently only 3D is supported)
export DIM=3
# desired stencil radius: 1,2,3,...
export RADIUS=1
# stencil kind: 'star' or 'box'
export KIND=star
# coefficients: 'constant' or 'variable'
export CONST=constant
# weighting: 'isotropic', 'heterogeneous', 'homogeneous', 'point-symmetric'
export WEIGHTING=heterogeneous
# datatype: 'double' or 'float'
export DATATYPE=double

# variables
export MACHINE_FILE=${STEMPEL_DIR}/tests/testfiles/BroadwellEP_E5-2697_CoD.yml
#export MACHINE_FILE=${STEMPEL_DIR}/tests/testfiles/HaswellEP_E5-2695v3.yml
#export MACHINE_FILE=${STEMPEL_DIR}/tests/testfiles/SkylakeSP_Gold-6148.yml
#export MACHINE_FILE=${STEMPEL_DIR}/tests/testfiles/SkylakeSP_Gold-6148_512.yml

# counters for BroadEP2, HasEP1 and SkylapeSP1
export COUNTER="CAS_COUNT_RD:MBOX4C1,CAS_COUNT_RD:MBOX6C0,CAS_COUNT_RD:MBOX2C1,CAS_COUNT_RD:MBOX3C0,CAS_COUNT_WR:MBOX0C1,CAS_COUNT_RD:MBOX5C1,L1D_REPLACEMENT:PMC0,CAS_COUNT_WR:MBOX5C0,CAS_COUNT_RD:MBOX0C0,CAS_COUNT_WR:MBOX6C1,L1D_M_EVICT:PMC2,CAS_COUNT_RD:MBOX7C1,CAS_COUNT_RD:MBOX1C1,CAS_COUNT_WR:MBOX4C0,CAS_COUNT_WR:MBOX2C0,CAS_COUNT_WR:MBOX1C0,CAS_COUNT_WR:MBOX3C1,CAS_COUNT_WR:MBOX7C0,L2_LINES_IN_ALL:PMC3,L2_TRANS_L2_WB:PMC1"

# counters for IvyBridge
#export COUNTER="L1D_REPLACEMENT:PMC0,L2_LINES_OUT_DIRTY_ALL:PMC1,L1D_M_EVICT:PMC2,L2_LINES_IN_ALL:PMC3,CAS_COUNT_RD:MBOX4C1,CAS_COUNT_RD:MBOX6C0,CAS_COUNT_RD:MBOX2C1,CAS_COUNT_RD:MBOX3C0,CAS_COUNT_WR:MBOX0C1,CAS_COUNT_RD:MBOX5C1,CAS_COUNT_WR:MBOX5C0,CAS_COUNT_RD:MBOX0C0,CAS_COUNT_WR:MBOX6C1,CAS_COUNT_RD:MBOX7C1,CAS_COUNT_RD:MBOX1C1,CAS_COUNT_WR:MBOX4C0,CAS_COUNT_WR:MBOX2C0,CAS_COUNT_WR:MBOX1C0,CAS_COUNT_WR:MBOX3C1,CAS_COUNT_WR:MBOX7C0"

# **************************************************************************************************
# **************************************************************************************************
# ********** DONT CHANGE ANYTHING AFTER THIS LINE **************************************************
# **************************************************************************************************
# **************************************************************************************************

# load modules (this ist for the testcluster)
module load likwid/4.3.2 intel64/17.0up05 python/3.6-anaconda

likwid-topology -g

echo "NUMA"
numactl --show

# compile args
export COMPILE_ARGS="-qopenmp -DLIKWID_PERFMON $LIKWID_INC $LIKWID_LIB \
	-I${STEMPEL_DIR}/stempel/headers/ ${STEMPEL_DIR}/stempel/headers/timing.c \
	${STEMPEL_DIR}/stempel/headers/dummy.c stencil_compilable.c -o stencil -llikwid"

# FIX frequencies
export ghz=$(grep clock ${MACHINE_FILE} | sed -e 's/clock: //' -e 's/ GHz//')
likwid-setFrequencies -t 0 -f ${ghz} --umin ${ghz} --umax ${ghz}

export MACHINE=$(echo ${MACHINE_FILE} | sed -e 's/.*\///g' -e 's/.yml//')

for fDIM in ${DIM}; do
for fRADIUS in ${RADIUS}; do
for fKIND in ${KIND}; do
for fCONST in ${CONST}; do
for fWEIGHTING in ${WEIGHTING}; do
for fDATATYPE in ${DATATYPE}; do

	export DATE=$(date +'%Y%m%d_%H%M%S')
	export FOLDER="${OUTPUT_FOLDER}/${fDIM}D_r${fRADIUS}_${fKIND}_${fCONST}_${fWEIGHTING}/${DATE}_${MACHINE}"
	mkdir -p ${FOLDER} && cd ${FOLDER}
	mkdir data

	echo ":: RUNNING: ${fDIM}D r${fRADIUS} ${fKIND} ${fCONST} ${fWEIGHTING} ${DATE} ${MACHINE}"

	if [[ ${fWEIGHTING} == "isotropic" ]]; then
		export S_WEIGHTING=-i
	elif [[ ${fWEIGHTING} == "heterogeneous" ]]; then
		export S_WEIGHTING=-e
	elif [[ ${fWEIGHTING} == "homogeneous" ]]; then
		export S_WEIGHTING=-o
	elif [[ ${fWEIGHTING} == "point-symmetric" ]]; then
		export S_WEIGHTING=-p
	fi

	export COMPILER=$(cat ${MACHINE_FILE} | grep icc | sed 's/.*icc: /icc /')
	export STEMPEL_ARGS="gen -D ${fDIM} -r ${fRADIUS} -k ${fKIND} -C ${fCONST} ${S_WEIGHTING} -t ${fDATATYPE}"
	# save all arguments
	echo ":: SAVING ARGUMENTS"
	echo {\$,$}STEMPEL_ARGS >> args.txt
	echo {\$,$}STEMPEL_BENCH_BLOCKING >> args.txt
	echo {\$,$}STEMPEL_DIR >> args.txt
	echo {\$,$}MACHINE_FILE >> args.txt
	echo {\$,$}DATE >> args.txt
	echo {\$,$}COMPILER >> args.txt
	echo {\$,$}COMPILE_ARGS >> args.txt

	# generate stencil
	echo ":: GENERATING STENCIL"
	${STEMPEL_BINARY} gen -D ${fDIM} -r ${fRADIUS} -k ${fKIND} -C ${fCONST} ${S_WEIGHTING} -t ${fDATATYPE} --store stencil.c

	# ************************************************************************************************
	# Grid Scaling
	# ************************************************************************************************

	# Layer Condition Analysis
	${KERNCRAFT_BINARY} -p LC -m ${MACHINE_FILE} ./stencil.c -D N 100 -D M 100 -D P 100 -vvv --cores 1 --compiler icc --ignore-warnings > data/LC.txt

	# L3 3D Layer Condition
	export LC_3D_L3=$(cat data/LC.txt | grep L3: | tail -n 1 | sed -e 's/.*: //' -e 's/<=/-/')
	export LC_3D_L3_N=$(python -c "import sympy;N=sympy.Symbol('N',positive=True);print(sympy.solvers.solve($(echo ${LC_3D_L3} | sed 's/[A-Z]/N/g'), N))" | sed -e 's/\[//' -e 's/\]//')
	export LC_3D_L3_N=$(bc -l <<< "scale=0;1.5*(${LC_3D_L3_N})")
	export LC_3D_L3_N=$(bc -l <<< "scale=0;${LC_3D_L3_N}-${LC_3D_L3_N}%10+10")
	export LC_3D_L3_N=$(echo ${LC_3D_L3_N} | sed 's/\..*//')

	mkdir data/singlecore

	for (( size=10; size<=${LC_3D_L3_N}+10; size=size+10)); do
		echo -ne "\033[0K\r:: RUNNIG SINGLE CORE BENCHMARK N=${size}"
		export KERNCRAFT_ARGS="-m ${MACHINE_FILE} ./stencil.c -D N ${size} -D M ${size} -D P ${size} -vvv --cores 1 --compiler icc --ignore-warnings"
		${KERNCRAFT_BINARY} -p RooflineIACA -P SIM ${KERNCRAFT_ARGS} > data/singlecore/Roofline_SIM_${size}.txt
		${KERNCRAFT_BINARY} -p RooflineIACA -P LC ${KERNCRAFT_ARGS} > data/singlecore/Roofline_LC_${size}.txt
		${KERNCRAFT_BINARY} -p ECM -P SIM ${KERNCRAFT_ARGS} > data/singlecore/ECM_SIM_${size}.txt
		${KERNCRAFT_BINARY} -p ECM -P LC ${KERNCRAFT_ARGS} > data/singlecore/ECM_LC_${size}.txt
		${KERNCRAFT_BINARY} -p Benchmark -P LC ${KERNCRAFT_ARGS} > data/singlecore/Bench_${size}.txt
	done

	echo

	# ************************************************************************************************
	# Threads Scaling
	# ************************************************************************************************

	# create bench code
	echo ":: GENERATING BENCHMARK CODE"
	${STEMPEL_BINARY} bench stencil.c -m ${MACHINE_FILE} -b 0 --store

	# fix compilation
	sed -ri 's/#include <math.h>//' stencil_compilable.c
	sed -ri 's/ rand.*/ 1.;/' stencil_compilable.c

	# compile
	echo ":: COMPILING"
	${COMPILER} ${COMPILE_ARGS}
	mv stencil stencil_scaling

	export cores=$(cat ${MACHINE_FILE} | grep "cores per socket" | sed 's/.*: //')

	mkdir data/scaling

	# write results file header
	echo "N,threads,iterations,time,blocking factor,flop,lup,Gflop/s,Gflop/s (Roofline),Mlup/s,Mlup/s (Roofline),cy/CL,cy/CL (ECM),MLUP/s (ECM),l1-l2 miss,l1-l2 evict,l2-l3 miss,l2-l3 evict,l3-mem miss,l3-mem evict,l1-l2 total,l2-l3 total,l3-mem total" >> scaling.csv

	for (( threads = 1; threads <= ${cores}; threads++ )); do

		export OMP_NUM_THREADS=${threads}

		echo -ne "\033[0K\r:: RUNNIG THREAD SCALING BENCHMARK N=${LC_3D_L3_N} threads=${threads}"

		likwid-perfctr -f -o data/scaling/likwid_${LC_3D_L3_N}_${threads}.txt -g ${COUNTER} -C S0:0-$(($threads - 1)) -m ./stencil_scaling ${LC_3D_L3_N} ${LC_3D_L3_N} ${LC_3D_L3_N} >> data/scaling/likwid_${LC_3D_L3_N}_${threads}_out.txt
		${KERNCRAFT_BINARY} -p RooflineIACA -P SIM -m ${MACHINE_FILE} ./stencil.c -D N ${LC_3D_L3_N} -D M ${LC_3D_L3_N} -D P ${LC_3D_L3_N} -vvv --cores ${threads} --compiler icc --ignore-warnings >> data/scaling/RooflineIACA_${LC_3D_L3_N}_${threads}.txt
		${KERNCRAFT_BINARY} -p ECM -P SIM -m ${MACHINE_FILE} ./stencil.c -D N ${LC_3D_L3_N} -D M ${LC_3D_L3_N} -D P ${LC_3D_L3_N} -vvv --cores ${threads} --compiler icc --ignore-warnings >> data/scaling/ECM_${LC_3D_L3_N}_${threads}.txt
	done

	echo

	# ************************************************************************************************
	# Cache Blocking
	# ************************************************************************************************
	export OMP_NUM_THREADS=1

	echo ":: GENERATING BENCHMARK CODE WITH BLOCKING"
	${STEMPEL_BINARY} bench stencil.c -m ${MACHINE_FILE} -b 2 --store

	sed -ri 's/#include <math.h>//' stencil_compilable.c
	sed -ri 's/ rand.*/ 1.;/' stencil_compilable.c

	# compile
	echo ":: COMPILING"
	${COMPILER} ${COMPILE_ARGS}
	mv stencil stencil_blocking

	mkdir data/blocking

	# run benchmark
	for (( size=10; size<=${LC_3D_L3_N}+10; size=size+10)); do

		# blocking factor  x direction 100 or size_x if it is smaller
		export PB=$(python -c "import sympy;P=sympy.Symbol('P',positive=True);print(sympy.solvers.solve($(echo ${LC_3D_L3} | sed 's/N/16/g'), P))" | sed -e 's/\[//' -e 's/\]//')
		export PB=$(bc -l <<< "scale=0;1.5*(${PB})/10*10")
		export PB=$(( ${PB} > ${size} ? ${size} : ${PB} ))

		# y direction: LC
		export TMP=$(echo ${LC_3D_L3} | sed "s/P/${PB}/g")
		export NB=$(bc -l <<< "scale=0;$(python -c "import sympy;N=sympy.Symbol('N',positive=True);print(sympy.solvers.solve(${TMP}, N))" | sed -e 's/\[//' -e 's/\]//')")

		# blocking factor z direction, fixed factor: 16
		export MB=16

		export STEMPEL_BENCH_BLOCKING_value="${MB} ${NB} ${PB}"
		export args="${size} ${size} ${size} ${STEMPEL_BENCH_BLOCKING_value}"

		echo -ne "\033[0K\r:: RUNNIG BENCHMARK N=${args}"

		likwid-perfctr -f -o data/blocking/likwid_${size}.txt -g ${COUNTER} -C S0:0 -m ./stencil_blocking ${args} >> data/blocking/likwid_${size}_out.txt
	done
	echo

done
done
done
done
done
done
