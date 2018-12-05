#! /bin/bash -l

# dependencies
# - python + python-sympy
# - grep, sed, awk, bc

# variables
MACHINE_FILE=$(grep MACHINE_FILE args.txt | sed 's/.* //')

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
DATATYPE=$(grep STEMPEL_ARGS args.txt | sed 's/.*-t //; s/ .*//')

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

echo ":: PROCESSING ${DIM}D r${RADIUS} ${KIND} ${CONST} ${WEIGHTING} ${DATATYPE} ${MACHINE}"

# L3 3D Layer Condition
LC_3D_L3=$(cat data/LC.txt | grep L3: | tail -n 1 | sed 's/.*: //; s/<=/-/')
LC_3D_L3_N=$(python -c "import sympy;N=sympy.Symbol('N',positive=True);print(sympy.solvers.solve($(echo ${LC_3D_L3} | sed 's/[A-Z]/N/g'), N))" | sed 's/\[//; s/\]//')
LC_3D_L3_N=$(bc -l <<< "scale=0;1.5*(${LC_3D_L3_N})")
LC_3D_L3_N=$(bc -l <<< "scale=0;${LC_3D_L3_N}-${LC_3D_L3_N}%10+10")
LC_3D_L3_N=$(echo ${LC_3D_L3_N} | sed 's/\..*//')

# ************************************************************************************************
# Generate index.md
# ************************************************************************************************

echo ":: GENERATING index.md"

FILENAME=index.md

echo "---" > ${FILENAME}
echo "" >> ${FILENAME}
echo "title:  \"Stencil ${DIM}D r${RADIUS} ${KIND} ${CONST} ${WEIGHTING} ${DATATYPE} ${MACHINE}\"" >> ${FILENAME}
echo "" >> ${FILENAME}
echo "dimension    : \"${DIM}D\"" >> ${FILENAME}
echo "radius       : \"${RADIUS}r\"" >> ${FILENAME}
echo "weighting    : \"${WEIGHTING}\"" >> ${FILENAME}
echo "kind         : \"${KIND}\"" >> ${FILENAME}
echo "coefficients : \"${CONST}\"" >> ${FILENAME}
echo "datatype     : \"${DATATYPE}\"" >> ${FILENAME}
echo "machine      : \"${MACHINE}\"" >> ${FILENAME}
echo "flavor       : \"EDIT_ME\"" >> ${FILENAME}
echo "comment      : \"EDIT_ME\"" >> ${FILENAME}
echo "compile_flags: \"$(cat args.txt | grep COMPILER | sed 's/\$COMPILER //') $(cat args.txt | grep COMPILE_ARGS | sed 's/\$COMPILE_ARGS //; s/\/home.*stempel\///g; s/\/mnt\/opt\///g')\"" >> ${FILENAME}
echo "flop         : \"$(grep -A 8 FLOPs data/LC.txt | grep -A 1 == | tail -n 1 | sed 's/ //g')\"" >> ${FILENAME}
echo "scaling      : [ \"${LC_3D_L3_N}\" ]" >> ${FILENAME}
echo "blocking     : [ \"L3-3D\" ]" >> ${FILENAME}
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
echo "{%- capture source_code_asm -%}" >> ${FILENAME}
START=$(cat data/singlecore/ECM_LC_10.txt | grep -n "X - instruction" | sed 's/:.*//')
END=$(cat data/singlecore/ECM_LC_10.txt | grep -n "Total Num Of Uops:" | sed 's/:.*//')
cat data/singlecore/ECM_LC_10.txt | head -n $((${END}-1)) | tail -n $((${END} - ${START} - 5)) | sed 's/|.*| //g' >> ${FILENAME}
echo "{%- endcapture -%}" >> ${FILENAME}
echo "" >> ${FILENAME}
echo "{%- capture layercondition -%}" >> ${FILENAME}
while read -r line; do
	if [[ $(echo ${line} | grep -c unconditionally) -eq 1 ]]; then
		echo ${line} >> ${FILENAME}
	elif [[ $(echo ${line} | grep -c "*") -eq 0 ]]; then
		equation=$(echo ${line} | sed s'/.*: //; s/<=/-/; s/[A-Z]/N/g' )
		APPROX=$(python -c "import sympy;N=sympy.Symbol('N',positive=True);print(sympy.solvers.solve(${equation}, N))" | sed 's/\[//; s/\]//')
		APPROX=$(bc -l <<< "scale=0;${APPROX}/10*10")
		echo ${line}";"$(echo ${line}|sed 's/.*: //; s/ .*//')" ~ "${APPROX} >> ${FILENAME}
	else
		equation=$(echo ${line} | sed s'/.*: //; s/<=/-/; s/[A-Z]/N/g' )
		APPROX=$(python -c "import sympy;N=sympy.Symbol('N',positive=True);print(sympy.solvers.solve(${equation}, N))" | sed 's/\[//; s/\]//')
		APPROX=$(bc -l <<< "scale=0;${APPROX}/10*10")
		echo ${line}";"$(echo ${line}|sed 's/.*: //; s/ .*//; s/[0-9]*\*//')" ~ "${APPROX}$"²" >> ${FILENAME}
	fi
