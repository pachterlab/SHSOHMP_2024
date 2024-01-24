#!/bin/sh

mkdir -p results_other/af/

# No multi-gene

## splici - RAD

python3 comparisons.py samples/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneNo/truth.mtx genomes/human_CR_3.0.0/genes.tsv data/whitelists/10Xv3 \
count/simpleaf-salmon_0.15.1_1.10.0/human_CR_3.0.0/splici/rad_crlike/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneNo/20/run1/quant/af_quant/alevin/quants_mat.mtx \
count/simpleaf-salmon_0.15.1_1.10.0/human_CR_3.0.0/splici/rad_crlike/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneNo/20/run1/quant/af_quant/alevin/quants_mat_cols.txt \
count/simpleaf-salmon_0.15.1_1.10.0/human_CR_3.0.0/splici/rad_crlike/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneNo/20/run1/quant/af_quant/alevin/quants_mat_rows.txt \
results_other/af/results_sim_vs_af_splici_rad_crlike_sa.txt --barcodes sim_barcodes.txt --usa-sa

python3 comparisons.py samples/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneNo/truth.mtx genomes/human_CR_3.0.0/genes.tsv data/whitelists/10Xv3 \
count/simpleaf-salmon_0.15.1_1.10.0/human_CR_3.0.0/splici/rad_crlike/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneNo/20/run1/quant/af_quant/alevin/quants_mat.mtx \
count/simpleaf-salmon_0.15.1_1.10.0/human_CR_3.0.0/splici/rad_crlike/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneNo/20/run1/quant/af_quant/alevin/quants_mat_cols.txt \
count/simpleaf-salmon_0.15.1_1.10.0/human_CR_3.0.0/splici/rad_crlike/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneNo/20/run1/quant/af_quant/alevin/quants_mat_rows.txt \
results_other/af/results_sim_vs_af_splici_rad_crlike_usa.txt --barcodes sim_barcodes.txt --usa-usa

python3 comparisons.py samples/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneNo/truth.mtx genomes/human_CR_3.0.0/genes.tsv data/whitelists/10Xv3 \
count/simpleaf-salmon_0.15.1_1.10.0/human_CR_3.0.0/splici/rad_crlikeem/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneNo/20/run1/quant/af_quant/alevin/quants_mat.mtx \
count/simpleaf-salmon_0.15.1_1.10.0/human_CR_3.0.0/splici/rad_crlikeem/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneNo/20/run1/quant/af_quant/alevin/quants_mat_cols.txt \
count/simpleaf-salmon_0.15.1_1.10.0/human_CR_3.0.0/splici/rad_crlikeem/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneNo/20/run1/quant/af_quant/alevin/quants_mat_rows.txt \
results_other/af/results_sim_vs_af_splici_rad_crlikeem_sa.txt --barcodes sim_barcodes.txt --usa-sa

python3 comparisons.py samples/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneNo/truth.mtx genomes/human_CR_3.0.0/genes.tsv data/whitelists/10Xv3 \
count/simpleaf-salmon_0.15.1_1.10.0/human_CR_3.0.0/splici/rad_crlikeem/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneNo/20/run1/quant/af_quant/alevin/quants_mat.mtx \
count/simpleaf-salmon_0.15.1_1.10.0/human_CR_3.0.0/splici/rad_crlikeem/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneNo/20/run1/quant/af_quant/alevin/quants_mat_cols.txt \
count/simpleaf-salmon_0.15.1_1.10.0/human_CR_3.0.0/splici/rad_crlikeem/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneNo/20/run1/quant/af_quant/alevin/quants_mat_rows.txt \
results_other/af/results_sim_vs_af_splici_rad_crlikeem_usa.txt --barcodes sim_barcodes.txt --usa-usa

## splici - Sketch

python3 comparisons.py samples/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneNo/truth.mtx genomes/human_CR_3.0.0/genes.tsv data/whitelists/10Xv3 \
count/simpleaf-salmon_0.15.1_1.10.0/human_CR_3.0.0/splici/sketch_crlike/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneNo/20/run1/quant/af_quant/alevin/quants_mat.mtx \
count/simpleaf-salmon_0.15.1_1.10.0/human_CR_3.0.0/splici/sketch_crlike/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneNo/20/run1/quant/af_quant/alevin/quants_mat_cols.txt \
count/simpleaf-salmon_0.15.1_1.10.0/human_CR_3.0.0/splici/sketch_crlike/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneNo/20/run1/quant/af_quant/alevin/quants_mat_rows.txt \
results_other/af/results_sim_vs_af_splici_sketch_crlike_sa.txt --barcodes sim_barcodes.txt --usa-sa

