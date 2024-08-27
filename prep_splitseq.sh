#!/bin/bash

file_id="$1" # e.g. SRR13948565
metadata_id="$2" # e.g. GSM5169184_C2C12_short_1k

splitcode -c splitseq_config_R.txt --gzip -t 16 -N 2 -o splitseq_R_R1.fastq.gz,splitseq_R_R2.fastq.gz ${file_id}_1.fastq.gz ${file_id}_2.fastq.gz 
splitcode -c splitseq_config_T.txt --gzip -t 16 -N 2 -o splitseq_T_R1.fastq.gz,splitseq_T_R2.fastq.gz ${file_id}_1.fastq.gz ${file_id}_2.fastq.gz 

awk 'NR==FNR {strings[NR-1]=$0; next} {print strings[$1]}' r1_R_Awells.txt <(zcat ${metadata_id}_cell_metadata.csv.gz|grep MB_cells|awk -F',' '$8 >= 10000'|cut -d, -f5) > r1_R_barcodes.txt
awk 'NR==FNR {strings[NR-1]=$0; next} {print strings[$1]}' r1_T_Awells.txt <(zcat ${metadata_id}_cell_metadata.csv.gz|grep MB_cells|awk -F',' '$8 >= 10000'|cut -d, -f5) > r1_T_barcodes.txt
paste -d'\0' <(zcat ${metadata_id}_cell_metadata.csv.gz|grep MB_cells|awk -F',' '$8 >= 10000'| cut -d, -f2|cut -d_ -f1) r1_R_barcodes.txt > splitseq_final_r2r3_barcodes_R.txt
paste -d'\0' <(zcat ${metadata_id}_cell_metadata.csv.gz|grep MB_cells|awk -F',' '$8 >= 10000'| cut -d, -f2|cut -d_ -f1) r1_T_barcodes.txt > splitseq_final_r2r3_barcodes_T.txt
cat splitseq_final_r2r3_barcodes_R.txt splitseq_final_r2r3_barcodes_T.txt > splitseq_final_barcodes.txt

splitcode -b "splitseq_final_barcodes.txt" --minFinds=1 --locations="2:0:24" --gzip -t 16 -N 3 -S 0,1 -o splitseq_R_${file_id}_R1.fastq.gz,splitseq_R_${file_id}_R2.fastq.gz splitseq_R_R1.fastq.gz splitseq_R_R2.fastq.gz barcodes_R.fastq.gz

splitcode -b "splitseq_final_barcodes.txt" --minFinds=1 --locations="2:0:24" --gzip -t 16 -N 3 -S 0,1 -o splitseq_T_${file_id}_R1.fastq.gz,splitseq_T_${file_id}_R2.fastq.gz splitseq_T_R1.fastq.gz splitseq_T_R2.fastq.gz barcodes_T.fastq.gz


echo "R_${file_id} splitseq_R_${file_id}_R1.fastq.gz splitseq_R_${file_id}_R2.fastq.gz" >> splitseq_batch.txt
echo "T_${file_id} splitseq_T_${file_id}_R1.fastq.gz splitseq_T_${file_id}_R2.fastq.gz" >> splitseq_batch.txt
