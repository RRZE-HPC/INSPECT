#! /bin/bash -l
#PBS -l nodes=hasep1:ppn=56,walltime=24:0:0
#PBS -N INSPECT_SKX_bench
# stdout and stderr files

# dependencies
# - stempel: https://github.com/RRZE-HPC/stempel
# - Kerncraft: https://github.com/RRZE-HPC/kerncraft
# - LIKWID: https://github.com/RRZE-HPC/likwid
# - numactl
# - (intel) compiler
# - python + python-sympy
# - grep, sed, awk, bc

# dimension: 2 or 3 (currently only 3D is supported)
DIM=3
# desired stencil radius: 1,2,3,...
RADIUS=3
# stencil kind: 'star' or 'box'
KIND=start
# coefficients: 'constant' or 'variable'
CONST=constant
# weighting: 'isotropic', 'heterogeneous', 'homogeneous', 'point-symmetric'
WEIGHTING=heterogeneous
# datatype: 'double' or 'float'
DATATYPE=double

# load modules (this is an example for the RRZE testcluster)
module load likwid/4.3.3 intel64/19.0up02 python/3.6-anaconda

STEMPEL_BINARY=~/.local/bin/stempel
KERNCRAFT_BINARY=~/.local/bin/kerncraft

INSPECT_DIR=~/INSPECT
OUTPUT_DIR=${INSPECT_DIR}/stencils

# turn specific parts on or off
DO_GRID_SCALING=1
DO_THREAD_SCALING=1
DO_SPACIAL_BLOCKING=1

# machine files
# MACHINE_FILE=${INSPECT_DIR}/machine_files/BroadwellEP_E5-2697_CoD.yml
# MACHINE_FILE=${INSPECT_DIR}/machine_files/HaswellEP_E5-2695v3_CoD.yml
# MACHINE_FILE=${INSPECT_DIR}/machine_files/SkylakeSP_Gold-6148.yml
# MACHINE_FILE=${INSPECT_DIR}/machine_files/SkylakeSP_Gold-6148_512.yml
MACHINE_FILE=${INSPECT_DIR}/machine_files/SkylakeSP_Gold-6148_SNC.yml

# needed for spatial blocking: counters for BroadEP2, HasEP1 and SkylakeSP1
COUNTER="CAS_COUNT_RD:MBOX4C1,CAS_COUNT_RD:MBOX6C0,CAS_COUNT_RD:MBOX2C1,CAS_COUNT_RD:MBOX3C0,CAS_COUNT_WR:MBOX0C1,CAS_COUNT_RD:MBOX5C1,L1D_REPLACEMENT:PMC0,CAS_COUNT_WR:MBOX5C0,CAS_COUNT_RD:MBOX0C0,CAS_COUNT_WR:MBOX6C1,L1D_M_EVICT:PMC2,CAS_COUNT_RD:MBOX7C1,CAS_COUNT_RD:MBOX1C1,CAS_COUNT_WR:MBOX4C0,CAS_COUNT_WR:MBOX2C0,CAS_COUNT_WR:MBOX1C0,CAS_COUNT_WR:MBOX3C1,CAS_COUNT_WR:MBOX7C0,L2_LINES_IN_ALL:PMC3,L2_TRANS_L2_WB:PMC1"

# needed for spatial blocking: counters for IvyBridge
#COUNTER="L1D_REPLACEMENT:PMC0,L2_LINES_OUT_DIRTY_ALL:PMC1,L1D_M_EVICT:PMC2,L2_LINES_IN_ALL:PMC3,CAS_COUNT_RD:MBOX4C1,CAS_COUNT_RD:MBOX6C0,CAS_COUNT_RD:MBOX2C1,CAS_COUNT_RD:MBOX3C0,CAS_COUNT_WR:MBOX0C1,CAS_COUNT_RD:MBOX5C1,CAS_COUNT_WR:MBOX5C0,CAS_COUNT_RD:MBOX0C0,CAS_COUNT_WR:MBOX6C1,CAS_COUNT_RD:MBOX7C1,CAS_COUNT_RD:MBOX1C1,CAS_COUNT_WR:MBOX4C0,CAS_COUNT_WR:MBOX2C0,CAS_COUNT_WR:MBOX1C0,CAS_COUNT_WR:MBOX3C1,CAS_COUNT_WR:MBOX7C0"