python3 comparisons.py samples/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneNo/truth.mtx genomes/human_CR_3.0.0/genes.tsv data/whitelists/10Xv3 \
count/simpleaf-salmon_0.15.1_1.10.0/human_CR_3.0.0/splici/sketch_crlike/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneNo/20/run1/quant/af_quant/alevin/quants_mat.mtx \
count/simpleaf-salmon_0.15.1_1.10.0/human_CR_3.0.0/splici/sketch_crlike/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneNo/20/run1/quant/af_quant/alevin/quants_mat_cols.txt \
count/simpleaf-salmon_0.15.1_1.10.0/human_CR_3.0.0/splici/sketch_crlike/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneNo/20/run1/quant/af_quant/alevin/quants_mat_rows.txt \
results_other/af/results_sim_vs_af_splici_sketch_crlike_usa.txt --barcodes sim_barcodes.txt --usa-usa

python3 comparisons.py samples/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneNo/truth.mtx genomes/human_CR_3.0.0/genes.tsv data/whitelists/10Xv3 \
count/simpleaf-salmon_0.15.1_1.10.0/human_CR_3.0.0/splici/sketch_crlikeem/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneNo/20/run1/quant/af_quant/alevin/quants_mat.mtx \
count/simpleaf-salmon_0.15.1_1.10.0/human_CR_3.0.0/splici/sketch_crlikeem/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneNo/20/run1/quant/af_quant/alevin/quants_mat_cols.txt \
count/simpleaf-salmon_0.15.1_1.10.0/human_CR_3.0.0/splici/sketch_crlikeem/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneNo/20/run1/quant/af_quant/alevin/quants_mat_rows.txt \
results_other/af/results_sim_vs_af_splici_sketch_crlikeem_sa.txt --barcodes sim_barcodes.txt --usa-sa

python3 comparisons.py samples/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneNo/truth.mtx genomes/human_CR_3.0.0/genes.tsv data/whitelists/10Xv3 \
count/simpleaf-salmon_0.15.1_1.10.0/human_CR_3.0.0/splici/sketch_crlikeem/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneNo/20/run1/quant/af_quant/alevin/quants_mat.mtx \
count/simpleaf-salmon_0.15.1_1.10.0/human_CR_3.0.0/splici/sketch_crlikeem/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneNo/20/run1/quant/af_quant/alevin/quants_mat_cols.txt \
count/simpleaf-salmon_0.15.1_1.10.0/human_CR_3.0.0/splici/sketch_crlikeem/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneNo/20/run1/quant/af_quant/alevin/quants_mat_rows.txt \
results_other/af/results_sim_vs_af_splici_sketch_crlikeem_usa.txt --barcodes sim_barcodes.txt --usa-usa

## standard - RAD

python3 comparisons.py samples/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneNo/truth.mtx genomes/human_CR_3.0.0/genes.tsv data/whitelists/10Xv3 \
count/simpleaf-salmon_0.15.1_1.10.0/human_CR_3.0.0/standard/rad_crlike/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneNo/20/run1/quant/af_quant/alevin/quants_mat.mtx \
count/simpleaf-salmon_0.15.1_1.10.0/human_CR_3.0.0/standard/rad_crlike/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneNo/20/run1/quant/af_quant/alevin/quants_mat_cols.txt \
count/simpleaf-salmon_0.15.1_1.10.0/human_CR_3.0.0/standard/rad_crlike/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneNo/20/run1/quant/af_quant/alevin/quants_mat_rows.txt \
results_other/af/results_sim_vs_af_standard_rad_crlike.txt --barcodes sim_barcodes.txt


