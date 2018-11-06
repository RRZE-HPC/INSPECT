
################################################################################
# Roofline LC Plot
################################################################################

reset
set datafile separator ","
set xlabel "Grid Size (N^3)"
set ylabel "Performance [MLUP/s]"
#set xrange [300:900]
set yrange [0:*]
set xtics 100
set key top right width 5 samplen 2 font ",18"

set style line 1 lt 1 lc rgb '#0072bd' lw 2 pt 7 ps .5
set style line 2 lt 1 lc rgb '#edb120' lw 2 pt 5 ps 1
set style line 3 lt 1 lc rgb '#7e2f8e' lw 2 pt 11 ps 1
set style line 4 lt 1 lc rgb '#d95319' lw 2 pt 9 ps 1

set terminal svg enhanced mousing fname 'Open Sans' jsdir "https://rrze-hpc.github.io/stempel_data_collection/assets/js/"
# set term svg fname 'Open Sans'
set output "roofline_LC.svg"

# plot "< awk '(NR>2){print;}' results.csv" u 1:6 every 20:20 notitle w points ls 4, \
#          "" u 1:6 notitle w lines ls 4, 1 / 0 title "Roofline prediction from Layer Condition" w linespoints ls 4 ps 1, \
#      "< awk '(NR>2){print;}' results.csv" u 1:8 every 20:20 notitle w points ls 2, \
#          "" u 1:8 notitle w lines ls 2, 1 / 0 title "Performance prediction from ECM" w linespoints ls 2 ps 1, \
#      "< awk '(NR>2){print;}' results.csv" u 1:9 w points notitle ls 1, 1 / 0 w points title "Measurement" ls 1 ps 1

save_encoding = GPVAL_ENCODING
set encoding utf8

InfoMS(String,Size) = sprintf("Measurement\nN³ = %s³\nMLUP/s: %d", stringcolumn(String), column(Size))
InfoLC(String,Size) = sprintf("Layer Condition\nN³ = %s³\nMLUP/s: %d", stringcolumn(String), column(Size))
InfoCS(String,Size) = sprintf("Cache Simulation\nN³ = %s³\nMLUP/s: %d", stringcolumn(String), column(Size))
InfoECM(String,Size) = sprintf("ECM\nN³ = %s³\nMLUP/s: %d", stringcolumn(String), column(Size))

set label at 0,0 "" hypertext point pt 1

plot "< awk '(NR>2){print;}' results.csv" u 1:6 every 20:20 notitle w points ls 4, \
        "" u 1:6 notitle w lines ls 4, "" u 1:6:(InfoLC(1,6)) with labels hypertext point ls 4 pt 7 ps .33 notitle, \
        1 / 0 title "Roofline prediction from Layer Condition" w linespoints ls 4 ps 1, \
     "< awk '(NR>2){print;}' results.csv" u 1:8 every 20:20 notitle w points ls 2, \
        "" u 1:8 notitle w lines ls 2, "" u 1:8:(InfoECM(1,8)) with labels hypertext point ls 2 pt 7 ps .33 notitle, \
        1 / 0 title "Performance prediction from ECM" w linespoints ls 2 ps 1, \
     "" u 1:9:(InfoMS(1,9)) with labels hypertext point ls 1 title "Measurement"

################################################################################
# Roofline CS Plot
################################################################################

set output "roofline_CS.svg"

# plot "< awk '(NR>2){print;}' results.csv" u 1:3 every 20:20 notitle w points ls 3, \
#          "" u 1:3 notitle w lines ls 3, 1 / 0 title "Roofline prediction from Cache Simulation" w linespoints ls 3 ps 1, \
#      "< awk '(NR>2){print;}' results.csv" u 1:8 every 20:20 notitle w points ls 2, \
#          "" u 1:8 notitle w lines ls 2, 1 / 0 title "Performance prediction from ECM" w linespoints ls 2 ps 1, \
#      "< awk '(NR>2){print;}' results.csv" u 1:9 w points notitle ls 1, 1 / 0 w points title "Measurement" ls 1 ps 1

set label at 0,0 "" hypertext point pt 1

plot "< awk '(NR>2){print;}' results.csv" u 1:3 every 20:20 notitle w points ls 3, \
        "" u 1:3 notitle w lines ls 3, "" u 1:3:(InfoCS(1,3)) with labels hypertext point ls 3 pt 7 ps .33 notitle, \
        1 / 0 title "Roofline prediction from Cache Simulation" w linespoints ls 3 ps 1, \
     "< awk '(NR>2){print;}' results.csv" u 1:8 every 20:20 notitle w points ls 2, \
        "" u 1:8 notitle w lines ls 2, "" u 1:8:(InfoECM(1,8)) with labels hypertext point ls 2 pt 7 ps .33 notitle, \
        1 / 0 title "Performance prediction from ECM" w linespoints ls 2 ps 1, \
     "" u 1:9:(InfoMS(1,9)) with labels hypertext point ls 1 title "Measurement"

