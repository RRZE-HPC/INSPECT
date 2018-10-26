
################################################################################
# Roofline Plot
################################################################################

reset
set datafile separator ","
set xlabel "Grid Size (N^3)"
set ylabel "Performance [MLUP/s]"
#set xrange [300:900]
set yrange [0:*]
set xtics 100
set key top right width 1 samplen 1

set style line 1 lt 1 lc rgb '#0072bd' lw 1 pt 7 ps .5
set style line 2 lt 1 lc rgb '#d95319' lw 1 pt 2
set style line 3 lt 1 lc rgb '#edb120' lw 1 pt 3
set style line 4 lt 1 lc rgb '#7e2f8e' lw 1 pt 4
set style line 5 lt 1 lc rgb '#77ac30' lw 1 pt 6
set style line 6 lt 1 lc rgb '#4dbeee' lw 1 pt 8
set style line 7 lt 1 lc rgb '#a2142f' lw 1 pt 10
set style line 8 lt 1 lc rgb '#AE81FF' lw 1 pt 12
set style line 9 lt 1 lc rgb '#4C4745' lw 1 pt 14

set term svg fname 'Open Sans'
set output "roofline.svg"

plot "< awk '(NR>2){print;}' results.csv" u 1:9 w points title "Measurement" ls 1, \
     "< awk '(NR>2){print;}' results.csv" u 1:8 every 20:20 notitle w points ls 2, \
         "" u 1:8 notitle w lines ls 2, 1 / 0 title "Roofline from ECM prediction" w linespoints ls 2, \
     "< awk '(NR>2){print;}' results.csv" u 1:3 every 20:20 notitle w points ls 3, \
         "" u 1:3 notitle w lines ls 3, 1 / 0 title "Roofline with Cache Simulation" w linespoints ls 3, \
     "< awk '(NR>2){print;}' results.csv" u 1:6 every 20:20 notitle w points ls 4, \
         "" u 1:6 notitle w lines ls 4, 1 / 0 title "Roofline with Layer Condition" w linespoints ls 4

################################################################################
# Memory Transfer Plot
################################################################################

reset
set datafile separator ","
set xlabel "Grid Size (N^3)"
set ylabel "Data Transfers [B/LUP]"
#set xrange [300:900]
set yrange [0:*]
set xtics 100
set key bottom right width 1 samplen 1

set style line 1 lt 1 lc rgb '#0072bd' lw 1 pt 1
set style line 2 lt 1 lc rgb '#d95319' lw 1 pt 2
set style line 3 lt 1 lc rgb '#edb120' lw 1 pt 3
set style line 4 lt 4 lc rgb '#770072bd' lw 1 pt 1
set style line 5 lt 4 lc rgb '#77d95319' lw 1 pt 2
set style line 6 lt 4 lc rgb '#77edb120' lw 1 pt 3

set term svg fname 'Open Sans'
set output "memory.svg"

plot "< awk '(NR>2){print;}' results.csv" u 1:34 notitle w lines ls 4, \
     "< awk '(NR>2){print;}' results.csv" u 1:25 every 10:10 notitle w points ls 1, \
          "" u 1:25 notitle w lines ls 1, 1 / 0 title "L1 - L2 transfer" w linespoints ls 1, \
     "< awk '(NR>2){print;}' results.csv" u 1:37 notitle w lines ls 5, \
     "< awk '(NR>2){print;}' results.csv" u 1:28 every 10:10 notitle w points ls 2, \
          "" u 1:28 notitle w lines ls 2, 1 / 0 title "L2 - L3 transfer" w linespoints ls 2, \
     "< awk '(NR>2){print;}' results.csv" u 1:40 notitle w lines ls 6, \
     "< awk '(NR>2){print;}' results.csv" u 1:31 every 10:10 notitle w points ls 3, \
          "" u 1:31 notitle w lines ls 3, 1 / 0 title "L3 - Mem transfer" w linespoints ls 3

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
set term svg fname 'Open Sans' enhanced
set output "ecm.svg"

set multiplot

set origin 0,0
set size 1,1
set yrange [0:100]
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
set yrange [0:100]
set xlabel "Grid Size (N^3)" textcolor "#000000"
set ylabel "cy/CL" textcolor "#000000"
set xtics 100 textcolor "#000000"
set ytics textcolor "#000000"
set key outside left top horizontal reverse width 1 samplen 1
set tics scale 1
plot "< awk '(NR>2){print;}' results.csv" u 1:22 w points title 'Measurement' ls 1, \
     "< awk '(NR>2){print;}' results.csv" u 1:16 w lines title 'T_{OL}' ls 10

# plot "< awk '(NR>2){print;}' results.csv" u 1:21 w steps notitle ls 10, \
#      "< awk '(NR>2){print;}' results.csv" u 1:22 w points title 'Measurement' ls 1, \
#      "< awk '(NR>2){print;}' results.csv" u 1:16 w lines title 'T_{OL}' ls 10

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
set term svg fname 'Open Sans' enhanced
set output "ecm_CS.svg"

set multiplot

set origin 0,0
set size 1,1
set yrange [0:100]
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
set yrange [0:100]
set xlabel "Grid Size (N^3)" textcolor "#000000"
set ylabel "cy/CL" textcolor "#000000"
set xtics 100 textcolor "#000000"
set ytics textcolor "#000000"
set key outside left top horizontal reverse width 1 samplen 1
set tics scale 1
plot "< awk '(NR>2){print;}' results.csv" u 1:22 w points title 'Measurement' ls 1, \
     "< awk '(NR>2){print;}' results.csv" u 1:10 w lines title 'T_{OL}' ls 10

# plot "< awk '(NR>2){print;}' results.csv" u 1:21 w steps notitle ls 10, \
#      "< awk '(NR>2){print;}' results.csv" u 1:22 w points title 'Measurement' ls 1, \
#      "< awk '(NR>2){print;}' results.csv" u 1:16 w lines title 'T_{OL}' ls 10

# end of multiplot
unset multiplot