done <<< $(tail -n 12 data/LC.txt | head -n 11 | sed '/layer condition/d')
echo "{%- endcapture -%}" >> ${FILENAME}
echo "" >> ${FILENAME}
echo "{% include stencil_template.md %}" >> ${FILENAME}

# ************************************************************************************************
# Grid Scaling
# ************************************************************************************************

echo ":: GENERATING results.csv"

FILENAME=results.csv

# write header
echo ",Roofline,,,,,,,,ECM,,,,,,,,,,,,,Data Transfer (Benchmark),,,,,,,,,Data Transfer (Prediction CS),,,,,,,,,Data Transfer (Prediction CS),,,,,,,,," > ${FILENAME}
echo ",Cache Simulator,,,Layer Conditions,,,ECM,Benchmark,Cache Simulator,,,,,,Layer Condition,,,,,,Benchmark,L1-L2 (B/LUP),,,L2-L3 (B/LUP),,,L3-MEM (B/LUP),,,L1-L2 (B/LUP),,,L2-L3 (B/LUP),,,L3-MEM (B/LUP),,,L1-L2 (B/LUP),,,L2-L3 (B/LUP),,,L3-MEM (B/LUP),,," >> ${FILENAME}
echo "N(^3),GFLOP/s,MLUP/s,Arithmetic Intensity,GFLOP/s,MLUP/s,Arithmetic Intensity,MLUP/s,MLUP/s,T_OL,T_nOL,T_L1L2,T_L2L3,T_L3MEM,cy/CL,T_OL,T_nOL,T_L1L2,T_L2L3,T_L3MEM,cy/CL,cy/CL,load,evict,total,load,evict,total,load,evict,total,load,evict,total,load,evict,total,load,evict,total,load,evict,total,load,evict,total,load,evict,total" >> ${FILENAME}