python3 comparisons.py samples/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneNo/truth.mtx genomes/human_CR_3.0.0/genes.tsv data/whitelists/10Xv3 \
count/simpleaf-salmon_0.15.1_1.10.0/human_CR_3.0.0/standard/rad_crlikeem/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneNo/20/run1/quant/af_quant/alevin/quants_mat.mtx \
count/simpleaf-salmon_0.15.1_1.10.0/human_CR_3.0.0/standard/rad_crlikeem/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneNo/20/run1/quant/af_quant/alevin/quants_mat_cols.txt \
count/simpleaf-salmon_0.15.1_1.10.0/human_CR_3.0.0/standard/rad_crlikeem/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneNo/20/run1/quant/af_quant/alevin/quants_mat_rows.txt \
results_other/af/results_sim_vs_af_standard_rad_crlikeem.txt --barcodes sim_barcodes.txt

## standard - Sketch

python3 comparisons.py samples/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneNo/truth.mtx genomes/human_CR_3.0.0/genes.tsv data/whitelists/10Xv3 \
count/simpleaf-salmon_0.15.1_1.10.0/human_CR_3.0.0/standard/sketch_crlike/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneNo/20/run1/quant/af_quant/alevin/quants_mat.mtx \
count/simpleaf-salmon_0.15.1_1.10.0/human_CR_3.0.0/standard/sketch_crlike/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneNo/20/run1/quant/af_quant/alevin/quants_mat_cols.txt \
count/simpleaf-salmon_0.15.1_1.10.0/human_CR_3.0.0/standard/sketch_crlike/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneNo/20/run1/quant/af_quant/alevin/quants_mat_rows.txt \
results_other/af/results_sim_vs_af_standard_sketch_crlike.txt --barcodes sim_barcodes.txt

python3 comparisons.py samples/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneNo/truth.mtx genomes/human_CR_3.0.0/genes.tsv data/whitelists/10Xv3 \
count/simpleaf-salmon_0.15.1_1.10.0/human_CR_3.0.0/standard/sketch_crlikeem/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneNo/20/run1/quant/af_quant/alevin/quants_mat.mtx \
count/simpleaf-salmon_0.15.1_1.10.0/human_CR_3.0.0/standard/sketch_crlikeem/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneNo/20/run1/quant/af_quant/alevin/quants_mat_cols.txt \
count/simpleaf-salmon_0.15.1_1.10.0/human_CR_3.0.0/standard/sketch_crlikeem/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneNo/20/run1/quant/af_quant/alevin/quants_mat_rows.txt \
results_other/af/results_sim_vs_af_standard_sketch_crlikeem.txt --barcodes sim_barcodes.txt


# Multi-gene

## splici - RAD

python3 comparisons.py samples/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneYes/truth.mtx genomes/human_CR_3.0.0/genes.tsv data/whitelists/10Xv3 \
count/simpleaf-salmon_0.15.1_1.10.0/human_CR_3.0.0/splici/rad_crlike/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneYes/20/run1/quant/af_quant/alevin/quants_mat.mtx \
count/simpleaf-salmon_0.15.1_1.10.0/human_CR_3.0.0/splici/rad_crlike/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneYes/20/run1/quant/af_quant/alevin/quants_mat_cols.txt \
count/simpleaf-salmon_0.15.1_1.10.0/human_CR_3.0.0/splici/rad_crlike/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneYes/20/run1/quant/af_quant/alevin/quants_mat_rows.txt \
results_other/af/results_sim_vs_af_splici_rad_crlike_sa_mult.txt --barcodes sim_barcodes.txt --usa-sa

python3 comparisons.py samples/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneYes/truth.mtx genomes/human_CR_3.0.0/genes.tsv data/whitelists/10Xv3 \
count/simpleaf-salmon_0.15.1_1.10.0/human_CR_3.0.0/splici/rad_crlike/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneYes/20/run1/quant/af_quant/alevin/quants_mat.mtx \
count/simpleaf-salmon_0.15.1_1.10.0/human_CR_3.0.0/splici/rad_crlike/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneYes/20/run1/quant/af_quant/alevin/quants_mat_cols.txt \
count/simpleaf-salmon_0.15.1_1.10.0/human_CR_3.0.0/splici/rad_crlike/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneYes/20/run1/quant/af_quant/alevin/quants_mat_rows.txt \
results_other/af/results_sim_vs_af_splici_rad_crlike_usa_mult.txt --barcodes sim_barcodes.txt --usa-usa