################################################################################
# Memory Transfer Plot CS
################################################################################

reset
set datafile separator ","
set xlabel "Grid Size (N^3)"
set ylabel "Data Transfers [B/LUP]"
#set xrange [300:900]
set yrange [0:80]
set xtics 100
set key bottom right width 5 samplen 2 font ",18"

set style line 1 lt 1 lc rgb '#0072bd' lw 2 pt 5 ps .5
set style line 2 lt 1 lc rgb '#edb120' lw 2 pt 7 ps .5
set style line 3 lt 1 lc rgb '#d95319' lw 2 pt 9 ps .5
set style line 4 lt 4 lc rgb '#0072bd' lw 2 pt 4 ps 1
set style line 5 lt 4 lc rgb '#edb120' lw 2 pt 6 ps 1
set style line 6 lt 4 lc rgb '#d95319' lw 2 pt 8 ps 1

set terminal svg enhanced mousing fname 'Open Sans' jsdir "https://rrze-hpc.github.io/stempel_data_collection/assets/js/"
# set term svg fname 'Open Sans'
set output "memory_CS.svg"

# plot "< awk '(NR>2){print;}' results.csv" u 1:34 every 20:20 notitle w points ls 4, "" u 1:34 notitle w lines ls 4, \
#      "" u 1:25 notitle w points ls 1, 1 / 0 title "L1 - L2 transfer" w linespoints ls 1 ps 1, \
#      "" u 1:37 every 20:20 notitle w points ls 5, "" u 1:37 notitle w lines ls 5, \
#      "" u 1:28 notitle w points ls 2, 1 / 0 title "L2 - L3 transfer" w linespoints ls 2 ps 1, \
#      "" u 1:40 every 20:20 notitle w points ls 6, "" u 1:40 notitle w lines ls 6, \
#      "" u 1:31 notitle w points ls 3, 1 / 0 title "L3 - Mem transfer" w linespoints ls 3 ps 1

save_encoding = GPVAL_ENCODING
set encoding utf8

InfoL12(String,Size) = sprintf("L1 - L2 Transfer\nN³ = %s³\nByte/LUP: %d", stringcolumn(String), column(Size))
InfoL23(String,Size) = sprintf("L2 - L3 Transfer\nN³ = %s³\nByte/LUP: %d", stringcolumn(String), column(Size))
InfoL3M(String,Size) = sprintf("L3 - MEM Transfer\nN³ = %s³\nByte/LUP: %d", stringcolumn(String), column(Size))

set label at 0,0 "" hypertext point pt 1

plot "< awk '(NR>2){print;}' results.csv" u 1:34 every 20:20 notitle w points ls 4, "" u 1:34 notitle w lines ls 4, \
     "" u 1:25:(InfoL12(1,25)) with labels hypertext point ls 1 ps .5 notitle, \
     1 / 0 title "L1 - L2 transfer" w linespoints ls 1 ps 1, \
     "" u 1:37 every 20:20 notitle w points ls 5, "" u 1:37 notitle w lines ls 5, \
     "" u 1:28:(InfoL23(1,28)) with labels hypertext point ls 2 ps .5 notitle, \
     1 / 0 title "L2 - L3 transfer" w linespoints ls 2 ps 1, \
     "" u 1:40 every 20:20 notitle w points ls 6, "" u 1:40 notitle w lines ls 6, \
     "" u 1:31:(InfoL12(1,31)) with labels hypertext point ls 3 ps .5 notitle, \
     1 / 0 title "L3 - Mem transfer" w linespoints ls 3 ps 1

################################################################################
# Memory Transfer Plot LC
################################################################################

set output "memory_LC.svg"

set label at 0,0 "" hypertext point pt 1

plot "< awk '(NR>2){print;}' results.csv" u 1:43 every 20:20 notitle w points ls 4, "" u 1:43 notitle w lines ls 4, \
     "" u 1:25:(InfoL12(1,25)) with labels hypertext point ls 1 ps .5 notitle, \
     1 / 0 title "L1 - L2 transfer" w linespoints ls 1 ps 1, \
     "" u 1:46 every 20:20 notitle w points ls 5, "" u 1:46 notitle w lines ls 5, \
     "" u 1:28:(InfoL23(1,28)) with labels hypertext point ls 2 ps .5 notitle, \
     1 / 0 title "L2 - L3 transfer" w linespoints ls 2 ps 1, \
     "" u 1:49 every 20:20 notitle w points ls 6, "" u 1:49 notitle w lines ls 6, \
     "" u 1:31:(InfoL12(1,31)) with labels hypertext point ls 3 ps .5 notitle, \
     1 / 0 title "L3 - Mem transfer" w linespoints ls 3 ps 1

