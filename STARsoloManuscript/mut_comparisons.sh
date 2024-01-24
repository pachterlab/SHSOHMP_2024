#!/bin/sh

# Only uses the MultiGeneNo simulation

label="$1"

mkdir -p results_mut

# Kallisto:

python3 comparisons.py samples/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneNo/truth.mtx genomes/human_CR_3.0.0/genes.tsv data/whitelists/10Xv3 count_${label}/kallisto_0.50.1/human_CR_3.0.0/standard_1/default/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneNo/20/run1/counts_unfiltered/cells_x_genes.mtx count_${label}/kallisto_0.50.1/human_CR_3.0.0/standard_1/default/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneNo/20/run1/counts_unfiltered/cells_x_genes.genes.txt count_${label}/kallisto_0.50.1/human_CR_3.0.0/standard_1/default/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneNo/20/run1/counts_unfiltered/cells_x_genes.barcodes.txt results_mut/results_sim_vs_kallisto_${label}.txt --barcodes sim_barcodes.txt
python3 comparisons.py samples/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneNo/truth.mtx genomes/human_CR_3.0.0/genes.tsv data/whitelists/10Xv3 count_${label}/kallisto_0.50.1/human_CR_3.0.0/standard_offlist_1/default/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneNo/20/run1/counts_unfiltered/cells_x_genes.mtx count_${label}/kallisto_0.50.1/human_CR_3.0.0/standard_offlist_1/default/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneNo/20/run1/counts_unfiltered/cells_x_genes.genes.txt count_${label}/kallisto_0.50.1/human_CR_3.0.0/standard_offlist_1/default/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneNo/20/run1/counts_unfiltered/cells_x_genes.barcodes.txt results_mut/results_sim_vs_offlist_kallisto_${label}.txt --barcodes sim_barcodes.txt
python3 comparisons.py samples/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneNo/truth.mtx genomes/human_CR_3.0.0/genes.tsv data/whitelists/10Xv3 count_${label}/kallisto_0.50.1/human_CR_3.0.0/standard_offlistoverhang6_1/default/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneNo/20/run1/counts_unfiltered/cells_x_genes.mtx count_${label}/kallisto_0.50.1/human_CR_3.0.0/standard_offlistoverhang6_1/default/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneNo/20/run1/counts_unfiltered/cells_x_genes.genes.txt count_${label}/kallisto_0.50.1/human_CR_3.0.0/standard_offlistoverhang6_1/default/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneNo/20/run1/counts_unfiltered/cells_x_genes.barcodes.txt results_mut/results_sim_vs_offlistoverhang6_kallisto_${label}.txt --barcodes sim_barcodes.txt
python3 comparisons.py samples/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneNo/truth.mtx genomes/human_CR_3.0.0/genes.tsv data/whitelists/10Xv3 count_${label}/kallisto_0.50.1/human_CR_3.0.0/standard_offlistoverhang32_1/default/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneNo/20/run1/counts_unfiltered/cells_x_genes.mtx count_${label}/kallisto_0.50.1/human_CR_3.0.0/standard_offlistoverhang32_1/default/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneNo/20/run1/counts_unfiltered/cells_x_genes.genes.txt count_${label}/kallisto_0.50.1/human_CR_3.0.0/standard_offlistoverhang32_1/default/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneNo/20/run1/counts_unfiltered/cells_x_genes.barcodes.txt results_mut/results_sim_vs_offlistoverhang32_kallisto_${label}.txt --barcodes sim_barcodes.txt
python3 comparisons.py samples/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneNo/truth.mtx genomes/human_CR_3.0.0/genes.tsv data/whitelists/10Xv3 count_${label}/kallisto_0.50.1/human_CR_3.0.0/nac_1/default/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneNo/20/run1/counts_unfiltered/cells_x_genes.cell.mtx count_${label}/kallisto_0.50.1/human_CR_3.0.0/nac_1/default/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneNo/20/run1/counts_unfiltered/cells_x_genes.genes.txt count_${label}/kallisto_0.50.1/human_CR_3.0.0/nac_1/default/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneNo/20/run1/counts_unfiltered/cells_x_genes.barcodes.txt results_mut/results_nac_sim_vs_kallisto_${label}.txt --barcodes sim_barcodes.txt
python3 comparisons.py samples/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneNo/truth.mtx genomes/human_CR_3.0.0/genes.tsv data/whitelists/10Xv3 count_${label}/kallisto_0.50.1/human_CR_3.0.0/nac_offlist_1/default/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneNo/20/run1/counts_unfiltered/cells_x_genes.cell.mtx count_${label}/kallisto_0.50.1/human_CR_3.0.0/nac_offlist_1/default/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneNo/20/run1/counts_unfiltered/cells_x_genes.genes.txt count_${label}/kallisto_0.50.1/human_CR_3.0.0/nac_offlist_1/default/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneNo/20/run1/counts_unfiltered/cells_x_genes.barcodes.txt results_mut/results_nac_sim_vs_offlist_kallisto_${label}.txt --barcodes sim_barcodes.txt
python3 comparisons.py samples/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneNo/truth.mtx genomes/human_CR_3.0.0/genes.tsv data/whitelists/10Xv3 count_${label}/kallisto_0.50.1/human_CR_3.0.0/nac_offlistoverhang6_1/default/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneNo/20/run1/counts_unfiltered/cells_x_genes.cell.mtx count_${label}/kallisto_0.50.1/human_CR_3.0.0/nac_offlistoverhang6_1/default/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneNo/20/run1/counts_unfiltered/cells_x_genes.genes.txt count_${label}/kallisto_0.50.1/human_CR_3.0.0/nac_offlistoverhang6_1/default/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneNo/20/run1/counts_unfiltered/cells_x_genes.barcodes.txt results_mut/results_nac_sim_vs_offlistoverhang6_kallisto_${label}.txt --barcodes sim_barcodes.txt
python3 comparisons.py samples/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneNo/truth.mtx genomes/human_CR_3.0.0/genes.tsv data/whitelists/10Xv3 count_${label}/kallisto_0.50.1/human_CR_3.0.0/nac_offlistoverhang32_1/default/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneNo/20/run1/counts_unfiltered/cells_x_genes.cell.mtx count_${label}/kallisto_0.50.1/human_CR_3.0.0/nac_offlistoverhang32_1/default/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneNo/20/run1/counts_unfiltered/cells_x_genes.genes.txt count_${label}/kallisto_0.50.1/human_CR_3.0.0/nac_offlistoverhang32_1/default/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneNo/20/run1/counts_unfiltered/cells_x_genes.barcodes.txt results_mut/results_nac_sim_vs_offlistoverhang32_kallisto_${label}.txt --barcodes sim_barcodes.txt


