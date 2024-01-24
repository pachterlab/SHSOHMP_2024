#!/bin/sh

mkdir -p results_other/star/

python3 comparisons.py samples/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneNo/truth.mtx genomes/human_CR_3.0.0/genes.tsv data/whitelists/10Xv3 \
count/STAR_2.7.9a/human_CR_3.0.0/fullSA/10X_noSAM_sims_mult_ENCODE/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneNo/20/run1/Solo.out/Gene/raw/matrix.mtx \
count/STAR_2.7.9a/human_CR_3.0.0/fullSA/10X_noSAM_sims_mult_ENCODE/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneNo/20/run1/Solo.out/Gene/raw/features.tsv \
count/STAR_2.7.9a/human_CR_3.0.0/fullSA/10X_noSAM_sims_mult_ENCODE/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneNo/20/run1/Solo.out/Gene/raw/barcodes.tsv \
results_other/star/results_sim_vs_star.txt --barcodes sim_barcodes.txt --transpose


python3 comparisons.py samples/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneYes/truth.mtx genomes/human_CR_3.0.0/genes.tsv data/whitelists/10Xv3 \
count/STAR_2.7.9a/human_CR_3.0.0/fullSA/10X_noSAM_sims_mult_ENCODE/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneYes/20/run1/Solo.out/Gene/raw/UniqueAndMult-Uniform.mtx \
count/STAR_2.7.9a/human_CR_3.0.0/fullSA/10X_noSAM_sims_mult_ENCODE/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneYes/20/run1/Solo.out/Gene/raw/features.tsv \
count/STAR_2.7.9a/human_CR_3.0.0/fullSA/10X_noSAM_sims_mult_ENCODE/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneYes/20/run1/Solo.out/Gene/raw/barcodes.tsv \
results_other/star/results_sim_vs_star_mult_uniform.txt --barcodes sim_barcodes.txt --transpose

python3 comparisons.py samples/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneYes/truth.mtx genomes/human_CR_3.0.0/genes.tsv data/whitelists/10Xv3 \
count/STAR_2.7.9a/human_CR_3.0.0/fullSA/10X_noSAM_sims_mult_ENCODE/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneYes/20/run1/Solo.out/Gene/raw/UniqueAndMult-EM.mtx \
count/STAR_2.7.9a/human_CR_3.0.0/fullSA/10X_noSAM_sims_mult_ENCODE/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneYes/20/run1/Solo.out/Gene/raw/features.tsv \
count/STAR_2.7.9a/human_CR_3.0.0/fullSA/10X_noSAM_sims_mult_ENCODE/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneYes/20/run1/Solo.out/Gene/raw/barcodes.tsv \
results_other/star/results_sim_vs_star_mult_em.txt --barcodes sim_barcodes.txt --transpose


python3 comparisons.py samples/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneYes/truth.mtx genomes/human_CR_3.0.0/genes.tsv data/whitelists/10Xv3 \
count/STAR_2.7.9a/human_CR_3.0.0/fullSA/10X_noSAM_sims_mult_ENCODE/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneYes/20/run1/Solo.out/Gene/raw/UniqueAndMult-PropUnique.mtx \
count/STAR_2.7.9a/human_CR_3.0.0/fullSA/10X_noSAM_sims_mult_ENCODE/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneYes/20/run1/Solo.out/Gene/raw/features.tsv \
count/STAR_2.7.9a/human_CR_3.0.0/fullSA/10X_noSAM_sims_mult_ENCODE/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneYes/20/run1/Solo.out/Gene/raw/barcodes.tsv \
results_other/star/results_sim_vs_star_mult_prop_uniq.txt --barcodes sim_barcodes.txt --transpose

python3 comparisons.py samples/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneYes/truth.mtx genomes/human_CR_3.0.0/genes.tsv data/whitelists/10Xv3 \
count/STAR_2.7.9a/human_CR_3.0.0/fullSA/10X_noSAM_sims_mult_ENCODE/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneYes/20/run1/Solo.out/Gene/raw/UniqueAndMult-Rescue.mtx \
count/STAR_2.7.9a/human_CR_3.0.0/fullSA/10X_noSAM_sims_mult_ENCODE/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneYes/20/run1/Solo.out/Gene/raw/features.tsv \
count/STAR_2.7.9a/human_CR_3.0.0/fullSA/10X_noSAM_sims_mult_ENCODE/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneYes/20/run1/Solo.out/Gene/raw/barcodes.tsv \
results_other/star/results_sim_vs_star_mult_rescue.txt --barcodes sim_barcodes.txt --transpose

python3 comparisons.py samples/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneNo_OnlyExonicReads/truth.mtx genomes/human_CR_3.0.0/genes.tsv data/whitelists/10Xv3 \
count/STAR_2.7.9a/human_CR_3.0.0/fullSA/10X_noSAM_sims_mult_ENCODE/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneNo_OnlyExonicReads/20/run1/Solo.out/Gene/raw/matrix.mtx \
count/STAR_2.7.9a/human_CR_3.0.0/fullSA/10X_noSAM_sims_mult_ENCODE/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneNo_OnlyExonicReads/20/run1/Solo.out/Gene/raw/features.tsv \
count/STAR_2.7.9a/human_CR_3.0.0/fullSA/10X_noSAM_sims_mult_ENCODE/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneNo_OnlyExonicReads/20/run1/Solo.out/Gene/raw/barcodes.tsv \
results_other/star/results_sim_vs_star_exon.txt --barcodes sim_barcodes.txt --transpose