python3 comparisons.py samples/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneYes/truth.mtx genomes/human_CR_3.0.0/genes.tsv data/whitelists/10Xv3 \
count/simpleaf-salmon_0.15.1_1.10.0/human_CR_3.0.0/splici/rad_crlikeem/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneYes/20/run1/quant/af_quant/alevin/quants_mat.mtx \
count/simpleaf-salmon_0.15.1_1.10.0/human_CR_3.0.0/splici/rad_crlikeem/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneYes/20/run1/quant/af_quant/alevin/quants_mat_cols.txt \
count/simpleaf-salmon_0.15.1_1.10.0/human_CR_3.0.0/splici/rad_crlikeem/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneYes/20/run1/quant/af_quant/alevin/quants_mat_rows.txt \
results_other/af/results_sim_vs_af_splici_rad_crlikeem_sa_mult.txt --barcodes sim_barcodes.txt --usa-sa

python3 comparisons.py samples/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneYes/truth.mtx genomes/human_CR_3.0.0/genes.tsv data/whitelists/10Xv3 \
count/simpleaf-salmon_0.15.1_1.10.0/human_CR_3.0.0/splici/rad_crlikeem/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneYes/20/run1/quant/af_quant/alevin/quants_mat.mtx \
count/simpleaf-salmon_0.15.1_1.10.0/human_CR_3.0.0/splici/rad_crlikeem/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneYes/20/run1/quant/af_quant/alevin/quants_mat_cols.txt \
count/simpleaf-salmon_0.15.1_1.10.0/human_CR_3.0.0/splici/rad_crlikeem/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneYes/20/run1/quant/af_quant/alevin/quants_mat_rows.txt \
results_other/af/results_sim_vs_af_splici_rad_crlikeem_usa_mult.txt --barcodes sim_barcodes.txt --usa-usa

## splici - Sketch

python3 comparisons.py samples/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneYes/truth.mtx genomes/human_CR_3.0.0/genes.tsv data/whitelists/10Xv3 \
count/simpleaf-salmon_0.15.1_1.10.0/human_CR_3.0.0/splici/sketch_crlike/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneYes/20/run1/quant/af_quant/alevin/quants_mat.mtx \
count/simpleaf-salmon_0.15.1_1.10.0/human_CR_3.0.0/splici/sketch_crlike/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneYes/20/run1/quant/af_quant/alevin/quants_mat_cols.txt \
count/simpleaf-salmon_0.15.1_1.10.0/human_CR_3.0.0/splici/sketch_crlike/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneYes/20/run1/quant/af_quant/alevin/quants_mat_rows.txt \
results_other/af/results_sim_vs_af_splici_sketch_crlike_sa_mult.txt --barcodes sim_barcodes.txt --usa-sa

python3 comparisons.py samples/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneYes/truth.mtx genomes/human_CR_3.0.0/genes.tsv data/whitelists/10Xv3 \
count/simpleaf-salmon_0.15.1_1.10.0/human_CR_3.0.0/splici/sketch_crlike/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneYes/20/run1/quant/af_quant/alevin/quants_mat.mtx \
count/simpleaf-salmon_0.15.1_1.10.0/human_CR_3.0.0/splici/sketch_crlike/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneYes/20/run1/quant/af_quant/alevin/quants_mat_cols.txt \
count/simpleaf-salmon_0.15.1_1.10.0/human_CR_3.0.0/splici/sketch_crlike/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneYes/20/run1/quant/af_quant/alevin/quants_mat_rows.txt \
results_other/af/results_sim_vs_af_splici_sketch_crlike_usa_mult.txt --barcodes sim_barcodes.txt --usa-usa

python3 comparisons.py samples/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneYes/truth.mtx genomes/human_CR_3.0.0/genes.tsv data/whitelists/10Xv3 \
count/simpleaf-salmon_0.15.1_1.10.0/human_CR_3.0.0/splici/sketch_crlikeem/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneYes/20/run1/quant/af_quant/alevin/quants_mat.mtx \
count/simpleaf-salmon_0.15.1_1.10.0/human_CR_3.0.0/splici/sketch_crlikeem/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneYes/20/run1/quant/af_quant/alevin/quants_mat_cols.txt \
count/simpleaf-salmon_0.15.1_1.10.0/human_CR_3.0.0/splici/sketch_crlikeem/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneYes/20/run1/quant/af_quant/alevin/quants_mat_rows.txt \
results_other/af/results_sim_vs_af_splici_sketch_crlikeem_sa_mult.txt --barcodes sim_barcodes.txt --usa-sa

