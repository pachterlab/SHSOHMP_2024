#!/bin/bash

# Usage: ./filter.sh kallisto_output 500
# (Note: The output path should be organized exactly like the output from kb count; with a kallisto_output/counts_unfiltered directory and cells_x_genes.total.mtx is where the post-filtering barcodes are extracted if we use --sum=total to generate 6 matrices)
# (Note: 500 is the UMI threshold here, but you can change it to whatever)

directory="$1"
umi_filter="$2"

function finalmtx() {
# Usage: finalmtx ${directory}
directory="$1"

if [ -f ${directory}/counts_unfiltered/cells_x_genes.total.mtx ]; then
echo "Processing Total Matrix: $directory $umi_filter"
processmtx ${directory}/counts_unfiltered ${directory}/counts_filtered cells_x_genes.total.mtx
echo "Processing Other Matrices: $directory $umi_filter"
processmtx2 ${directory}/counts_unfiltered ${directory}/counts_filtered cells_x_genes.mature.mtx
processmtx2 ${directory}/counts_unfiltered ${directory}/counts_filtered cells_x_genes.nascent.mtx
processmtx2 ${directory}/counts_unfiltered ${directory}/counts_filtered cells_x_genes.ambiguous.mtx
processmtx2 ${directory}/counts_unfiltered ${directory}/counts_filtered cells_x_genes.cell.mtx
processmtx2 ${directory}/counts_unfiltered ${directory}/counts_filtered cells_x_genes.nucleus.mtx
processfin ${directory}/counts_unfiltered ${directory}/counts_filtered cells_x_genes.total.mtx
else
processmtx ${directory}/counts_unfiltered ${directory}/counts_filtered cells_x_genes.mtx
processfin ${directory}/counts_unfiltered ${directory}/counts_filtered cells_x_genes.mtx
fi
}

function processmtx() {
# Usage: processmtx ${directory}/counts_unfiltered ${directory}/counts_filtered cells_x_genes.total.mtx
in_dir="$1/"
out_dir="$2/"
mtx="$3"
mkdir -p ${out_dir}
cat ${in_dir}${mtx}|tail -n+4|awk -v umi_filter=$umi_filter -F' ' '{curr=$1; prev_sum=sum; sum+=$3;old_running=running;running=running$0"\n"; i+=1; } { if (old==0) { old=curr; sum=$3; prev_sum=$3; running=$0"\n"; old_running=running; i=0; } else if (curr!=old) { if (prev_sum >= umi_filter) { printf old_running; total+=i; } old=curr; sum=$3; prev_sum=$3; running=$0"\n"; i=0; } } END {if (sum >= umi_filter) { printf running; }}' > ${out_dir}${mtx}.tmp
nonzeroes=$(wc -l ${out_dir}${mtx}.tmp|cut -d' ' -f1|tr -d '\n')
numcells=$(cat ${out_dir}${mtx}.tmp|cut -d' ' -f1|sort -u|wc -l|cut -d' ' -f1|tr -d '\n')
cut -d' ' -f1 ${out_dir}${mtx}.tmp|sort -n -u > ${out_dir}rows.tmp
awk 'NR==FNR{linesToPrint[$0];next} FNR in linesToPrint' ${out_dir}rows.tmp ${in_dir}cells_x_genes.barcodes.txt > ${out_dir}cells_x_genes.barcodes.txt
if [ -f ${in_dir}cells_x_genes.barcodes.prefix.txt ]; then
    awk 'NR==FNR{linesToPrint[$0];next} FNR in linesToPrint' ${out_dir}rows.tmp ${in_dir}cells_x_genes.barcodes.prefix.txt > ${out_dir}cells_x_genes.barcodes.prefix.txt
    paste -d'\0' ${out_dir}cells_x_genes.barcodes.prefix.txt ${out_dir}cells_x_genes.barcodes.txt > ${out_dir}cells_x_genes.barcodes.combined.txt
fi
cat ${out_dir}${mtx}.tmp|awk -F' ' '{curr=$1; } { if (old==0) { old=curr; i=1; } else if (curr!=old) { old=curr; i+=1; } print i,$2,$3 } ' > ${out_dir}${mtx}.refactored.tmp
head -2 ${in_dir}${mtx} > ${out_dir}${mtx}
paste -d' ' <(echo ${numcells}) <(head -3 ${in_dir}${mtx}|tail -1|cut -d' ' -f2) <(echo ${nonzeroes}) >> ${out_dir}${mtx}
cat ${out_dir}${mtx}.refactored.tmp >> ${out_dir}${mtx}
cp ${in_dir}cells_x_genes.genes.names.txt ${out_dir}cells_x_genes.genes.names.txt 
cp ${in_dir}cells_x_genes.genes.txt ${out_dir}cells_x_genes.genes.txt
rm ${out_dir}${mtx}.tmp
rm ${out_dir}${mtx}.refactored.tmp
}

function processmtx2() {
# Usage: processmtx2 ${directory}/counts_unfiltered ${directory}/counts_filtered cells_x_genes.mtx
in_dir="$1/"
out_dir="$2/"
mtx="$3"
mkdir -p ${out_dir}
umi_filter=0
cat ${in_dir}${mtx}|tail -n+4|awk -v umi_filter=$umi_filter -F' ' '{curr=$1; prev_sum=sum; sum+=$3;old_running=running;running=running$0"\n"; i+=1; } { if (old==0) { old=curr; sum=$3; prev_sum=$3; running=$0"\n"; old_running=running; i=0; } else if (curr!=old) { if (prev_sum >= umi_filter) { printf old_running; total+=i; } old=curr; sum=$3; prev_sum=$3; running=$0"\n"; i=0; } } END {if (sum >= umi_filter) { printf running; }}' > ${out_dir}${mtx}.tmp
numcells=$(wc -l ${out_dir}rows.tmp|cut -d' ' -f1|tr -d '\n')

awk -F' ' 'NR==FNR{check[$1]=$2;next} $1 in check {print check[$1],$2,$3}' <(awk '{print $1,NR}' ${out_dir}rows.tmp) ${out_dir}${mtx}.tmp > ${out_dir}${mtx}.refactored.tmp

nonzeroes=$(wc -l ${out_dir}${mtx}.refactored.tmp|cut -d' ' -f1|tr -d '\n')

head -2 ${in_dir}${mtx} > ${out_dir}${mtx}
paste -d' ' <(echo ${numcells}) <(head -3 ${in_dir}${mtx}|tail -1|cut -d' ' -f2) <(echo ${nonzeroes}) >> ${out_dir}${mtx}
cat ${out_dir}${mtx}.refactored.tmp >> ${out_dir}${mtx}
cp ${in_dir}cells_x_genes.genes.names.txt ${out_dir}cells_x_genes.genes.names.txt 
cp ${in_dir}cells_x_genes.genes.txt ${out_dir}cells_x_genes.genes.txt
rm ${out_dir}${mtx}.tmp
rm ${out_dir}${mtx}.refactored.tmp
}

function processfin() {
# Usage: processfin ${directory}/counts_unfiltered ${directory}/counts_filtered cells_x_genes.total.mtx
in_dir="$1/"
out_dir="$2/"
mtx="$3"
rm -f ${out_dir}rows.tmp
}

finalmtx ${directory} ${out_dir} ${mtx}