# **************************************************************************************************
# **************************************************************************************************
# ********** DONT CHANGE ANYTHING AFTER THIS LINE **************************************************
# **************************************************************************************************
# **************************************************************************************************

# FIX frequencies
ghz=$(grep clock ${MACHINE_FILE} | sed -e 's/clock: //' -e 's/ GHz//')
likwid-setFrequencies -t 0 -f ${ghz} --umin ${ghz} --umax ${ghz}

MACHINE=$(echo ${MACHINE_FILE} | sed -e 's/.*\///g' -e 's/.yml//')

ICC_VERSION=$(icc --version | head -n 1)

for fDIM in ${DIM}; do
for fRADIUS in ${RADIUS}; do
for fKIND in ${KIND}; do
for fCONST in ${CONST}; do
for fWEIGHTING in ${WEIGHTING}; do
for fDATATYPE in ${DATATYPE}; do

	DATE=$(date +'%Y%m%d_%H%M%S')
	FOLDER="${OUTPUT_DIR}/${fDIM}D_r${fRADIUS}_${fWEIGHTING}_${fKIND}_${fCONST}/${MACHINE}_${DATE}"
	mkdir -p ${FOLDER} && cd ${FOLDER}
	mkdir data

	echo ":: RUNNING: ${fDIM}D r${fRADIUS} ${fKIND} ${fCONST} ${fWEIGHTING} ${DATE} ${MACHINE}"

	echo ":: GATHERING SYSTEM INFORMATION"
	sh ${INSPECT_DIR}/scripts/Artifact-description/machine-state.sh >> data/system_info.txt

	if [[ ${fWEIGHTING} == "isotropic" ]]; then
		S_WEIGHTING=-i
	elif [[ ${fWEIGHTING} == "heterogeneous" ]]; then
		S_WEIGHTING=-e
	elif [[ ${fWEIGHTING} == "homogeneous" ]]; then
		S_WEIGHTING=-o
	elif [[ ${fWEIGHTING} == "point-symmetric" ]]; then
		S_WEIGHTING=-p
	fi

	COMPILER=$(cat ${MACHINE_FILE} | grep icc | sed 's/.*icc: /icc /')
	STEMPEL_ARGS="gen -D ${fDIM} -r ${fRADIUS} -k ${fKIND} -C ${fCONST} ${S_WEIGHTING} -t ${fDATATYPE}"
	# save all arguments
	echo ":: SAVING ARGUMENTS"
	echo {\$,$}STEMPEL_ARGS >> args.txt
	echo {\$,$}STEMPEL_BENCH_BLOCKING >> args.txt
	echo {\$,$}MACHINE_FILE >> args.txt
	echo {\$,$}DATE >> args.txt
	echo {\$,$}ICC_VERSION >> args.txt
	echo {\$,$}COMPILER >> args.txt

	# generate stencil
	echo ":: GENERATING STENCIL"
	${STEMPEL_BINARY} ${STEMPEL_ARGS} --store stencil.c

	# ************************************************************************************************
	# Grid Scaling
	# ************************************************************************************************

	# Layer Condition Analysis
	${KERNCRAFT_BINARY} -p LC -m ${MACHINE_FILE} ./stencil.c -D N 100 -D M 100 -D P 100 -vvv --cores 1 --compiler icc --ignore-warnings > data/LC.txt

	# L3 3D Layer Condition
	LC_3D_L3=$(cat data/LC.txt | grep L3: | tail -n 1 | sed -e 's/.*: //' -e 's/<=/-/')
	LC_3D_L3_N=$(python -c "import sympy;N=sympy.Symbol('N',positive=True);print(int(max(sympy.solvers.solve($(echo ${LC_3D_L3} | sed 's/[A-Z]/N/g'), N))*1.5/10)*10)")
	LC_3D_L3_N_orig=${LC_3D_L3_N}

	# L3 3D Layer Condition
	LC_3D_L2=$(cat data/LC.txt | grep L2: | tail -n 1 | sed -e 's/.*: //' -e 's/<=/-/')

	echo ":: L3 3D Layer Condition * 1.5 = ${LC_3D_L3_N} (${LC_3D_L3})"

	# get memory size per NUMA domain and adjust iteration size
	MEM_PER_NUMA=$(likwid-topology | grep "Total memory" | head -n 1 | sed 's/.*://g; s/\..*MB//g;' | tr -d '[:space:]')

	if [[ ${fDATATYPE} == "float" ]]; then
		DT_SIZE=4
	elif [[ ${fDATATYPE} == "double" ]]; then
		DT_SIZE=8
	fi

	TMP_FACTOR=2
	if [[ ${fCONST} == "variable" ]]; then
		TMP_FACTOR=$(grep "W" stencil.c | head -n 1 | sed 's/\].*//; s/.*\[//')
	fi

	while [[ $((${LC_3D_L3_N}*${LC_3D_L3_N}*${LC_3D_L3_N}*${TMP_FACTOR}*${DT_SIZE}/1024/1024)) -gt ${MEM_PER_NUMA} ]]; do
		LC_3D_L3_N=$((${LC_3D_L3_N}-10))
	done

	if [[ $(( ${LC_3D_L3_N} * 10 )) -lt $(( ${LC_3D_L3_N_orig} * 15 )) ]]; then
		echo ":: ADJUSTED ITERATION SIZE DUE TO MEMORY REQUIREMENTS TO ${LC_3D_L3_N}^3"
	fi

	echo {\$,$}LC_3D_L3 >> args.txt
	echo {\$,$}LC_3D_L3_N >> args.txt
	echo {\$,$}LC_3D_L2 >> args.txt
	echo {\$,$}MEM_PER_NUMA >> args.txt

	if [[ ${DO_GRID_SCALING} == 1 ]]; then
		mkdir data/singlecore

		for (( size=10; size<=${LC_3D_L3_N}+10; size=size+10)); do
			echo -ne "\033[0K\r:: RUNNIG SINGLE CORE BENCHMARK N=${size}"
			KERNCRAFT_ARGS="-m ${MACHINE_FILE} ./stencil.c -D N ${size} -D M ${size} -D P ${size} -vvv --cores 1 --compiler icc --ignore-warnings"
			for cache_predictor in LC SIM; do
				${KERNCRAFT_BINARY} -p RooflineIACA -P ${cache_predictor} ${KERNCRAFT_ARGS} > data/singlecore/Roofline_${cache_predictor}_${size}.txt
				${KERNCRAFT_BINARY} -p ECM -P ${cache_predictor} ${KERNCRAFT_ARGS} > data/singlecore/ECM_${cache_predictor}_${size}.txt
			done
			${KERNCRAFT_BINARY} -p Benchmark -P LC ${KERNCRAFT_ARGS} > data/singlecore/Bench_${size}.txt
		done

		echo
	fi

	# ************************************************************************************************
	# Threads Scaling
	# ************************************************************************************************

	if [[ ${DO_THREAD_SCALING} == 1 ]]; then
		cores=$(cat ${MACHINE_FILE} | grep "cores per socket" | sed 's/.*: //')

		mkdir data/scaling

		for (( threads = 1; threads <= ${cores}; threads++ )); do
			echo -ne "\033[0K\r:: RUNNIG THREAD SCALING BENCHMARK N=${LC_3D_L3_N} threads=${threads}"

			KERNCRAFT_ARGS="-m ${MACHINE_FILE} ./stencil.c -D N ${LC_3D_L3_N} -D M ${LC_3D_L3_N} -D P ${LC_3D_L3_N} -vvv --cores ${threads} --compiler icc --ignore-warnings"
			for pmodel in RooflineIACA ECM Benchmark; do
				${KERNCRAFT_BINARY} -p ${pmodel} -P LC ${KERNCRAFT_ARGS} >> data/scaling/${pmodel}_${LC_3D_L3_N}_${threads}.txt
			done
		done

		echo
	fi

	# ************************************************************************************************
	# Cache Blocking
	# ************************************************************************************************

	if [[ ${DO_SPACIAL_BLOCKING} == 1 ]]; then
		export OMP_NUM_THREADS=1

		echo ":: GENERATING BENCHMARK CODE WITH BLOCKING"
		${STEMPEL_BINARY} bench stencil.c -m ${MACHINE_FILE} -b 2 --store
		sed -i 's/#pragma/\/\/#pragma/g' kernel.c
		sed -i 's/#pragma/\/\/#pragma/g' stencil_compilable.c

		# compile args
		STEMPEL_DIR=$(python -c 'import stempel; print(stempel.__file__)' | sed 's/__init__.py//')/headers
		COMPILE_ARGS="-qopenmp -DLIKWID_PERFMON $LIKWID_INC $LIKWID_LIB -I${STEMPEL_DIR}/ \
			${STEMPEL_DIR}/timing.c ${STEMPEL_DIR}/dummy.c stencil_compilable.c -o stencil -llikwid"

		echo {\$,$}STEMPEL_DIR >> args.txt
		echo {\$,$}COMPILE_ARGS >> args.txt

		# compile
		echo ":: COMPILING"
		${COMPILER} ${COMPILE_ARGS}
		mv stencil stencil_blocking

		mkdir data/blocking

		# run spatial blocking benchmark
		for blocking_case in L2 L3; do

			mkdir data/blocking/${blocking_case}_3D

			for (( size=10; size<=${LC_3D_L3_N}+10; size=size+10)); do

				if [[ ${blocking_case} == "L2" ]]; then
					# blocking factor  x direction 100 or size_x if it is smaller
					PB=$(python -c "import sympy;P=sympy.Symbol('P',positive=True);print(int(max(sympy.solvers.solve($(echo ${LC_3D_L2} | sed 's/N/16/g'), P))/10)*10)")
					PB=$(( ${PB} > ${size} ? ${size} : ${PB} ))

					# y direction: LC
					TMP=$(echo ${LC_3D_L2} | sed "s/P/${PB}/g")
					NB=$(python -c "import sympy;N=sympy.Symbol('N',positive=True);print(int(max(sympy.solvers.solve(${TMP}, N))*0.75))")
				elif [[ ${blocking_case} == "L3" ]]; then
					# blocking factor  x direction 100 or size_x if it is smaller
					PB=$(python -c "import sympy;P=sympy.Symbol('P',positive=True);print(int(max(sympy.solvers.solve($(echo ${LC_3D_L3} | sed 's/N/16/g'), P))/10)*10)")
					PB=$(( ${PB} > ${size} ? ${size} : ${PB} ))

					# y direction: LC
					TMP=$(echo ${LC_3D_L3} | sed "s/P/${PB}/g")
					NB=$(python -c "import sympy;N=sympy.Symbol('N',positive=True);print(int(max(sympy.solvers.solve(${TMP}, N))*0.75))")
				fi

				# blocking factor z direction, fixed factor: 16
				MB=16

				STEMPEL_BENCH_BLOCKING_value="${MB} ${NB} ${PB}"
				args="${size} ${size} ${size} ${STEMPEL_BENCH_BLOCKING_value}"
				echo ${blocking_case} ${args} >> args.txt

				echo -ne "\033[0K\r:: RUNNIG BENCHMARK ${blocking_case}-3D N=${args}"

				likwid-perfctr -f -o data/blocking/${blocking_case}_3D/likwid_${size}.txt -g ${COUNTER} -C S0:0 -m ./stencil_blocking ${args} >> data/blocking/${blocking_case}_3D/likwid_${size}_out.txt
			done
			echo
		done
	fi

	# ************************************************************************************************
	# Postprocessing
	# ************************************************************************************************

	echo ":: POSTPROCESSING DATA"
	sh ${INSPECT_DIR}/scripts/postprocess.sh ${INSPECT_DIR}/stencils

done
done
done
done
done
done
