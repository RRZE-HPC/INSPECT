
JSDIR = "https://rrze-hpc.github.io/stempel_data_collection/assets/js/"

####################################################################################################
# Roofline LC+CS Plot
####################################################################################################

YMAX = `bc -l <<< "1.2 * $(awk -F"," '(NR>3){print $3}{print $6}{print $8}{print $9}' results.csv | sort -n | uniq | tail -n 1)"`

reset

set datafile separator ","
set xlabel "Grid Size (N^3)"
set ylabel "Performance [MLUP/s]"
set yrange [0:YMAX]
set xtics 100
set key top right width 5 samplen 2 font ",18"

set style line 1 lt 1 lc rgb '#0072bd' lw 2 pt 7 ps .5
set style line 2 lt 1 lc rgb '#edb120' lw 2 pt 5 ps 1
set style line 3 lt 1 lc rgb '#7e2f8e' lw 2 pt 11 ps 1
set style line 4 lt 1 lc rgb '#d95319' lw 2 pt 9 ps 1

set terminal svg enhanced mousing fname 'Open Sans' jsdir JSDIR
set output "roofline_LC.svg"

save_encoding = GPVAL_ENCODING
set encoding utf8

Info(T,SIZE,LUP) = sprintf("%s\nN³ = %d³\nMLUP/s: %d", T, column(SIZE), column(LUP))

set label at 0,0 "" hypertext point pt 1

do for [type=0:1] {
    if ( type == 0 ) {
        TYPE="LC"
        COL=6
        DESC="Layer Condition"
    } else {
        TYPE="CS"
        COL=3
        DESC="Cache Simulation"
    }

    outfile = 'roofline_' . TYPE . '.svg'
    set output outfile

    plot "< awk '(NR>2){print;}' results.csv" u 1:COL every 20:20 notitle w points ls 4, \
            "" u 1:COL notitle w lines ls 4, \
            "" u 1:COL:(Info(DESC,1,COL)) with labels hypertext point ls 4 pt 7 ps .33 notitle, \
            1 / 0 title sprintf("Roofline prediction from %s", DESC) w linespoints ls 4 ps 1, \
         "< awk '(NR>2){print;}' results.csv" u 1:8 every 20:20 notitle w points ls 2, \
            "" u 1:8 notitle w lines ls 2, \
            "" u 1:8:(Info("ECM",1,8)) with labels hypertext point ls 2 pt 7 ps .33 notitle, \
            1 / 0 title "Performance prediction from ECM" w linespoints ls 2 ps 1, \
         "" u 1:9:(Info("Measurement",1,9)) with labels hypertext point ls 1 title "Measurement"
}

####################################################################################################
# Memory Transfer Plot CS
####################################################################################################

YMAX = `bc -l <<< "1.2 * $(awk -F"," '(NR>3){print $25}{print $28}{print $31}{print $34}{print $37}{print $40}{print $43}{print $46}{print $49}' results.csv | sort -n | uniq | tail -n 1)"`

reset

set datafile separator ","
set xlabel "Grid Size (N^3)"
set ylabel "Data Transfers [B/LUP]"
set yrange [0:YMAX]
set xtics 100
set key bottom right width 5 samplen 2 font ",18"

set style line 1 lt 1 lc rgb '#0072bd' lw 2 pt 5 ps .5
set style line 2 lt 1 lc rgb '#edb120' lw 2 pt 7 ps .5
set style line 3 lt 1 lc rgb '#d95319' lw 2 pt 9 ps .5
set style line 4 lt 4 lc rgb '#0072bd' lw 2 pt 4 ps 1
set style line 5 lt 4 lc rgb '#edb120' lw 2 pt 6 ps 1
set style line 6 lt 4 lc rgb '#d95319' lw 2 pt 8 ps 1

set terminal svg enhanced mousing fname 'Open Sans' jsdir JSDIR
set output "memory_CS.svg"

save_encoding = GPVAL_ENCODING
set encoding utf8

Info(T,SIZE,BPL) = sprintf("%s Transfer\nN³ = %d³\nByte/LUP: %d", T, column(SIZE), column(BPL))

set label at 0,0 "" hypertext point pt 1