for (( size=10; size<=${LC_3D_L3_N}+10; size=size+10)); do
	flops=$(cat stencil.flop | sed 's/.* //g')

	ecm=",,,,"
	ecm_cy=""
	gflops=""
	mflops=""
	intensity=""

	ECM_CS_L1evict=""
	ECM_CS_L1load=""
	ECM_CS_L1total=""
	ECM_CS_L2evict=""
	ECM_CS_L2load=""
	ECM_CS_L2total=""
	ECM_CS_L3evict=""
	ECM_CS_L3load=""
	ECM_CS_L3total=""

	if [ -f data/singlecore/ECM_SIM_${size}.txt ]; then
		if [ $(grep -c "} cy/CL" data/singlecore/ECM_SIM_${size}.txt) -gt 0 ]; then
			ecm_cy=$(grep "} cy/CL" data/singlecore/ECM_SIM_${size}.txt | awk 'NR%2==0' | sed -e 's/}.*//' -e 's/.*\\ //')
			ecm=$(grep "} cy/CL" data/singlecore/ECM_SIM_${size}.txt | awk 'NR%2==1' | sed -e 's/{ //g' -e 's/ } cy\/CL//g' -e 's/ [|]* /,/g')
		fi

		if [ $(grep -c "Data Transfers:" data/singlecore/ECM_SIM_${size}.txt) -gt 0 ]; then
			L1=$(grep "L1-L2" data/singlecore/ECM_SIM_${size}.txt)
			ECM_CS_L1evict=$(echo ${L1} | sed -e 's/.*B\/CL | //' -e 's/ B\/CL |//')
			ECM_CS_L1evict=$(bc -l <<< "scale=2;${ECM_CS_L1evict} / 8")
			ECM_CS_L1load=$(echo ${L1} | sed -e 's/.*L2 | //' -e 's/ B.*//')
			ECM_CS_L1load=$(bc -l <<< "scale=2;${ECM_CS_L1load} / 8")
			ECM_CS_L1total=$(bc -l <<< "scale=2;${ECM_CS_L1load} + ${ECM_CS_L1evict}")

			L2=$(grep "L2-L3" data/singlecore/ECM_SIM_${size}.txt)
			ECM_CS_L2evict=$(echo ${L2} | sed -e 's/.*B\/CL | //' -e 's/ B\/CL |//')
			ECM_CS_L2evict=$(bc -l <<< "scale=2;${ECM_CS_L2evict} / 8")
			ECM_CS_L2load=$(echo ${L2} | sed -e 's/.*L3 | //' -e 's/ B.*//')
			ECM_CS_L2load=$(bc -l <<< "scale=2;${ECM_CS_L2load} / 8")
			ECM_CS_L2total=$(bc -l <<< "scale=2;${ECM_CS_L2load} + ${ECM_CS_L2evict}")

			L3=$(grep "L3-MEM" data/singlecore/ECM_SIM_${size}.txt)
			ECM_CS_L3evict=$(echo ${L3} | sed -e 's/.*B\/CL | //' -e 's/ B\/CL |//')
			ECM_CS_L3evict=$(bc -l <<< "scale=2;${ECM_CS_L3evict} / 8")
			ECM_CS_L3load=$(echo ${L3} | sed -e 's/.*MEM | //' -e 's/ B.*//')
			ECM_CS_L3load=$(bc -l <<< "scale=2;${ECM_CS_L3load} / 8")
			ECM_CS_L3total=$(bc -l <<< "scale=2;${ECM_CS_L3load} + ${ECM_CS_L3evict}")
		fi
	fi

	if [ -f data/singlecore/Roofline_SIM_${size}.txt ]; then
		if [ $(grep -c "GFLOP/s d" data/singlecore/Roofline_SIM_${size}.txt) -gt 0 ]; then
			gflops=$(grep "GFLOP/s d" data/singlecore/Roofline_SIM_${size}.txt | sed -e 's/ GFLOP.*//' -e 's/CPU bound. //')
			mflops=$(bc -l <<< "scale=2;${gflops} * 1000 / ${flops}")
			intensity=$(grep Arithmetic  data/singlecore/Roofline_SIM_${size}.txt | sed -e 's/Arithmetic Intensity: //' -e 's/ FLOP\/B//')
		fi
	fi

	ecm_LC=",,,,"
	ecm_cy_LC=""
	gflops_LC=""
	mflops_LC=""
	intensity_LC=""

	ECM_LC_L1evict=""
	ECM_LC_L1load=""
	ECM_LC_L1total=""
	ECM_LC_L2evict=""
	ECM_LC_L2load=""
	ECM_LC_L2total=""
	ECM_LC_L3evict=""
	ECM_LC_L3load=""
	ECM_LC_L3total=""

	if [ -f data/singlecore/ECM_LC_${size}.txt ]; then
		if [ $(cat data/singlecore/ECM_LC_${size}.txt | tail | grep -s -c "} cy/CL") -gt 0 ]; then
			ecm_cy_LC=$(cat data/singlecore/ECM_LC_${size}.txt | tail | grep "} cy/CL" | awk 'NR%2==0' | sed -e 's/}.*//' -e 's/.*\\ //')
			ecm_LC=$(cat data/singlecore/ECM_LC_${size}.txt | tail | grep "} cy/CL" | awk 'NR%2==1' | sed -e 's/{ //g' -e 's/ } cy\/CL//g' -e 's/ [|]* /,/g')
		fi

		if [ $(grep -c "Data Transfers:" data/singlecore/ECM_LC_${size}.txt) -gt 0 ]; then
			L1=$(grep "L1-L2" data/singlecore/ECM_LC_${size}.txt)
			ECM_LC_L1evict=$(echo ${L1} | sed -e 's/.*B\/CL | //' -e 's/ B\/CL |//')
			ECM_LC_L1evict=$(bc -l <<< "scale=2;${ECM_LC_L1evict} / 8")
			ECM_LC_L1load=$(echo ${L1} | sed -e 's/.*L2 | //' -e 's/ B.*//')
			ECM_LC_L1load=$(bc -l <<< "scale=2;${ECM_LC_L1load} / 8")
			ECM_LC_L1total=$(bc -l <<< "scale=2;${ECM_LC_L1load} + ${ECM_LC_L1evict}")

			L2=$(grep "L2-L3" data/singlecore/ECM_LC_${size}.txt)
			ECM_LC_L2evict=$(echo ${L2} | sed -e 's/.*B\/CL | //' -e 's/ B\/CL |//')
			ECM_LC_L2evict=$(bc -l <<< "scale=2;${ECM_LC_L2evict} / 8")
			ECM_LC_L2load=$(echo ${L2} | sed -e 's/.*L3 | //' -e 's/ B.*//')
			ECM_LC_L2load=$(bc -l <<< "scale=2;${ECM_LC_L2load} / 8")
			ECM_LC_L2total=$(bc -l <<< "scale=2;${ECM_LC_L2load} + ${ECM_LC_L2evict}")

			L3=$(grep "L3-MEM" data/singlecore/ECM_LC_${size}.txt)
			ECM_LC_L3evict=$(echo ${L3} | sed -e 's/.*B\/CL | //' -e 's/ B\/CL |//')
			ECM_LC_L3evict=$(bc -l <<< "scale=2;${ECM_LC_L3evict} / 8")
			ECM_LC_L3load=$(echo ${L3} | sed -e 's/.*MEM | //' -e 's/ B.*//')
			ECM_LC_L3load=$(bc -l <<< "scale=2;${ECM_LC_L3load} / 8")
			ECM_LC_L3total=$(bc -l <<< "scale=2;${ECM_LC_L3load} + ${ECM_LC_L3evict}")
		fi
	fi

	if [ -f data/singlecore/Roofline_LC_${size}.txt ]; then
		if [ $(grep -c "GFLOP/s d" data/singlecore/Roofline_LC_${size}.txt) -gt 0 ]; then
			gflops_LC=$(grep "GFLOP/s d" data/singlecore/Roofline_LC_${size}.txt | sed -e 's/ GFLOP.*//' -e 's/CPU bound. //')
			mflops_LC=$(bc -l <<< "scale=2;${gflops_LC} * 1000 / ${flops}")
			intensity_LC=$(grep Arithmetic  data/singlecore/Roofline_LC_${size}.txt | sed -e 's/Arithmetic Intensity: //' -e 's/ FLOP\/B//')
		fi
	fi

	ecm_mlup=""
	bench_cy=""
	bench_mlup=""
	L1evict=""
	L1load=""
	L1total=""
	L2evict=""
	L2load=""
	L2total=""
	L3evict=""
	L3load=""
	L3total=""

	if [ -f data/singlecore/Bench_${size}.txt ]; then
		bench_cy=$(cat data/singlecore/Bench_${size}.txt | grep 'Runtime (per cacheline update):' | sed -e 's/.*: //' -e 's/ cy\/CL//')
		bench_mlup=$(cat data/singlecore/Bench_${size}.txt | grep " MLUP" | sed -e 's/Performance: //' -e 's/ MLUP\/s//')

		ecm_mlup=$(grep "Clock" data/singlecore/Bench_${size}.txt | sed -e 's/.*: //g' -e 's/\..*//g')
		ecm_mlup=$(bc -l <<< "scale=2;(8 * ${ecm_mlup} / ${ecm_cy_LC})")

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

	echo ${size}","${gflops}","${mflops}","${intensity}","${gflops_LC}","${mflops_LC}","${intensity_LC}","${ecm_mlup}","${bench_mlup}","${ecm}","${ecm_cy}","${ecm_LC}","${ecm_cy_LC}","${bench_cy}","${L1load}","${L1evict}","${L1total}","${L2load}","${L2evict}","${L2total}","${L3load}","${L3evict}","${L3total}","${ECM_CS_L1load}","${ECM_CS_L1evict}","${ECM_CS_L1total}","${ECM_CS_L2load}","${ECM_CS_L2evict}","${ECM_CS_L2total}","${ECM_CS_L3load}","${ECM_CS_L3evict}","${ECM_CS_L3total}","${ECM_LC_L1load}","${ECM_LC_L1evict}","${ECM_LC_L1total}","${ECM_LC_L2load}","${ECM_LC_L2evict}","${ECM_LC_L2total}","${ECM_LC_L3load}","${ECM_LC_L3evict}","${ECM_LC_L3total} >> ${FILENAME}