python3 comparisons.py samples/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneYes/truth.mtx genomes/human_CR_3.0.0/genes.tsv data/whitelists/10Xv3 \
count/simpleaf-salmon_0.15.1_1.10.0/human_CR_3.0.0/splici/sketch_crlikeem/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneYes/20/run1/quant/af_quant/alevin/quants_mat.mtx \
count/simpleaf-salmon_0.15.1_1.10.0/human_CR_3.0.0/splici/sketch_crlikeem/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneYes/20/run1/quant/af_quant/alevin/quants_mat_cols.txt \
count/simpleaf-salmon_0.15.1_1.10.0/human_CR_3.0.0/splici/sketch_crlikeem/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneYes/20/run1/quant/af_quant/alevin/quants_mat_rows.txt \
results_other/af/results_sim_vs_af_splici_sketch_crlikeem_usa_mult.txt --barcodes sim_barcodes.txt --usa-usa

## standard - RAD

python3 comparisons.py samples/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneYes/truth.mtx genomes/human_CR_3.0.0/genes.tsv data/whitelists/10Xv3 \
count/simpleaf-salmon_0.15.1_1.10.0/human_CR_3.0.0/standard/rad_crlike/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneYes/20/run1/quant/af_quant/alevin/quants_mat.mtx \
count/simpleaf-salmon_0.15.1_1.10.0/human_CR_3.0.0/standard/rad_crlike/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneYes/20/run1/quant/af_quant/alevin/quants_mat_cols.txt \
count/simpleaf-salmon_0.15.1_1.10.0/human_CR_3.0.0/standard/rad_crlike/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneYes/20/run1/quant/af_quant/alevin/quants_mat_rows.txt \
results_other/af/results_sim_vs_af_standard_rad_crlike_mult.txt --barcodes sim_barcodes.txt


python3 comparisons.py samples/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneYes/truth.mtx genomes/human_CR_3.0.0/genes.tsv data/whitelists/10Xv3 \
count/simpleaf-salmon_0.15.1_1.10.0/human_CR_3.0.0/standard/rad_crlikeem/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneYes/20/run1/quant/af_quant/alevin/quants_mat.mtx \
count/simpleaf-salmon_0.15.1_1.10.0/human_CR_3.0.0/standard/rad_crlikeem/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneYes/20/run1/quant/af_quant/alevin/quants_mat_cols.txt \
count/simpleaf-salmon_0.15.1_1.10.0/human_CR_3.0.0/standard/rad_crlikeem/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneYes/20/run1/quant/af_quant/alevin/quants_mat_rows.txt \
results_other/af/results_sim_vs_af_standard_rad_crlikeem_mult.txt --barcodes sim_barcodes.txt

## standard - Sketch

python3 comparisons.py samples/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneYes/truth.mtx genomes/human_CR_3.0.0/genes.tsv data/whitelists/10Xv3 \
count/simpleaf-salmon_0.15.1_1.10.0/human_CR_3.0.0/standard/sketch_crlike/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneYes/20/run1/quant/af_quant/alevin/quants_mat.mtx \
count/simpleaf-salmon_0.15.1_1.10.0/human_CR_3.0.0/standard/sketch_crlike/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneYes/20/run1/quant/af_quant/alevin/quants_mat_cols.txt \
count/simpleaf-salmon_0.15.1_1.10.0/human_CR_3.0.0/standard/sketch_crlike/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneYes/20/run1/quant/af_quant/alevin/quants_mat_rows.txt \
results_other/af/results_sim_vs_af_standard_sketch_crlike_mult.txt --barcodes sim_barcodes.txt