cat count_${label}/kallisto_0.50.1/human_CR_3.0.0/standard_1/default/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneNo/20/run1/run_info.json|grep "\"n_p"|cut -d' ' -f2|sed 's/,*$//g'|awk 'NR==1 {first_line=$0} END {print $0, first_line}' > results_mut/_results_sim_vs_kallisto_${label}.txt

cat count_${label}/kallisto_0.50.1/human_CR_3.0.0/standard_offlist_1/default/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneNo/20/run1/run_info.json|grep "\"n_p"|cut -d' ' -f2|sed 's/,*$//g'|awk 'NR==1 {first_line=$0} END {print $0, first_line}' > results_mut/_results_sim_vs_offlist_kallisto_${label}.txt

cat count_${label}/kallisto_0.50.1/human_CR_3.0.0/standard_offlistoverhang6_1/default/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneNo/20/run1/run_info.json|grep "\"n_p"|cut -d' ' -f2|sed 's/,*$//g'|awk 'NR==1 {first_line=$0} END {print $0, first_line}' > results_mut/_results_sim_vs_offlistoverhang6_kallisto_${label}.txt

cat count_${label}/kallisto_0.50.1/human_CR_3.0.0/standard_offlistoverhang32_1/default/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneNo/20/run1/run_info.json|grep "\"n_p"|cut -d' ' -f2|sed 's/,*$//g'|awk 'NR==1 {first_line=$0} END {print $0, first_line}' > results_mut/_results_sim_vs_offlistoverhang32_kallisto_${label}.txt


cat count_${label}/kallisto_0.50.1/human_CR_3.0.0/nac_1/default/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneNo/20/run1/run_info.json|grep "\"n_p"|cut -d' ' -f2|sed 's/,*$//g'|awk 'NR==1 {first_line=$0} END {print $0, first_line}' > results_mut/_results_nac_sim_vs_kallisto_${label}.txt

cat count_${label}/kallisto_0.50.1/human_CR_3.0.0/nac_offlist_1/default/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneNo/20/run1/run_info.json|grep "\"n_p"|cut -d' ' -f2|sed 's/,*$//g'|awk 'NR==1 {first_line=$0} END {print $0, first_line}' > results_mut/_results_nac_sim_vs_offlist_kallisto_${label}.txt

cat count_${label}/kallisto_0.50.1/human_CR_3.0.0/nac_offlistoverhang6_1/default/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneNo/20/run1/run_info.json|grep "\"n_p"|cut -d' ' -f2|sed 's/,*$//g'|awk 'NR==1 {first_line=$0} END {print $0, first_line}' > results_mut/_results_nac_sim_vs_offlistoverhang6_kallisto_${label}.txt