do for [type=0:1] {
    if ( type == 0 ) {
        TYPE="LC"
        COLA=43
        COLB=46
        COLC=49
    } else {
        TYPE="CS"
        COLA=34
        COLB=37
        COLC=40
    }

    outfile = 'memory_' . TYPE . '.svg'
    set output outfile

    plot "< awk '(NR>2){print;}' results.csv" u 1:COLA every 20:20 notitle w points ls 4, \
        "" u 1:COLA notitle w lines ls 4, \
        "" u 1:25:(Info("L1 - L2",1,25)) with labels hypertext point ls 1 ps .5 notitle, \
        1 / 0 title "L1 - L2 transfer" w linespoints ls 1 ps 1, \
     "" u 1:COLB every 20:20 notitle w points ls 5, \
         "" u 1:COLB notitle w lines ls 5, \
         "" u 1:28:(Info("L2 - L3",1,28)) with labels hypertext point ls 2 ps .5 notitle, \
         1 / 0 title "L2 - L3 transfer" w linespoints ls 2 ps 1, \
     "" u 1:COLC every 20:20 notitle w points ls 6, \
         "" u 1:COLC notitle w lines ls 6, \
         "" u 1:31:(Info("L3 - MEM",1,31)) with labels hypertext point ls 3 ps .5 notitle, \
         1 / 0 title "L3 - Mem transfer" w linespoints ls 3 ps 1
}

####################################################################################################
# ECM LC Plot
####################################################################################################

YMAX = `bc -l <<< "1.2 * $(awk -F"," '(NR>3){print $15}{print $21}{print $22}' results.csv | sort -n | uniq | tail -n 1)"`

do for [type=0:1] {
    if ( type == 0 ) {
        TYPE="LC"
        COLA=17
        COLB=18
        COLC=19
        COLD=20
    } else {
        TYPE="CS"
        COLA=11
        COLB=12
        COLC=13
        COLD=14
    }

    reset

    set style line 1 lt 1 lc rgb '#0072bd' lw 1 pt 7 ps .5
    set style line 2 lt 1 lc rgb '#d95319' lw 1 pt 2
    set style line 3 lt 1 lc rgb '#edb120' lw 1 pt 3
    set style line 4 lt 1 lc rgb '#7e2f8e' lw 1 pt 4
    set style line 5 lt 1 lc rgb '#77ac30' lw 1 pt 6
    set style line 6 lt 1 lc rgb '#4dbeee' lw 1 pt 8
    set style line 7 lt 1 lc rgb '#a2142f' lw 1 pt 10
    set style line 8 lt 1 lc rgb '#AE81FF' lw 1 pt 12
    set style line 9 lt 1 lc rgb '#4C4745' lw 1 pt 1
    set style line 10 lt 1 lc rgb '#000000' lw 1 pt 1

    set datafile separator ","
    set terminal svg enhanced mousing fname 'Open Sans' jsdir JSDIR
    outfile = 'ecm_' . TYPE . '.svg'
    set output outfile

    save_encoding = GPVAL_ENCODING
    set encoding utf8

    set multiplot

    set origin 0,0
    set size 1,1
    set yrange [0:YMAX]
    set style data histogram
    set style histogram rowstacked
    set xlabel "Grid Size (N^3)" textcolor "#ffffff"
    set ylabel "cy/CL" textcolor "#ffffff"
    set xtics textcolor "#ffffff"
    set ytics textcolor "#ffffff"
    set style fill solid border
    set key reverse outside top horizontal Left samplen 1
    set tics scale 0

    plot  "< awk '(NR>2){print;}' results.csv" u COLA:xticlabels(1) title 'T_{nOL}' ls 4, \
          "< awk '(NR>2){print;}' results.csv" u COLB:xticlabels(1) title 'T_{L1L2}' ls 7, \
          "< awk '(NR>2){print;}' results.csv" u COLC:xticlabels(1) title 'T_{L2L3}' ls 2, \
          "< awk '(NR>2){print;}' results.csv" u COLD:xticlabels(1) title 'T_{L3MEM}' ls 3

    set origin 0,0
    set size 1,1
    set yrange [0:YMAX]
    set xlabel "Grid Size (N^3)" textcolor "#000000"
    set ylabel "cy/CL" textcolor "#000000"
    set xtics 100 textcolor "#000000"
    set ytics textcolor "#000000"
    set key outside left top horizontal reverse width 1 samplen 1
    set tics scale 1

    Info(T,SIZE,CYCL) = sprintf("%s\nN³ = %d³\ncy/CL: %d", T, column(SIZE), column(CYCL))

    set label at 0,0 "" hypertext point pt 1

    plot "< awk '(NR>2){print;}' results.csv" u 1:22:(Info("ECM",1,22)) with labels hypertext point ls 1 title 'Measurement', \
         "< awk '(NR>2){print;}' results.csv" u 1:16 w lines title 'T_{OL}' ls 10

    # end of multiplot
    unset multiplot
}

####################################################################################################
# Thread Scaling Plots
####################################################################################################

YMAX = `bc -l <<< "1.2 * $(awk -F"," '(NR>1){print $10}' scaling.csv | sort -n | uniq | tail -n 1)"`

reset

set datafile separator ","
set xlabel "Number of Threads"
set ylabel "Performance [MLUP/s]"
set yrange [0:]
set key bottom right width 5 samplen 2 font ",18"