python3 comparisons.py samples/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneYes/truth.mtx genomes/human_CR_3.0.0/genes.tsv data/whitelists/10Xv3 \
count/simpleaf-salmon_0.15.1_1.10.0/human_CR_3.0.0/standard/sketch_crlikeem/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneYes/20/run1/quant/af_quant/alevin/quants_mat.mtx \
count/simpleaf-salmon_0.15.1_1.10.0/human_CR_3.0.0/standard/sketch_crlikeem/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneYes/20/run1/quant/af_quant/alevin/quants_mat_cols.txt \
count/simpleaf-salmon_0.15.1_1.10.0/human_CR_3.0.0/standard/sketch_crlikeem/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneYes/20/run1/quant/af_quant/alevin/quants_mat_rows.txt \
results_other/af/results_sim_vs_af_standard_sketch_crlikeem_mult.txt --barcodes sim_barcodes.txt


# Exon-only

## splici - RAD

python3 comparisons.py samples/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneNo_OnlyExonicReads/truth.mtx genomes/human_CR_3.0.0/genes.tsv data/whitelists/10Xv3 \
count/simpleaf-salmon_0.15.1_1.10.0/human_CR_3.0.0/splici/rad_crlike/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneNo_OnlyExonicReads/20/run1/quant/af_quant/alevin/quants_mat.mtx \
count/simpleaf-salmon_0.15.1_1.10.0/human_CR_3.0.0/splici/rad_crlike/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneNo_OnlyExonicReads/20/run1/quant/af_quant/alevin/quants_mat_cols.txt \
count/simpleaf-salmon_0.15.1_1.10.0/human_CR_3.0.0/splici/rad_crlike/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneNo_OnlyExonicReads/20/run1/quant/af_quant/alevin/quants_mat_rows.txt \
results_other/af/results_sim_vs_af_splici_rad_crlike_sa_exon.txt --barcodes sim_barcodes.txt --usa-sa

python3 comparisons.py samples/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneNo_OnlyExonicReads/truth.mtx genomes/human_CR_3.0.0/genes.tsv data/whitelists/10Xv3 \
count/simpleaf-salmon_0.15.1_1.10.0/human_CR_3.0.0/splici/rad_crlike/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneNo_OnlyExonicReads/20/run1/quant/af_quant/alevin/quants_mat.mtx \
count/simpleaf-salmon_0.15.1_1.10.0/human_CR_3.0.0/splici/rad_crlike/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneNo_OnlyExonicReads/20/run1/quant/af_quant/alevin/quants_mat_cols.txt \
count/simpleaf-salmon_0.15.1_1.10.0/human_CR_3.0.0/splici/rad_crlike/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneNo_OnlyExonicReads/20/run1/quant/af_quant/alevin/quants_mat_rows.txt \
results_other/af/results_sim_vs_af_splici_rad_crlike_usa_exon.txt --barcodes sim_barcodes.txt --usa-usa

python3 comparisons.py samples/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneNo_OnlyExonicReads/truth.mtx genomes/human_CR_3.0.0/genes.tsv data/whitelists/10Xv3 \
count/simpleaf-salmon_0.15.1_1.10.0/human_CR_3.0.0/splici/rad_crlikeem/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneNo_OnlyExonicReads/20/run1/quant/af_quant/alevin/quants_mat.mtx \
count/simpleaf-salmon_0.15.1_1.10.0/human_CR_3.0.0/splici/rad_crlikeem/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneNo_OnlyExonicReads/20/run1/quant/af_quant/alevin/quants_mat_cols.txt \
count/simpleaf-salmon_0.15.1_1.10.0/human_CR_3.0.0/splici/rad_crlikeem/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneNo_OnlyExonicReads/20/run1/quant/af_quant/alevin/quants_mat_rows.txt \
results_other/af/results_sim_vs_af_splici_rad_crlikeem_sa_exon.txt --barcodes sim_barcodes.txt --usa-sa

python3 comparisons.py samples/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneNo_OnlyExonicReads/truth.mtx genomes/human_CR_3.0.0/genes.tsv data/whitelists/10Xv3 \
count/simpleaf-salmon_0.15.1_1.10.0/human_CR_3.0.0/splici/rad_crlikeem/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneNo_OnlyExonicReads/20/run1/quant/af_quant/alevin/quants_mat.mtx \
count/simpleaf-salmon_0.15.1_1.10.0/human_CR_3.0.0/splici/rad_crlikeem/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneNo_OnlyExonicReads/20/run1/quant/af_quant/alevin/quants_mat_cols.txt \
count/simpleaf-salmon_0.15.1_1.10.0/human_CR_3.0.0/splici/rad_crlikeem/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneNo_OnlyExonicReads/20/run1/quant/af_quant/alevin/quants_mat_rows.txt \
results_other/af/results_sim_vs_af_splici_rad_crlikeem_usa_exon.txt --barcodes sim_barcodes.txt --usa-usa