cat count_${label}/kallisto_0.50.1/human_CR_3.0.0/nac_offlistoverhang32_1/default/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneNo/20/run1/run_info.json|grep "\"n_p"|cut -d' ' -f2|sed 's/,*$//g'|awk 'NR==1 {first_line=$0} END {print $0, first_line}' > results_mut/_results_nac_sim_vs_offlistoverhang32_kallisto_${label}.txt


# STAR:

python3 comparisons.py samples/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneNo/truth.mtx genomes/human_CR_3.0.0/genes.tsv data/whitelists/10Xv3 \
count_${label}/STAR_2.7.9a/human_CR_3.0.0/fullSA/10X_noSAM_sims_mult_ENCODE/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneNo/20/run1/Solo.out/Gene/raw/matrix.mtx \
count_${label}/STAR_2.7.9a/human_CR_3.0.0/fullSA/10X_noSAM_sims_mult_ENCODE/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneNo/20/run1/Solo.out/Gene/raw/features.tsv \
count_${label}/STAR_2.7.9a/human_CR_3.0.0/fullSA/10X_noSAM_sims_mult_ENCODE/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneNo/20/run1/Solo.out/Gene/raw/barcodes.tsv \
results_mut/results_sim_vs_star_${label}.txt --barcodes sim_barcodes.txt --transpose

cat count_${label}/STAR_2.7.9a/human_CR_3.0.0/fullSA/10X_noSAM_sims_mult_ENCODE/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneNo/20/run1/Log.final.out|grep -i Number|grep -v unmapped|grep -v splice|cut -f2|awk 'NR==1 { total=$1} NR>1 {s+=$1} END {print s,total}' > results_mut/_results_sim_vs_star_${label}.txt

# simpleaf alevin-fry:

## splici - Sketch
python3 comparisons.py samples/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneNo/truth.mtx genomes/human_CR_3.0.0/genes.tsv data/whitelists/10Xv3 \
count_${label}/simpleaf-salmon_0.15.1_1.10.0/human_CR_3.0.0/splici/sketch_crlike/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneNo/20/run1/quant/af_quant/alevin/quants_mat.mtx \
count_${label}/simpleaf-salmon_0.15.1_1.10.0/human_CR_3.0.0/splici/sketch_crlike/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneNo/20/run1/quant/af_quant/alevin/quants_mat_cols.txt \
count_${label}/simpleaf-salmon_0.15.1_1.10.0/human_CR_3.0.0/splici/sketch_crlike/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneNo/20/run1/quant/af_quant/alevin/quants_mat_rows.txt \
results_mut/results_sim_vs_af_splici_sketch_crlike_sa_${label}.txt --barcodes sim_barcodes.txt --usa-sa

cat count_${label}/simpleaf-salmon_0.15.1_1.10.0/human_CR_3.0.0/splici/sketch_crlike/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneNo/20/run1/quant/af_map/logs/salmon_quant.log|grep "Selectively-aligned"|awk -F'Selectively-aligned ' '{print $2}'|cut -d' ' -f1,6 > results_mut/_results_sim_vs_af_splici_sketch_crlike_sa_${label}.txt

## splici - RAD
python3 comparisons.py samples/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneNo/truth.mtx genomes/human_CR_3.0.0/genes.tsv data/whitelists/10Xv3 \
count_${label}/simpleaf-salmon_0.15.1_1.10.0/human_CR_3.0.0/splici/rad_crlike/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneNo/20/run1/quant/af_quant/alevin/quants_mat.mtx \
count_${label}/simpleaf-salmon_0.15.1_1.10.0/human_CR_3.0.0/splici/rad_crlike/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneNo/20/run1/quant/af_quant/alevin/quants_mat_cols.txt \
count_${label}/simpleaf-salmon_0.15.1_1.10.0/human_CR_3.0.0/splici/rad_crlike/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneNo/20/run1/quant/af_quant/alevin/quants_mat_rows.txt \
results_mut/results_sim_vs_af_splici_rad_crlike_sa_${label}.txt --barcodes sim_barcodes.txt --usa-sa

cat count_${label}/simpleaf-salmon_0.15.1_1.10.0/human_CR_3.0.0/splici/rad_crlike/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneNo/20/run1/quant/af_map/logs/salmon_quant.log|grep "Selectively-aligned"|awk -F'Selectively-aligned ' '{print $2}'|cut -d' ' -f1,6 > results_mut/_results_sim_vs_af_splici_rad_crlike_sa_${label}.txt

