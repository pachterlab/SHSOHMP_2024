#!/bin/sh


mkdir -p results_other/cr7/

python3 comparisons.py samples/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneNo/truth.mtx genomes/human_CR_3.0.0/genes.tsv data/whitelists/10Xv3 \
<(zcat output_cellranger_7/outs/raw_feature_bc_matrix/matrix.mtx.gz) \
<(zcat output_cellranger_7/outs/raw_feature_bc_matrix/features.tsv.gz) \
<(zcat output_cellranger_7/outs/raw_feature_bc_matrix/barcodes.tsv.gz|cut -d'-' -f1) \
results_other/cr7/results_sim_vs_cr.txt --barcodes sim_barcodes.txt --transpose


python3 comparisons.py samples/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneYes/truth.mtx genomes/human_CR_3.0.0/genes.tsv data/whitelists/10Xv3 \
<(zcat output_cellranger_7_multigene/outs/raw_feature_bc_matrix/matrix.mtx.gz) \
<(zcat output_cellranger_7_multigene/outs/raw_feature_bc_matrix/features.tsv.gz) \
<(zcat output_cellranger_7_multigene/outs/raw_feature_bc_matrix/barcodes.tsv.gz|cut -d'-' -f1) \
results_other/cr7/results_sim_vs_cr_mult.txt --barcodes sim_barcodes.txt --transpose


python3 comparisons.py samples/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneNo_OnlyExonicReads/truth.mtx genomes/human_CR_3.0.0/genes.tsv data/whitelists/10Xv3 \
<(zcat output_cellranger_7_exononly/outs/raw_feature_bc_matrix/matrix.mtx.gz) \
<(zcat output_cellranger_7_exononly/outs/raw_feature_bc_matrix/features.tsv.gz) \
<(zcat output_cellranger_7_exononly/outs/raw_feature_bc_matrix/barcodes.tsv.gz|cut -d'-' -f1) \
results_other/cr7/results_sim_vs_cr_exon.txt --barcodes sim_barcodes.txt --transpose

mkdir -p results_other/cc/

python3 comparisons.py samples/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneNo/truth.mtx genomes/human_CR_3.0.0/genes.tsv data/whitelists/10Xv3 \
output_cellCounts/matrix.mtx \
output_cellCounts/features.tsv \
output_cellCounts/barcodes.tsv \
results_other/cc/results_sim_vs_cc.txt --barcodes sim_barcodes.txt --transpose

python3 comparisons.py samples/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneYes/truth.mtx genomes/human_CR_3.0.0/genes.tsv data/whitelists/10Xv3 \
output_cellCounts_mult/matrix.mtx \
output_cellCounts_mult/features.tsv \
output_cellCounts_mult/barcodes.tsv \
results_other/cc/results_sim_vs_cc_mult.txt --barcodes sim_barcodes.txt --transpose

python3 comparisons.py samples/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneNo_OnlyExonicReads/truth.mtx genomes/human_CR_3.0.0/genes.tsv data/whitelists/10Xv3 \
output_cellCounts_exon/matrix.mtx \
output_cellCounts_exon/features.tsv \
output_cellCounts_exon/barcodes.tsv \
results_other/cc/results_sim_vs_cc_exon.txt --barcodes sim_barcodes.txt --transpose