## splici - Sketch

python3 comparisons.py samples/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneNo_OnlyExonicReads/truth.mtx genomes/human_CR_3.0.0/genes.tsv data/whitelists/10Xv3 \
count/simpleaf-salmon_0.15.1_1.10.0/human_CR_3.0.0/splici/sketch_crlike/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneNo_OnlyExonicReads/20/run1/quant/af_quant/alevin/quants_mat.mtx \
count/simpleaf-salmon_0.15.1_1.10.0/human_CR_3.0.0/splici/sketch_crlike/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneNo_OnlyExonicReads/20/run1/quant/af_quant/alevin/quants_mat_cols.txt \
count/simpleaf-salmon_0.15.1_1.10.0/human_CR_3.0.0/splici/sketch_crlike/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneNo_OnlyExonicReads/20/run1/quant/af_quant/alevin/quants_mat_rows.txt \
results_other/af/results_sim_vs_af_splici_sketch_crlike_sa_exon.txt --barcodes sim_barcodes.txt --usa-sa

python3 comparisons.py samples/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneNo_OnlyExonicReads/truth.mtx genomes/human_CR_3.0.0/genes.tsv data/whitelists/10Xv3 \
count/simpleaf-salmon_0.15.1_1.10.0/human_CR_3.0.0/splici/sketch_crlike/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneNo_OnlyExonicReads/20/run1/quant/af_quant/alevin/quants_mat.mtx \
count/simpleaf-salmon_0.15.1_1.10.0/human_CR_3.0.0/splici/sketch_crlike/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneNo_OnlyExonicReads/20/run1/quant/af_quant/alevin/quants_mat_cols.txt \
count/simpleaf-salmon_0.15.1_1.10.0/human_CR_3.0.0/splici/sketch_crlike/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneNo_OnlyExonicReads/20/run1/quant/af_quant/alevin/quants_mat_rows.txt \
results_other/af/results_sim_vs_af_splici_sketch_crlike_usa_exon.txt --barcodes sim_barcodes.txt --usa-usa

python3 comparisons.py samples/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneNo_OnlyExonicReads/truth.mtx genomes/human_CR_3.0.0/genes.tsv data/whitelists/10Xv3 \
count/simpleaf-salmon_0.15.1_1.10.0/human_CR_3.0.0/splici/sketch_crlikeem/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneNo_OnlyExonicReads/20/run1/quant/af_quant/alevin/quants_mat.mtx \
count/simpleaf-salmon_0.15.1_1.10.0/human_CR_3.0.0/splici/sketch_crlikeem/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneNo_OnlyExonicReads/20/run1/quant/af_quant/alevin/quants_mat_cols.txt \
count/simpleaf-salmon_0.15.1_1.10.0/human_CR_3.0.0/splici/sketch_crlikeem/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneNo_OnlyExonicReads/20/run1/quant/af_quant/alevin/quants_mat_rows.txt \
results_other/af/results_sim_vs_af_splici_sketch_crlikeem_sa_exon.txt --barcodes sim_barcodes.txt --usa-sa

python3 comparisons.py samples/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneNo_OnlyExonicReads/truth.mtx genomes/human_CR_3.0.0/genes.tsv data/whitelists/10Xv3 \
count/simpleaf-salmon_0.15.1_1.10.0/human_CR_3.0.0/splici/sketch_crlikeem/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneNo_OnlyExonicReads/20/run1/quant/af_quant/alevin/quants_mat.mtx \
count/simpleaf-salmon_0.15.1_1.10.0/human_CR_3.0.0/splici/sketch_crlikeem/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneNo_OnlyExonicReads/20/run1/quant/af_quant/alevin/quants_mat_cols.txt \
count/simpleaf-salmon_0.15.1_1.10.0/human_CR_3.0.0/splici/sketch_crlikeem/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneNo_OnlyExonicReads/20/run1/quant/af_quant/alevin/quants_mat_rows.txt \
results_other/af/results_sim_vs_af_splici_sketch_crlikeem_usa_exon.txt --barcodes sim_barcodes.txt --usa-usa