done

# ************************************************************************************************
# Threads Scaling
# ************************************************************************************************
echo ":: GENERATING scaling.csv"

FILENAME=scaling.csv
cores=$(cat ${MACHINE_FILE} | grep "cores per socket" | sed 's/.*: //')

# write results file header
echo "N,threads,iterations,time,blocking factor,flop,lup,Gflop/s,Gflop/s (Roofline),Mlup/s,Mlup/s (Roofline),cy/CL,cy/CL (ECM),MLUP/s (ECM),l1-l2 miss,l1-l2 evict,l2-l3 miss,l2-l3 evict,l3-mem miss,l3-mem evict,l1-l2 total,l2-l3 total,l3-mem total" > ${FILENAME}

for (( threads = 1; threads <= ${cores}; threads++ )); do

	OMP_NUM_THREADS=${threads}

	#save results/metrics
	iterations=$(head -n 1 data/scaling/likwid_${LC_3D_L3_N}_${threads}_out.txt | grep "iterations:" | sed 's/iterations: //')
	time=$(grep "time:" data/scaling/likwid_${LC_3D_L3_N}_${threads}_out.txt | sed 's/time: //')
	flop=$(grep "Total work" data/scaling/likwid_${LC_3D_L3_N}_${threads}_out.txt | sed 's/ FLOP//; s/Total work: //')
	lup=$(grep "Total iterations: " data/scaling/likwid_${LC_3D_L3_N}_${threads}_out.txt | sed 's/Total iterations: //; s/ LUP//')

	if [ $threads -eq 1 ]; then
		L1D_M_EVICT=$(grep L1D_M_EVICT data/scaling/likwid_${LC_3D_L3_N}_${threads}.txt | sed 's/|[ ]*L1D_M_EVICT[ ]*|[ ]*PMC[0123][ ]*|[ ]*//; s/ |//')
		L1D_REPLACEMENT=$(grep L1D_REPLACEMENT data/scaling/likwid_${LC_3D_L3_N}_${threads}.txt | sed 's/|[ ]*L1D_REPLACEMENT[ ]*|[ ]*PMC[0123][ ]*|[ ]*//; s/ |//')

		L2_LINES_IN_ALL=$(grep L2_LINES_IN_ALL data/scaling/likwid_${LC_3D_L3_N}_${threads}.txt | sed 's/|[ ]*L2_LINES_IN_ALL[ ]*|[ ]*PMC[0123][ ]*|[ ]*//; s/ |//')
		L2_TRANS_L2_WB=$(grep L2_TRANS_L2_WB data/scaling/likwid_${LC_3D_L3_N}_${threads}.txt | sed 's/|[ ]*L2_TRANS_L2_WB[ ]*|[ ]*PMC[0123][ ]*|[ ]*//; s/ |//')

		CAS_COUNT_RD=$(var=$(grep CAS_COUNT_RD data/scaling/likwid_${LC_3D_L3_N}_${threads}.txt | sed 's/|[ ]*CAS_COUNT_RD[ ]*|[ ]*MBOX[01234567]C[01][ ]*|[ ]*//; s/[ ]*|/+/; s/-/0/' | tr -d '\n') && echo ${var::-1})
		CAS_COUNT_WR=$(var=$(grep CAS_COUNT_WR data/scaling/likwid_${LC_3D_L3_N}_${threads}.txt | sed 's/|[ ]*CAS_COUNT_WR[ ]*|[ ]*MBOX[01234567]C[01][ ]*|[ ]*//; s/[ ]*|/+/; s/-/0/' | tr -d '\n') && echo ${var::-1})
	else
		L1D_M_EVICT=$(grep 'L1D_M_EVICT STAT' data/scaling/likwid_${LC_3D_L3_N}_${threads}.txt | sed -e 's/|[ ]*L1D_M_EVICT STAT[ ]*|[ ]*PMC[0123][ ]*|[ ]*//' -e 's/ |.*//')
		L1D_REPLACEMENT=$(grep 'L1D_REPLACEMENT STAT' data/scaling/likwid_${LC_3D_L3_N}_${threads}.txt | sed -e 's/|[ ]*L1D_REPLACEMENT STAT[ ]*|[ ]*PMC[0123][ ]*|[ ]*//'  -e 's/ |.*//')

		L2_LINES_IN_ALL=$(grep 'L2_LINES_IN_ALL STAT' data/scaling/likwid_${LC_3D_L3_N}_${threads}.txt | sed -e 's/|[ ]*L2_LINES_IN_ALL STAT[ ]*|[ ]*PMC[0123][ ]*|[ ]*//' -e 's/ |.*//')
		L2_TRANS_L2_WB=$(grep 'L2_TRANS_L2_WB STAT' data/scaling/likwid_${LC_3D_L3_N}_${threads}.txt | sed -e 's/|[ ]*L2_TRANS_L2_WB STAT[ ]*|[ ]*PMC[0123][ ]*|[ ]*//' -e 's/ |.*//')

		CAS_COUNT_RD=$(var=$(grep 'CAS_COUNT_RD STAT' data/scaling/likwid_${LC_3D_L3_N}_${threads}.txt | sed -e 's/|[ ]*CAS_COUNT_RD STAT[ ]*|[ ]*MBOX[01234567]C[01][ ]*|[ ]*//' -e 's/[ ]*|[ ]*/+/g' -e 's/-/0/' -e 's/e+/*10^/g' | tr -d '\n') && echo ${var::-1})
		CAS_COUNT_WR=$(var=$(grep 'CAS_COUNT_WR STAT' data/scaling/likwid_${LC_3D_L3_N}_${threads}.txt | sed -e 's/|[ ]*CAS_COUNT_WR STAT[ ]*|[ ]*MBOX[01234567]C[01][ ]*|[ ]*//' -e 's/[ ]*|[ ]*/+/g' -e 's/-/0/' -e 's/e+/*10^/g' | tr -d '\n') && echo ${var::-1})
	fi

	l2_load=$(bc -l <<< "scale=2;${L1D_REPLACEMENT} * 64 / ( ${iterations} * ( ${LC_3D_L3_N} - 2 )^3 )")
	l2_evict=$(bc -l <<< "scale=2;${L1D_M_EVICT} * 64 / ( ${iterations} * ( ${LC_3D_L3_N} - 2 )^3 )")

	l3_load=$(bc -l <<< "scale=2;${L2_LINES_IN_ALL} * 64 / ( ${iterations} * ( ${LC_3D_L3_N} - 2 )^3 )")
	l3_evict=$(bc -l <<< "scale=2;${L2_TRANS_L2_WB} * 64 / ( ${iterations} * ( ${LC_3D_L3_N} - 2 )^3 )")

	mem_read=$(bc -l <<< "scale=2;${CAS_COUNT_RD} * 64 / ( ${iterations} * ( ${LC_3D_L3_N} - 2 )^3 )")
	mem_write=$(bc -l <<< "scale=2;${CAS_COUNT_WR} * 64 / ( ${iterations} * ( ${LC_3D_L3_N} - 2 )^3 )")

	gflops=$(bc -l <<< "scale=2;${flop} / 10^9 / ${time}")
	mlups=$(bc -l <<< "scale=2;${lup} / 10^6 / ${time}")
	cyCL=$(bc -l <<< "scale=2;${ghz} / ( ${lup} / 10^9 / ${time} ) * 8")

	gflopsIACA=$(cat data/scaling/RooflineIACA_${LC_3D_L3_N}_${threads}.txt | grep GFLOP | tail -n 1 | sed 's/ GFLOP.*//')
	mlupsIACA=$(bc -l <<< "scale=2;${gflopsIACA} * 10^3 / $(cat ./stencil.flop | sed 's/FLOP: //')")

	cyclECM=$(cat data/scaling/ECM_${LC_3D_L3_N}_${threads}.txt | tail -n 3 | grep cy/CL | sed -e 's/ cy\/CL (.*//' -e 's/} cy\/CL//' | awk '{print $NF}')
	mlupsECM=$(bc -l <<< "scale=2;8 * ${ghz} * 10^3 / ${cyclECM}")

	echo "${LC_3D_L3_N},${threads},${iterations},${time},${STEMPEL_BENCH_BLOCKING_value},${flop},${lup},${gflops},${gflopsIACA},${mlups},${mlupsIACA},${cyCL},${cyclECM},${mlupsECM},${l2_load},${l2_evict},${l3_load},${l3_evict},${mem_read},${mem_write}" >> ${FILENAME}
