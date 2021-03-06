#! /bin/bash -l

# dependencies
# - python + python-sympy
# - grep, sed, awk, bc

if [ -z $1 ]; then
	OUTPUT_FOLDER=~/INSPECT/collection/
else
	OUTPUT_FOLDER=$1
fi

if [[ ! -d  data ]]; then
	tar xzf data.tar.gz
fi

function get_LUPperCL {
	LUPperCL=1
	if [[ $1 == "float" ]]; then
		LUPperCL=16
	elif [[ $1 == "double" ]]; then
		LUPperCL=8
	elif [[ $1 == "float _Complex" ]]; then
		LUPperCL=8
	elif [[ $1 == "double _Complex" ]]; then
		LUPperCL=4
	fi
	echo ${LUPperCL}
}

function get_Kerncraft_ECM {

	# LC or SIM
	CASE=$1

	ecm=",,,,"
	cycl=""
	mlup=""

	if [ ${CASE} == "Bench" ]; then
		if [ -f data/singlecore/${CASE}_${size}.txt ]; then
			ecm=$(grep Pheno data/singlecore/${CASE}_${size}.txt | sed 's/.*: //;s/{ //g;s/ } cy\/CL//g;s/ [|]* /,/g')
			if [ ${#ecm} -lt 2 ]; then
				ecm=",,,,"
			fi
			cycl=$(cat data/singlecore/${CASE}_${size}.txt | grep 'Runtime (per cacheline update):' | sed -e 's/.*: //' -e 's/ cy\/CL//')
			mlup=$(cat data/singlecore/${CASE}_${size}.txt | grep " MLUP" | sed -e 's/Performance: //' -e 's/ MLUP\/s//')
		fi
	else
		if [ -f data/singlecore/ECM_${CASE}_${size}.txt ]; then
			if [ $(grep -c ") cy/CL" data/singlecore/ECM_${CASE}_${size}.txt) -gt 0 ]; then
				ecm=$(cat data/singlecore/ECM_${CASE}_${size}.txt | grep -E "[0-9][)]?[)] cy/CL"| sed -e 's/max(//;s/sum(//;s/.*= //;s/).*//;s/ //g')
				cycl=$(grep " cy/CL" data/singlecore/ECM_${CASE}_${size}.txt | grep = | tail -n 1 | sed -e 's/.*= //;s/ cy\/CL//')
				mlup=$(bc -l <<< "scale=2;(${LUPperCL} * ${ghz} * 1000 / ${cycl})")
			fi
		fi
	fi

	echo ${ecm}","${cycl}","${mlup}
}

function get_Kerncraft_DATATRANSFERS {

	# LC or SIM
	CASE=$1

	L1evict=""
	L1load=""
	L1total=""
	L2evict=""
	L2load=""
	L2total=""
	L3evict=""
	L3load=""
	L3total=""

	if [ ${CASE} == "Bench" ]; then
		if [ -f data/singlecore/${CASE}_${size}.txt ]; then
			L1=$(cat data/singlecore/Bench_${size}.txt | tail -n 8 | head -n 5 | grep "L1    |" | sed 's/.*L1.*| //')
			L1evict=$(echo ${L1} | sed -e 's/.*LOAD\/CL[ ]*//' -e  's/ CL\/CL.*//')
			L1evict=$(bc -l <<< "scale=2;${L1evict} * 64 / 8")
			L1load=$(echo ${L1} | sed -e 's/.*LOAD\/CL[ ]*//' -e 's/[0-9. ]*CL\/CL[ ]*//' -e 's/[ ]CL\/CL//')
			L1load=$(bc -l <<< "scale=2;${L1load} * 64 / 8")
			L1total=$(bc -l <<< "scale=2;${L1load} + ${L1evict}")

			L2=$(cat data/singlecore/Bench_${size}.txt | tail -n 8 | head -n 5 | grep "L2    |" | sed 's/.*L2.*| //')
			L2evict=$(echo ${L2} | sed -e 's/[0-9. ]*CL\/CL[ ]*//' -e 's/ CL\/CL.*//')
			L2evict=$(bc -l <<< "scale=2;${L2evict} * 64 / 8")
			L2load=$(echo ${L2} | sed -e 's/[0-9. ]*CL\/CL[ ]*//' -e 's/[0-9. ]*CL\/CL[ ]*//' -e 's/ CL\/CL//')
			L2load=$(bc -l <<< "scale=2;${L2load} * 64 / 8")
			L2total=$(bc -l <<< "scale=2;${L2load} + ${L2evict}")

			L3=$(cat data/singlecore/Bench_${size}.txt | tail -n 8 | head -n 5 | grep "L3    |" | sed 's/.*L3.*| //')
			L3evict=$(echo ${L3} | sed -e 's/[0-9. ]*CL\/CL[ ]*//' -e 's/ CL\/CL.*//')
			L3evict=$(bc -l <<< "scale=2;${L3evict} * 64 / 8")
			L3load=$(echo ${L3} | sed -e 's/[0-9. ]*CL\/CL[ ]*//' -e 's/[0-9. ]*CL\/CL[ ]*//' -e 's/ CL\/CL//')
			L3load=$(bc -l <<< "scale=2;${L3load} * 64 / 8")
			L3total=$(bc -l <<< "scale=2;${L3load} + ${L3evict}")
		fi
	else
		if [ -f data/singlecore/ECM_${CASE}_${size}.txt ]; then
			if [ $(grep -c "Data Transfers:" data/singlecore/ECM_${CASE}_${size}.txt) -gt 0 ]; then
				L1=$(grep "L1-L2" data/singlecore/ECM_${CASE}_${size}.txt)
				L1evict=$(echo ${L1} | sed -e 's/.*B\/CL | //' -e 's/ B\/CL |//')
				L1evict=$(bc -l <<< "scale=2;${L1evict} / 8")
				L1load=$(echo ${L1} | sed -e 's/.*L2 | //' -e 's/ B.*//')
				L1load=$(bc -l <<< "scale=2;${L1load} / 8")
				L1total=$(bc -l <<< "scale=2;${L1load} + ${L1evict}")

				L2=$(grep "L2-L3" data/singlecore/ECM_${CASE}_${size}.txt)
				L2evict=$(echo ${L2} | sed -e 's/.*B\/CL | //' -e 's/ B\/CL |//')
				L2evict=$(bc -l <<< "scale=2;${L2evict} / 8")
				L2load=$(echo ${L2} | sed -e 's/.*L3 | //' -e 's/ B.*//')
				L2load=$(bc -l <<< "scale=2;${L2load} / 8")
				L2total=$(bc -l <<< "scale=2;${L2load} + ${L2evict}")

				L3=$(grep "L3-MEM" data/singlecore/ECM_${CASE}_${size}.txt)
				L3evict=$(echo ${L3} | sed -e 's/.*B\/CL | //' -e 's/ B\/CL |//')
				L3evict=$(bc -l <<< "scale=2;${L3evict} / 8")
				L3load=$(echo ${L3} | sed -e 's/.*MEM | //' -e 's/ B.*//')
				L3load=$(bc -l <<< "scale=2;${L3load} / 8")
				L3total=$(bc -l <<< "scale=2;${L3load} + ${L3evict}")
			fi
		fi
	fi

	echo ${L1load}","${L1evict}","${L1total}","${L2load}","${L2evict}","${L2total}","${L3load}","${L3evict}","${L3total}
}

function get_Kerncraft_Roofline {

	# LC or SIM
	CASE=$1

	gflops=""
	mlups=""
	rfl_cycl=""
	intensity=""

	if [ -f data/singlecore/Roofline_${CASE}_${size}.txt ]; then
		if [ $(grep -c "FLOP/s d" data/singlecore/Roofline_${CASE}_${size}.txt) -gt 0 ]; then
			gflops=$(grep "FLOP/s d" data/singlecore/Roofline_${CASE}_${size}.txt | sed -e 's/FLOP.*//;s/CPU bound. //;s/ M/\/1000/;s/ G//')
			gflops=$(bc -l <<< "scale=5;${gflops}" | sed -r 's/^(-?)\./\10./')
			mlups=$(bc -l <<< "scale=2;${gflops} * 1000 / ${flops}")
			rfl_cycl=$(cat data/singlecore/Roofline_${CASE}_${size}.txt | grep "'cy/CL')" | tail -n 2 | head -n 1 | sed 's/.*Unit(//;s/,.*//')
			intensity=$(grep Arithmetic  data/singlecore/Roofline_${CASE}_${size}.txt | sed -e 's/Arithmetic Intensity: //' -e 's/ FLOP\/B//')
			if [ ${#intensity} -lt 2 ]; then
				intensity=$(tail -n 2 data/singlecore/Roofline_${CASE}_${size}.txt | sed '/^\s*$/d;s/CPU bound.*/CPU bound/g')
			fi
		fi
	fi

	echo ${gflops}","${mlups}","${rfl_cycl}","${intensity}
}

# variables
MACHINE_FILE=$(grep MACHINE_FILE args.txt | sed 's/.* //')

if [ ! -f ${MACHINE_FILE} ]; then
  MACHINE_FILE=/usr/share/kerncraft-git/examples/machine-files/$(grep MACHINE_FILE args.txt | sed 's/.* //;s/.*\///g')
fi

# dimension: 2 or 3
DIM=$(grep STEMPEL_ARGS args.txt | sed 's/.*-D //; s/ .*//')
# desired stencil radius: 1,2,3,...
RADIUS=$(grep STEMPEL_ARGS args.txt | sed 's/.*-r //; s/ .*//')
# stencil kind: 'star' or 'box'
KIND=$(grep STEMPEL_ARGS args.txt | sed 's/.*-k //; s/ .*//')
# coefficients: 'constant' or 'variable'
CONST=$(grep STEMPEL_ARGS args.txt | sed 's/.*-C //; s/ .*//')
# weighting: 'isotropic', 'heterogeneous', 'homogeneous', 'point-symmetric'
WEIGHTING=replaceme
# datatype: 'double' or 'float'
DATATYPE=$(grep STEMPEL_ARGS args.txt | sed 's/.*-t \(.*\)/\1/;s/\"//g')
# stencil name (if specified)
if [ $(grep -c "STENCIL" args.txt) -gt 0 ]; then
	STENCIL_NAME=$(grep STENCIL args.txt | sed 's/\$STENCIL //')
else
	STENCIL_NAME="None"
fi

ghz=$(grep clock ${MACHINE_FILE} | sed 's/clock: //; s/ GHz//')
MACHINE=$(echo ${MACHINE_FILE} | sed 's/.*\///g; s/.yml//')

if [[ $(grep STEMPEL_ARGS args.txt | grep -c '\-i') -eq 1 ]]; then
	WEIGHTING=isotropic
elif [[ $(grep STEMPEL_ARGS args.txt | grep -c '\-e') -eq 1 ]]; then
	WEIGHTING=heterogeneous
elif [[ $(grep STEMPEL_ARGS args.txt | grep -c '\-o') -eq 1 ]]; then
	WEIGHTING=homogeneous
elif [[ $(grep STEMPEL_ARGS args.txt | grep -c '\-p') -eq 1 ]]; then
	WEIGHTING=point-symmetric
fi

LUPperCL=$(get_LUPperCL ${DATATYPE})

if [[ ${STENCIL_NAME} != "None" ]]; then
	echo ":: PROCESSING ${STENCIL_NAME}"
else
	echo ":: PROCESSING ${DIM}D r${RADIUS} ${KIND} ${CONST} ${WEIGHTING} ${DATATYPE} ${MACHINE}"
fi

mkdir -p ${OUTPUT_FOLDER}

# L3 3D Layer Condition
LC_1D_L3_N=$(cat args.txt | grep LC_1D_L3_N | sed 's/.* //')

# ************************************************************************************************
# Generate index.md
# ************************************************************************************************

echo ":: GENERATING index.md"

FILENAME=index.md

echo "---" > ${FILENAME}
echo "" >> ${FILENAME}
if [[ ${STENCIL_NAME} != "None" ]]; then
	echo "title:  \"Stencil ${STENCIL_NAME}\"" >> ${FILENAME}
else
	echo "title:  \"Stencil ${DIM}D r${RADIUS} ${KIND} ${CONST} ${WEIGHTING} ${DATATYPE} ${MACHINE}\"" >> ${FILENAME}
fi
echo "" >> ${FILENAME}
if [[ ${STENCIL_NAME} != "None" ]]; then
	echo "stencil_name     : \"${STENCIL_NAME}\"" >> ${FILENAME}
else
	echo "dimension    : \"${DIM}D\"" >> ${FILENAME}
	echo "radius       : \"r${RADIUS}\"" >> ${FILENAME}
	echo "weighting    : \"${WEIGHTING}\"" >> ${FILENAME}
	echo "kind         : \"${KIND}\"" >> ${FILENAME}
	echo "coefficients : \"${CONST}\"" >> ${FILENAME}
	echo "datatype     : \"${DATATYPE}\"" >> ${FILENAME}
fi
echo "machine      : \"${MACHINE}\"" >> ${FILENAME}
echo "flavor       : \"EDIT_ME\"" >> ${FILENAME}
echo "compile_flags: \"$(cat args.txt | grep COMPILER | sed 's/\$COMPILER //') $(cat args.txt | grep COMPILE_ARGS | sed 's/\$COMPILE_ARGS //; s/\/home.*stempel\///g; s/\/mnt\/opt\///g')\"" >> ${FILENAME}
echo "flop         : \"$(grep -A 8 FLOPs data/LC.txt | grep -A 1 == | tail -n 1 | sed 's/ //g')\"" >> ${FILENAME}
echo "scaling      : [ \"${LC_1D_L3_N}\" ]" >> ${FILENAME}
if [[ $(ls *csv | grep blocking) ]]; then
	blk=$(for file in blocking_*csv; do echo \"$file\", | sed 's/blocking_//;s/\.csv//'; done | tr -d "\n")
	echo "blocking     : [ ${blk::-1} ]" >> ${FILENAME}
else
	echo "blocking     : []" >> ${FILENAME}
fi
echo "---" >> ${FILENAME}
echo "" >> ${FILENAME}
echo "{%- capture basename -%}" >> ${FILENAME}
echo "{{page.dimension}}-{{page.radius}}-{{page.weighting}}-{{page.kind}}-{{page.coefficients}}-{{page.datatype}}-{{page.machine}}" >> ${FILENAME}
echo "{%- endcapture -%}" >> ${FILENAME}
echo "" >> ${FILENAME}
echo "{%- capture source_code -%}" >> ${FILENAME}
if [ $(command -v clang-format) ]; then
clang-format -style="{BasedOnStyle: llvm, IndentWidth: 2, BreakBeforeBinaryOperators: None, ColumnLimit: 70, AlignOperands: true}" stencil.c >> ${FILENAME}
else
cat stencil.c >> ${FILENAME}
fi
echo "{%- endcapture -%}" >> ${FILENAME}
echo "" >> ${FILENAME}
echo "{%- capture source_code_asm -%}" >> ${FILENAME}
START=$(cat data/singlecore/ECM_LC_10.txt | grep -n "X - instruction" | sed 's/:.*//')
END=$(cat data/singlecore/ECM_LC_10.txt | grep -n "Total Num Of Uops:" | sed 's/:.*//')
cat data/singlecore/ECM_LC_10.txt | head -n $((${END}-1)) | tail -n $((${END} - ${START} - 5)) | sed 's/|.*| //g' >> ${FILENAME}
echo "{%- endcapture -%}" >> ${FILENAME}
echo "" >> ${FILENAME}
echo "{%- capture layer_condition -%}" >> ${FILENAME}
tail -n $(( $(cat data/LC.txt | wc -l) - $(grep -m 1 -n "Layer condition" data/LC.txt | sed 's/:.*//') +1 )) data/LC.txt | sed 's/^[ \t]\{2,\}/|/g;s/[[:space:]]\{2,\}/|/g;s/\([a-z0-9]\)$/\1|/g' | sed 's/hits|/hits|\n|:---:|---:|---:|/;s/Layer/### Layer/;s/|condition/\n|condition/' | sed 's/\([<|<=]\) \([0-9]*\)|/\1 \2```|/;s/|\([0-9A-Z\*\+ -]*\) </|```\1 </' | sed 's/True/Else/' >> ${FILENAME}
echo "{%- endcapture -%}" >> ${FILENAME}
echo "" >> ${FILENAME}
echo "{%- capture iaca -%}" >> ${FILENAME}
START=$(cat data/singlecore/ECM_LC_10.txt | grep -n "IACA Output:" | sed 's/:.*//')
END=$(cat data/singlecore/ECM_LC_10.txt | grep -n "Total Num Of Uops:" | sed 's/:.*//')
if [ ${#END} -lt 2 ]; then
	END=$(cat data/singlecore/ECM_LC_10.txt | grep -n "Total number of" | sed 's/:.*//')
fi
cat data/singlecore/ECM_LC_10.txt | head -n $((${END}+3)) | tail -n $((${END} - ${START}-2)) >> ${FILENAME}
echo "{%- endcapture -%}" >> ${FILENAME}
echo "" >> ${FILENAME}
echo "{%- capture hostinfo -%}" >> ${FILENAME}
cat data/system_info.txt >> ${FILENAME}
echo "{%- endcapture -%}" >> ${FILENAME}
echo "" >> ${FILENAME}
echo "{% include stencil_template.md %}" >> ${FILENAME}

# ************************************************************************************************
# Grid Scaling
# ************************************************************************************************

echo ":: GENERATING results.csv"

FILENAME=results.csv

# write header
RESULTS_HEADER="N^3,Roofline CS GFLOPs,Roofline CS MLUPs,Roofline CS cycl,Roofline CS Arithmetic Intensity,Roofline LC GFLOPs,Roofline LC MLUPs,Roofline LC cycl,Roofline LC Arithmetic Intensity,Benchmark Pheno Tol,Benchmark Pheno Tnol,Benchmark Pheno Tl1l2,Benchmark Pheno Tl2l3,Benchmark Pheno Tl3mem,Benchmark cycl,Benchmark MLUPs,ECM CS Tol,ECM CS Tnol,ECM CS Tl1l2,ECM CS Tl2l3,ECM CS Tl3mem,ECM CS cycl,ECM CS MLUPs,ECM LC Tol,ECM LC Tnol,ECM LC Tl1l2,ECM LC Tl2l3,ECM LC Tl3mem,ECM LC cycl,ECM LC MLUPs,Benchmark Transfer L1L2 load,Benchmark Transfer L1L2 evict,Benchmark Transfer L1L2 total,Benchmark Transfer L2L3 load,Benchmark Transfer L2L3 evict,Benchmark Transfer L2L3 total,Benchmark Transfer L3MEM load,Benchmark Transfer L3MEM evict,Benchmark Transfer L3MEM total,CS Transfer L1L2 load,CS Transfer L1L2 evict,CS Transfer L1L2 total,CS Transfer L2L3 load,CS Transfer L2L3 evict,CS Transfer L2L3 total,CS Transfer L3MEM load,CS Transfer L3MEM evict,CS Transfer L3MEM total,LC Transfer L1L2 load,LC Transfer L1L2 evict,LC Transfer L1L2 total,LC Transfer L2L3 load,LC Transfer L2L3 evict,LC Transfer L2L3 total,LC Transfer L3MEM load,LC Transfer L3MEM evict,LC Transfer L3MEM total"
echo ${RESULTS_HEADER} > ${FILENAME}

if [ -f stencil.flop ]; then
	flops=$(cat stencil.flop | sed 's/.* //g')
else
	# make MLUPs calculations almost zero, to show, that we dont know the correct flops count
	flops=10^9
fi

for (( size=10; size<=${LC_1D_L3_N}+10; size=size+10)); do
	ECM_SIM=$(get_Kerncraft_ECM "SIM")
	TRANSFERS_SIM=$(get_Kerncraft_DATATRANSFERS "SIM")
	ROOFLINE_SIM=$(get_Kerncraft_Roofline "SIM")

	ECM_LC=$(get_Kerncraft_ECM "LC")
	TRANSFERS_LC=$(get_Kerncraft_DATATRANSFERS "LC")
	ROOFLINE_LC=$(get_Kerncraft_Roofline "LC")

	BENCH=$(get_Kerncraft_ECM "Bench")
	BENCH_TRANSFERS=$(get_Kerncraft_DATATRANSFERS "Bench")

	echo ${size}","${ROOFLINE_SIM}","${ROOFLINE_LC}","${BENCH}","${ECM_SIM}","${ECM_LC}","${BENCH_TRANSFERS}","${TRANSFERS_SIM}","${TRANSFERS_LC} >> ${FILENAME}
done

# ************************************************************************************************
# Threads Scaling
# ************************************************************************************************
if [ -d "data/scaling" ]; then
	echo ":: GENERATING scaling.csv"

	FILENAME=scaling.csv
	cores=$(cat ${MACHINE_FILE} | grep "cores per socket" | sed 's/.*: //')

	# write results file header
	echo "N,threads,iterations,time,blocking factor,flop,lup,Gflop/s,Gflop/s (Roofline),Mlup/s,Mlup/s (Roofline),cy/CL,cy/CL (ECM),MLUP/s (ECM),l1-l2 miss,l1-l2 evict,l2-l3 miss,l2-l3 evict,l3-mem miss,l3-mem evict,l1-l2 total,l2-l3 total,l3-mem total" > ${FILENAME}

	for (( threads = 1; threads <= ${cores}; threads++ )); do

		OMP_NUM_THREADS=${threads}

		l2_load=0
		l2_evict=0
		l3_load=0
		l3_evict=0
		mem_read=0
		mem_write=0

		iterations=$(grep perfctr data/scaling/Benchmark_${LC_1D_L3_N}_${threads}.txt | tail -n 1 | sed 's/.*[a-zA-Z] \([0-9]\)/\1/;s/\..*//')
		time=$(grep "Runtime (RDTSC) \[s\]'" data/scaling/Benchmark_${LC_1D_L3_N}_${threads}.txt | sed 's/.*Runtime.*: //; s/,//')

		gflops=$(bc -l <<< "scale=2;$(grep " [MG]FLOP" data/scaling/Benchmark_${LC_1D_L3_N}_${threads}.txt | sed 's/Performance.*: //; s/FLOP.*//; s/ M/*10^6/; s/ G/*10^9/')/10^9")
		mlups=$(grep " MLUP" data/scaling/Benchmark_${LC_1D_L3_N}_${threads}.txt | sed -e 's/Performance: //; s/ MLUP\/s//')
		cyCL=$(grep "Runtime.* cy/CL" data/scaling/Benchmark_${LC_1D_L3_N}_${threads}.txt | sed 's/Runtime.*: //; s/ cy.*//')

		flop=$(bc -l <<< "scale=0;${gflops}*${time}*10^9")
		lup=$(bc -l <<< "scale=0;${mlups}*${time}*10^6")

		gflopsIACA=$(cat data/scaling/RooflineIACA_${LC_1D_L3_N}_${threads}.txt | grep FLOP/s | tail -n 1 | sed 's/ [M|G]FLOP.*//; s/CPU bound. //')
		gflopsIACA=$(grep "FLOP/s d" data/scaling/RooflineIACA_${LC_1D_L3_N}_${threads}.txt | sed -e 's/FLOP.*//;s/CPU bound. //;s/ M/\/1000/;s/ G//')
		gflopsIACA=$(bc -l <<< "scale=5;${gflopsIACA}" | sed -r 's/^(-?)\./\10./')
		mlupsIACA=$(bc -l <<< "scale=2;${gflopsIACA} * 10^3 / ${flops}")

		cyclECM=$(cat data/scaling/ECM_${LC_1D_L3_N}_${threads}.txt | tail -n 20 | grep "prediction for" | sed -e 's/ cy\/CL (.*//' -e 's/} cy\/CL//' | awk '{print $NF}')
		mlupsECM=$(bc -l <<< "scale=2;${LUPperCL} * ${ghz} * 10^3 / ${cyclECM}")

		echo "${LC_1D_L3_N},${threads},${iterations},${time},,${flop},${lup},${gflops},${gflopsIACA},${mlups},${mlupsIACA},${cyCL},${cyclECM},${mlupsECM},${l2_load},${l2_evict},${l3_load},${l3_evict},${mem_read},${mem_write}" >> ${FILENAME}
	done
fi

# ************************************************************************************************
# Cache Blocking
# ************************************************************************************************

if [ -d "data/blocking" ]; then
echo ":: GENERATING blocking.csv"

	# run spatial blocking benchmark
	for blocking_case in L2 L3; do
		FILENAME=blocking_${blocking_case}-3D.csv

		# write results file header
		echo "N,iterations,time,blocking options,flop,lup,Gflop/s,Mlup/s,cy/CL,l1-l2 miss,l1-l2 evict,l2-l3 miss,l2-l3 evict,l3-mem miss,l3-mem evict,l1-l2 total,l2-l3 total,l3-mem total" > ${FILENAME}

		for (( size=10; size<=${LC_1D_L3_N}+10; size=size+10)); do
			args=$(grep "${blocking_case} ${size} ${size} ${size}" args.txt)

			#save results/metrics
			iterations=$(head -n 1 data/blocking/${blocking_case}_3D/likwid_${size}_out.txt | grep "iterations:" | sed 's/iterations: //')
			time=$(grep "time:" data/blocking/${blocking_case}_3D/likwid_${size}_out.txt | sed 's/time: //')
			flop=$(grep "Total work" data/blocking/${blocking_case}_3D/likwid_${size}_out.txt | sed 's/ FLOP//; s/Total work: //')
			lup=$(grep "Total iterations: " data/blocking/${blocking_case}_3D/likwid_${size}_out.txt | sed 's/Total iterations: //; s/ LUP//')
			ghz=$(grep clock ${MACHINE_FILE} | sed 's/clock: //; s/ GHz//')

			if [ -f data/blocking/${blocking_case}_3D/likwid_${size}.txt ]; then
				L1D_M_EVICT=$(grep L1D_M_EVICT data/blocking/${blocking_case}_3D/likwid_${size}.txt | sed 's/|[ ]*L1D_M_EVICT[ ]*|[ ]*PMC[0123][ ]*|[ ]*//; s/ |//')
				L1D_REPLACEMENT=$(grep L1D_REPLACEMENT data/blocking/${blocking_case}_3D/likwid_${size}.txt | sed 's/|[ ]*L1D_REPLACEMENT[ ]*|[ ]*PMC[0123][ ]*|[ ]*//; s/ |//')

				L2_LINES_IN_ALL=$(grep L2_LINES_IN_ALL data/blocking/${blocking_case}_3D/likwid_${size}.txt | sed 's/|[ ]*L2_LINES_IN_ALL[ ]*|[ ]*PMC[0123][ ]*|[ ]*//; s/ |//')
				L2_TRANS_L2_WB=$(grep L2_TRANS_L2_WB data/blocking/${blocking_case}_3D/likwid_${size}.txt | sed 's/|[ ]*L2_TRANS_L2_WB[ ]*|[ ]*PMC[0123][ ]*|[ ]*//; s/ |//')

				CAS_COUNT_RD=$(var=$(grep CAS_COUNT_RD data/blocking/${blocking_case}_3D/likwid_${size}.txt | sed 's/|[ ]*CAS_COUNT_RD[ ]*|[ ]*MBOX[01234567]C[01][ ]*|[ ]*//; s/[ ]*|/+/; s/-/0/' | tr -d '\n') && echo ${var::-1})
				CAS_COUNT_WR=$(var=$(grep CAS_COUNT_WR data/blocking/${blocking_case}_3D/likwid_${size}.txt | sed 's/|[ ]*CAS_COUNT_WR[ ]*|[ ]*MBOX[01234567]C[01][ ]*|[ ]*//; s/[ ]*|/+/; s/-/0/' | tr -d '\n') && echo ${var::-1})

				l2_load=$(bc -l <<< "scale=2;${L1D_REPLACEMENT} * 64 / ( ${iterations} * ( ${size} - 2 )^3 )")
				l2_evict=$(bc -l <<< "scale=2;${L1D_M_EVICT} * 64 / ( ${iterations} * ( ${size} - 2 )^3 )")
				l2_total=$(bc -l <<< "scale=2;${l2_load}+${l2_evict}")

				l3_load=$(bc -l <<< "scale=2;${L2_LINES_IN_ALL} * 64 / ( ${iterations} * ( ${size} - 2 )^3 )")
				l3_evict=$(bc -l <<< "scale=2;${L2_TRANS_L2_WB} * 64 / ( ${iterations} * ( ${size} - 2 )^3 )")
				l3_total=$(bc -l <<< "scale=2;${l3_load}+${l3_evict}")

				mem_read=$(bc -l <<< "scale=2;${CAS_COUNT_RD} * 64 / ( ${iterations} * ( ${size} - 2 )^3 )")
				mem_write=$(bc -l <<< "scale=2;${CAS_COUNT_WR} * 64 / ( ${iterations} * ( ${size} - 2 )^3 )")
				mem_total=$(bc -l <<< "scale=2;${mem_read}+${mem_write}")
			else
				l2_load=0
				l2_evict=0
				l2_total=0
				l3_load=0
				l3_evict=0
				l3_total=0
				mem_read=0
				mem_write=0
				mem_total=0
			fi

			gflops=$(bc -l <<< "scale=2;${flop} / 10^9 / ${time}")
			mlups=$(bc -l <<< "scale=2;${lup} / 10^6 / ${time}")
			cyCL=$(bc -l <<< "scale=2;${ghz} / ( ${lup} / 10^9 / ${time} ) * ${LUPperCL}")

			echo "${size},${iterations},${time},${args},${flop},${lup},${gflops},${mlups},${cyCL},${l2_load},${l2_evict},${l3_load},${l3_evict},${mem_read},${mem_write},${l2_total},${l3_total},${mem_total}" >> ${FILENAME}
		done
	done
fi

# ************************************************************************************************
# copy results for stencil data collection
# ************************************************************************************************

DT=$(echo ${DATATYPE} | sed 's/ //')

if [[ ${STENCIL_NAME} != "None" ]]; then
	FOLDER="${OUTPUT_FOLDER}/${STENCIL_NAME}/${MACHINE}/"
else
	FOLDER="${OUTPUT_FOLDER}/${DIM}D/r${RADIUS}/${WEIGHTING}/${KIND}/${CONST}/${DT}/${MACHINE}/"
fi

mkdir -p ${FOLDER}
cp index.md *csv ${FOLDER}

# ************************************************************************************************
# compress data files
# ************************************************************************************************

if [[ -f  data.tar.gz ]]; then
	rm -rf data
else
	tar czf data.tar.gz data && rm -rf data
fi