set style line 1 lt 1 lc rgb '#0072bd' lw 2 pt 7 ps .5
set style line 2 lt 1 lc rgb '#edb120' lw 2 pt 5 ps 1
set style line 3 lt 1 lc rgb '#7e2f8e' lw 2 pt 11 ps 1
set style line 4 lt 1 lc rgb '#d95319' lw 2 pt 9 ps 1

set terminal svg enhanced mousing fname 'Open Sans' jsdir JSDIR

save_encoding = GPVAL_ENCODING
set encoding utf8

set label at 0,0 "" hypertext point pt 1

Info(T,SIZE,MLUPS,THREADS) = sprintf("%s\nN³ = %d³\nMLUP/s: %d\nThreads: %d", T, column(SIZE), column(MLUPS), column(THREADS))

SCALINGS=`echo '"';awk -F"," '(NR>1){print $1}' scaling.csv | uniq | tr '\n' ' ';echo '"';`

do for [N in SCALINGS] {
    outfile = 'scaling_' . N . '.svg'
    set output outfile

    plot 'scaling.csv' u ($1 == N ? $2 : 1/0):11 w l ls 4 notitle, 1 / 0 w linespoints ls 4 ps 1 t "Roofline Prediction", \
         '' u ($1 == N ? $2 : 1/0):11:(Info("Roofline Prediction",1,11,2)) w labels hypertext point ls 4 notitle, \
         '' u ($1 == N ? $2 : 1/0):14 w l ls 2 notitle, 1 / 0 w linespoints ls 2 ps 1 t "ECM Prediction", \
         '' u ($1 == N ? $2 : 1/0):14:(Info("ECM Prediction",1,14,2)) w labels hypertext point ls 2 notitle, \
         '' u ($1 == N ? $2 : 1/0):10:(Info("Measurements",1,10,2)) w labels hypertext point ls 1 ps 1 t "Measurement"
}


####################################################################################################
# Blocking Plots
####################################################################################################

YMAX  = `bc -l <<< "1.2 * $({ awk -F"," '(NR>3){print $6}{print $8}{print $9}' results.csv; awk -F"," '(NR>3){print $8}' blocking_L3-3D.csv;} | sort -n | uniq | tail -n 1)"`

reset

set datafile separator ","
set xlabel "Grid Size (N³)"
set ylabel "Performance [MLUP/s]"
set yrange [0:YMAX]
set key top right width 5 samplen 2 font ",18"

set style line 1 lt 1 lc rgb '#0072bd' lw 2 pt 7 ps .5
set style line 2 lt 1 lc rgb '#edb120' lw 2 pt 5 ps 1
set style line 3 lt 1 lc rgb '#7e2f8e' lw 2 pt 11 ps 1
set style line 4 lt 1 lc rgb '#d95319' lw 2 pt 9 ps 1
set style line 5 lt 1 lc rgb '#77ac30' lw 1 pt 13

set terminal svg enhanced mousing fname 'Open Sans' jsdir JSDIR

save_encoding = GPVAL_ENCODING
set encoding utf8

set label at 0,0 "" hypertext point pt 1

Info(T,SIZE,MLUPS) = sprintf("%s\nN³ = %d³\nMLUP/s: %d", T, column(SIZE), column(MLUPS))

BLOCKINGS=`echo -n '"';find blocking*.csv -type f | sed 's/\.csv//g' | tr '\n' ' ';echo '"'`

do for [B in BLOCKINGS] {
    outfile = B . '.svg'
    set output outfile
    datafile = B . '.csv'

    COL=6
    DESC="Layer Condition"

    plot "< awk '(NR>2){print;}' results.csv" u 1:COL every 20:20 notitle w points ls 4, \
            "" u 1:COL notitle w lines ls 4, \
            "" u 1:COL:(Info(DESC,1,COL)) with labels hypertext point ls 4 pt 7 ps .33 notitle, \
            1 / 0 title sprintf("Roofline prediction from %s", DESC) w linespoints ls 4 ps 1, \
         "< awk '(NR>2){print;}' results.csv" u 1:8 every 20:20 notitle w points ls 2, \
            "" u 1:8 notitle w lines ls 2, \
            "" u 1:8:(Info("ECM",1,8)) with labels hypertext point ls 2 pt 7 ps .33 notitle, \
            1 / 0 title "Performance prediction from ECM" w linespoints ls 2 ps 1, \
         "" u 1:9:(Info("Measurement w/o blocking",1,9)) with labels hypertext point ls 1 title "Measurement w/o blocking", \
         datafile u 1:8:(Info("Measurement w/ blocking",1,8)) with labels hypertext point ls 5 ps .5 notitle, \
         1 / 0 w point ls 5 title "Measurement w/ blocking"
}
