# Script Gnuplot para generar 4 imágenes comparando original vs optimizado

codes = "base fdm shoot sinc"

do for [c in codes] {

    png_file = c."_compare.png"
    orig_file = "data/".c."_orig.txt"
    op_file   = "data/".c."_op.txt"

    set terminal pngcairo size 1000,800 enhanced font 'Arial,12'
    set output png_file

    set multiplot layout 2,1 title "Tiempos de ejecución - ".c

    # ----------------------
    # Gráfica lineal (arriba)
    # ----------------------
    set title c." - Lineal"
    set xlabel ""
    set ylabel "Tiempo [s]"
    set grid
    set key outside

    plot orig_file using 1:6 with linespoints lw 2 pt 7 lc rgb "blue" title "original", \
         op_file   using 1:6 with linespoints lw 2 pt 7 lc rgb "red"  title "optimizado"

    # ----------------------
    # Gráfica logarítmica (abajo)
    # ----------------------
    set title c." - Log Y"
    set xlabel "Tamaño N"
    set ylabel "Tiempo [s]"
    set logscale y
    set grid
    set key outside

    plot orig_file using 1:6 with linespoints lw 2 pt 7 lc rgb "blue" title "original", \
         op_file   using 1:6 with linespoints lw 2 pt 7 lc rgb "red"  title "optimizado"

    unset multiplot
}