done

# ************************************************************************************************
# Cache Blocking
# ************************************************************************************************

echo ":: GENERATING blocking.csv"

FILENAME=blocking_L3-3D.csv

# write results file header
echo "N,iterations,time,blocking options,flop,lup,Gflop/s,Mlup/s,cy/CL,l1-l2 miss,l1-l2 evict,l2-l3 miss,l2-l3 evict,l3-mem miss,l3-mem evict,l1-l2 total,l2-l3 total,l3-mem total" > ${FILENAME}

# run benchmark
for (( size=10; size<=${LC_3D_L3_N}+10; size=size+10)); do

	# blocking factor  x direction 100 or size_x if it is smaller
	PB=$(python -c "import sympy;P=sympy.Symbol('P',positive=True);print(sympy.solvers.solve($(echo ${LC_3D_L3} | sed 's/N/16/g'), P))" | sed 's/\[//; s/\]//')
	PB=$(bc -l <<< "scale=0;1.5*(${PB})/10*10")
	PB=$(( ${PB} > ${size} ? ${size} : ${PB} ))

	# y direction: LC
	TMP=$(echo ${LC_3D_L3} | sed "s/P/${PB}/g")
	NB=$(bc -l <<< "scale=0;$(python -c "import sympy;N=sympy.Symbol('N',positive=True);print(sympy.solvers.solve(${TMP}, N))" | sed 's/\[//; s/\]//')")

	# blocking factor z direction, fixed factor: 16
	MB=16

	STEMPEL_BENCH_BLOCKING_value="${MB} ${NB} ${PB}"
	args="${size} ${size} ${size} ${STEMPEL_BENCH_BLOCKING_value}"

	#save results/metrics
	iterations=$(head -n 1 data/blocking/likwid_${size}_out.txt | grep "iterations:" | sed 's/iterations: //')
	time=$(grep "time:" data/blocking/likwid_${size}_out.txt | sed 's/time: //')
	flop=$(grep "Total work" data/blocking/likwid_${size}_out.txt | sed 's/ FLOP//; s/Total work: //')
	lup=$(grep "Total iterations: " data/blocking/likwid_${size}_out.txt | sed 's/Total iterations: //; s/ LUP//')
	ghz=$(grep clock ${MACHINE_FILE} | sed 's/clock: //; s/ GHz//')

	L1D_M_EVICT=$(grep L1D_M_EVICT data/blocking/likwid_${size}.txt | sed 's/|[ ]*L1D_M_EVICT[ ]*|[ ]*PMC[0123][ ]*|[ ]*//; s/ |//')
	L1D_REPLACEMENT=$(grep L1D_REPLACEMENT data/blocking/likwid_${size}.txt | sed 's/|[ ]*L1D_REPLACEMENT[ ]*|[ ]*PMC[0123][ ]*|[ ]*//; s/ |//')

	L2_LINES_IN_ALL=$(grep L2_LINES_IN_ALL data/blocking/likwid_${size}.txt | sed 's/|[ ]*L2_LINES_IN_ALL[ ]*|[ ]*PMC[0123][ ]*|[ ]*//; s/ |//')
	L2_TRANS_L2_WB=$(grep L2_TRANS_L2_WB data/blocking/likwid_${size}.txt | sed 's/|[ ]*L2_TRANS_L2_WB[ ]*|[ ]*PMC[0123][ ]*|[ ]*//; s/ |//')

	CAS_COUNT_RD=$(var=$(grep CAS_COUNT_RD data/blocking/likwid_${size}.txt | sed 's/|[ ]*CAS_COUNT_RD[ ]*|[ ]*MBOX[01234567]C[01][ ]*|[ ]*//; s/[ ]*|/+/; s/-/0/' | tr -d '\n') && echo ${var::-1})
	CAS_COUNT_WR=$(var=$(grep CAS_COUNT_WR data/blocking/likwid_${size}.txt | sed 's/|[ ]*CAS_COUNT_WR[ ]*|[ ]*MBOX[01234567]C[01][ ]*|[ ]*//; s/[ ]*|/+/; s/-/0/' | tr -d '\n') && echo ${var::-1})

	l2_load=$(bc -l <<< "scale=2;${L1D_REPLACEMENT} * 64 / ( ${iterations} * ( ${size} - 2 )^3 )")
	l2_evict=$(bc -l <<< "scale=2;${L1D_M_EVICT} * 64 / ( ${iterations} * ( ${size} - 2 )^3 )")
	l2_total=$(bc -l <<< "scale=2;${l2_load}+${l2_evict}")

	l3_load=$(bc -l <<< "scale=2;${L2_LINES_IN_ALL} * 64 / ( ${iterations} * ( ${size} - 2 )^3 )")
	l3_evict=$(bc -l <<< "scale=2;${L2_TRANS_L2_WB} * 64 / ( ${iterations} * ( ${size} - 2 )^3 )")
	l3_total=$(bc -l <<< "scale=2;${l3_load}+${l3_evict}")

	mem_read=$(bc -l <<< "scale=2;${CAS_COUNT_RD} * 64 / ( ${iterations} * ( ${size} - 2 )^3 )")
	mem_write=$(bc -l <<< "scale=2;${CAS_COUNT_WR} * 64 / ( ${iterations} * ( ${size} - 2 )^3 )")
	mem_total=$(bc -l <<< "scale=2;${mem_read}+${mem_write}")

	gflops=$(bc -l <<< "scale=2;${flop} / 10^9 / ${time}")
	mlups=$(bc -l <<< "scale=2;${lup} / 10^6 / ${time}")
	cyCL=$(bc -l <<< "scale=2;${ghz} / ( ${lup} / 10^9 / ${time} ) * 8")

	echo "${size},${iterations},${time},${STEMPEL_BENCH_BLOCKING_value},${flop},${lup},${gflops},${mlups},${cyCL},${l2_load},${l2_evict},${l3_load},${l3_evict},${mem_read},${mem_write},${l2_total},${l3_total},${mem_total}" >> ${FILENAME}
done

# ************************************************************************************************
# generate plots
# ************************************************************************************************

echo ":: GENERATING PLOTS"
gnuplot $(echo $(dirname $(realpath $0))"/plots.gnuplot")

# ************************************************************************************************
# compress data files
# ************************************************************************************************

tar czf data.tar.gz data && rm -rf data