################################################################################
# ECM LC Plot
################################################################################

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
set terminal svg enhanced mousing fname 'Open Sans' jsdir "https://rrze-hpc.github.io/stempel_data_collection/assets/js/"
set output "ecm_LC.svg"

save_encoding = GPVAL_ENCODING
set encoding utf8

set multiplot

set origin 0,0
set size 1,1
set yrange [0:80]
set style data histogram
set style histogram rowstacked
set xlabel "Grid Size (N^3)" textcolor "#ffffff"
set ylabel "cy/CL" textcolor "#ffffff"
set xtics textcolor "#ffffff"
set ytics textcolor "#ffffff"
set style fill solid border
set key reverse outside top horizontal Left samplen 1
set tics scale 0

plot  "< awk '(NR>2){print;}' results.csv" u 17:xticlabels(1) title 'T_{nOL}' ls 4, \
      "< awk '(NR>2){print;}' results.csv" u 18:xticlabels(1) title 'T_{L1L2}' ls 7, \
      "< awk '(NR>2){print;}' results.csv" u 19:xticlabels(1) title 'T_{L2L3}' ls 2, \
      "< awk '(NR>2){print;}' results.csv" u 20:xticlabels(1) title 'T_{L3MEM}' ls 3

set origin 0,0
set size 1,1
set yrange [0:80]
set xlabel "Grid Size (N^3)" textcolor "#000000"
set ylabel "cy/CL" textcolor "#000000"
set xtics 100 textcolor "#000000"
set ytics textcolor "#000000"
set key outside left top horizontal reverse width 1 samplen 1
set tics scale 1

InfoECM(String,Size) = sprintf("ECM\nN³ = %s³\cy/CL: %d", stringcolumn(String), column(Size))

set label at 0,0 "" hypertext point pt 1

plot "< awk '(NR>2){print;}' results.csv" u 1:22:(InfoMS(1,22)) with labels hypertext point ls 1 title 'Measurement', \
     "< awk '(NR>2){print;}' results.csv" u 1:16 w lines title 'T_{OL}' ls 10

# end of multiplot
unset multiplot


################################################################################
# ECM CS Plot
################################################################################

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
set terminal svg enhanced mousing fname 'Open Sans' jsdir "https://rrze-hpc.github.io/stempel_data_collection/assets/js/"
set output "ecm_CS.svg"

save_encoding = GPVAL_ENCODING
set encoding utf8

set multiplot

set origin 0,0
set size 1,1
set yrange [0:80]
set style data histogram
set style histogram rowstacked
set xlabel "Grid Size (N^3)" textcolor "#ffffff"
set ylabel "cy/CL" textcolor "#ffffff"
set xtics textcolor "#ffffff"
set ytics textcolor "#ffffff"
set style fill solid border
set key reverse outside top horizontal Left samplen 1
set tics scale 0

plot  "< awk '(NR>2){print;}' results.csv" u 11:xticlabels(1) title 'T_{nOL}' ls 4, \
      "< awk '(NR>2){print;}' results.csv" u 12:xticlabels(1) title 'T_{L1L2}' ls 7, \
      "< awk '(NR>2){print;}' results.csv" u 13:xticlabels(1) title 'T_{L2L3}' ls 2, \
      "< awk '(NR>2){print;}' results.csv" u 14:xticlabels(1) title 'T_{L3MEM}' ls 3

set origin 0,0
set size 1,1
set yrange [0:80]
set xlabel "Grid Size (N^3)" textcolor "#000000"
set ylabel "cy/CL" textcolor "#000000"
set xtics 100 textcolor "#000000"
set ytics textcolor "#000000"
set key outside left top horizontal reverse width 1 samplen 1
set tics scale 1

InfoECM(String,Size) = sprintf("ECM\nN³ = %s³\cy/CL: %d", stringcolumn(String), column(Size))
set label at 0,0 "" hypertext point pt 1

plot "< awk '(NR>2){print;}' results.csv" u 1:22:(InfoMS(1,22)) with labels hypertext point ls 1 title 'Measurement', \
     "< awk '(NR>2){print;}' results.csv" u 1:10 w lines title 'T_{OL}' ls 10

# end of multiplot
unset multiplot
