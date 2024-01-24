#!/bin/sh

mtx_path="$1"

python do_sum_matrices.py $mtx_path/counts_filtered/cells_x_genes.nascent.mtx $mtx_path/counts_filtered/cells_x_genes.mature.mtx $mtx_path/counts_filtered/cells_x_genes.nm.mtx

python pseudobulk.py $mtx_path/counts_filtered/cells_x_genes.nascent.mtx $mtx_path/counts_filtered/pseudobulk.nascent.txt
python pseudobulk.py $mtx_path/counts_filtered/cells_x_genes.mature.mtx $mtx_path/counts_filtered/pseudobulk.mature.txt
python pseudobulk.py $mtx_path/counts_filtered/cells_x_genes.ambiguous.mtx $mtx_path/counts_filtered/pseudobulk.ambiguous.txt
python pseudobulk.py $mtx_path/counts_filtered/cells_x_genes.cell.mtx $mtx_path/counts_filtered/pseudobulk.cell.txt
python pseudobulk.py $mtx_path/counts_filtered/cells_x_genes.nucleus.mtx $mtx_path/counts_filtered/pseudobulk.nucleus.txt
python pseudobulk.py $mtx_path/counts_filtered/cells_x_genes.total.mtx $mtx_path/counts_filtered/pseudobulk.total.txt
python pseudobulk.py $mtx_path/counts_filtered/cells_x_genes.nm.mtx $mtx_path/counts_filtered/pseudobulk.nm.txt

# Nascent, mature, ambiguous
cat $mtx_path/counts_filtered/cells_x_genes.nascent.mtx|tail -n+4|cut -d' ' -f3|awk '{s+=$1} END {print s}' > $mtx_path/counts_filtered/counts.txt
cat $mtx_path/counts_filtered/cells_x_genes.mature.mtx|tail -n+4|cut -d' ' -f3|awk '{s+=$1} END {print s}' >> $mtx_path/counts_filtered/counts.txt
cat $mtx_path/counts_filtered/cells_x_genes.ambiguous.mtx|tail -n+4|cut -d' ' -f3|awk '{s+=$1} END {print s}' >> $mtx_path/counts_filtered/counts.txt