## standard - RAD

python3 comparisons.py samples/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneNo_OnlyExonicReads/truth.mtx genomes/human_CR_3.0.0/genes.tsv data/whitelists/10Xv3 \
count/simpleaf-salmon_0.15.1_1.10.0/human_CR_3.0.0/standard/rad_crlike/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneNo_OnlyExonicReads/20/run1/quant/af_quant/alevin/quants_mat.mtx \
count/simpleaf-salmon_0.15.1_1.10.0/human_CR_3.0.0/standard/rad_crlike/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneNo_OnlyExonicReads/20/run1/quant/af_quant/alevin/quants_mat_cols.txt \
count/simpleaf-salmon_0.15.1_1.10.0/human_CR_3.0.0/standard/rad_crlike/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneNo_OnlyExonicReads/20/run1/quant/af_quant/alevin/quants_mat_rows.txt \
results_other/af/results_sim_vs_af_standard_rad_crlike_exon.txt --barcodes sim_barcodes.txt


python3 comparisons.py samples/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneNo_OnlyExonicReads/truth.mtx genomes/human_CR_3.0.0/genes.tsv data/whitelists/10Xv3 \
count/simpleaf-salmon_0.15.1_1.10.0/human_CR_3.0.0/standard/rad_crlikeem/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneNo_OnlyExonicReads/20/run1/quant/af_quant/alevin/quants_mat.mtx \
count/simpleaf-salmon_0.15.1_1.10.0/human_CR_3.0.0/standard/rad_crlikeem/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneNo_OnlyExonicReads/20/run1/quant/af_quant/alevin/quants_mat_cols.txt \
count/simpleaf-salmon_0.15.1_1.10.0/human_CR_3.0.0/standard/rad_crlikeem/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneNo_OnlyExonicReads/20/run1/quant/af_quant/alevin/quants_mat_rows.txt \
results_other/af/results_sim_vs_af_standard_rad_crlikeem_exon.txt --barcodes sim_barcodes.txt

## standard - Sketch

python3 comparisons.py samples/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneNo_OnlyExonicReads/truth.mtx genomes/human_CR_3.0.0/genes.tsv data/whitelists/10Xv3 \
count/simpleaf-salmon_0.15.1_1.10.0/human_CR_3.0.0/standard/sketch_crlike/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneNo_OnlyExonicReads/20/run1/quant/af_quant/alevin/quants_mat.mtx \
count/simpleaf-salmon_0.15.1_1.10.0/human_CR_3.0.0/standard/sketch_crlike/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneNo_OnlyExonicReads/20/run1/quant/af_quant/alevin/quants_mat_cols.txt \
count/simpleaf-salmon_0.15.1_1.10.0/human_CR_3.0.0/standard/sketch_crlike/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneNo_OnlyExonicReads/20/run1/quant/af_quant/alevin/quants_mat_rows.txt \
results_other/af/results_sim_vs_af_standard_sketch_crlike_exon.txt --barcodes sim_barcodes.txt

python3 comparisons.py samples/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneNo_OnlyExonicReads/truth.mtx genomes/human_CR_3.0.0/genes.tsv data/whitelists/10Xv3 \
count/simpleaf-salmon_0.15.1_1.10.0/human_CR_3.0.0/standard/sketch_crlikeem/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneNo_OnlyExonicReads/20/run1/quant/af_quant/alevin/quants_mat.mtx \
count/simpleaf-salmon_0.15.1_1.10.0/human_CR_3.0.0/standard/sketch_crlikeem/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneNo_OnlyExonicReads/20/run1/quant/af_quant/alevin/quants_mat_cols.txt \
count/simpleaf-salmon_0.15.1_1.10.0/human_CR_3.0.0/standard/sketch_crlikeem/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneNo_OnlyExonicReads/20/run1/quant/af_quant/alevin/quants_mat_rows.txt \
results_other/af/results_sim_vs_af_standard_sketch_crlikeem_exon.txt --barcodes sim_barcodes.txt



