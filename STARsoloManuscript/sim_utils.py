import scipy.stats as stats
import numpy as np
import os.path
import gzip

# Process simulation results and return relevant statistics

def process_sim_results(file_path):
    # Initializing variables
    spearman_corrs = []
    spearman_corrs_zeroes_included = []
    pearson_corrs = []
    pearson_corrs_zeroes_included = []
    errors = []
    false_positives = []
    false_negatives = []
    num_genes = []

    if os.path.isfile(file_path):
        with open(file_path, 'r') as file:
            lines = file.readlines()
    else:
        file_path = file_path + ".gz"
        with gzip.open(file_path, 'rt') as file:
            lines = file.readlines()

    # Validate and extract header information
    if not lines[0].startswith('#') or not lines[1].startswith('#'):
        raise ValueError("The first two lines must start with '#'")

    header1 = lines[0].strip().lstrip('#').split()
    header2 = lines[1].strip().lstrip('#').split()
    
    # Storing header information into variables
    num_barcodes_in_intersection = header1[0]
    num_barcodes_in_simulation, num_barcodes_in_program = header1[1].split(',')
    num_barcodes_in_intersection, num_barcodes_in_simulation, num_barcodes_in_program = map(
        int, [num_barcodes_in_intersection, num_barcodes_in_simulation, num_barcodes_in_program]
    )
    
    num_genes_in_intersection = header2[0]
    num_genes_in_simulation, num_genes_in_program = header2[1].split(',')
    num_genes_in_intersection, num_genes_in_simulation, num_genes_in_program = map(
        int, [num_genes_in_intersection, num_genes_in_simulation, num_genes_in_program]
    )
    
    if num_genes_in_intersection != num_genes_in_simulation:
        print("Warning: Number of genes is not consistent")

    # Processing the rest of the file
    for i in range(2, len(lines), 5):
        simulation_gene_counts = list(map(np.float64, lines[i+1].strip().split(',')))
        program_gene_counts = list(map(np.float64, lines[i+2].strip().split(',')))
        
        # Calculating Spearman correlations
        corr, _ = stats.spearmanr(simulation_gene_counts, program_gene_counts)
        spearman_corrs.append(corr)

        # Spearman correlation with zeroes included
        zeroes = [0] * (num_genes_in_intersection - len(simulation_gene_counts))
        corr_zeroes, _ = stats.spearmanr(simulation_gene_counts + zeroes, program_gene_counts + zeroes)
        spearman_corrs_zeroes_included.append(corr_zeroes)

        # Calculating Pearson correlations
        r_corr, _ = stats.pearsonr(simulation_gene_counts, program_gene_counts)
        pearson_corrs.append(r_corr)

        # Pearson correlation with zeroes included
        zeroes = [0] * (num_genes_in_intersection - len(simulation_gene_counts))
        r_corr_zeroes, _ = stats.pearsonr(simulation_gene_counts + zeroes, program_gene_counts + zeroes)
        pearson_corrs_zeroes_included.append(r_corr_zeroes)

        # Calculating errors
        errors.extend(
            [abs(sim - prog) for sim, prog in zip(
                simulation_gene_counts, program_gene_counts
            ) if sim != prog]
        )

        # Counting false positives and negatives
        false_positives.append(len(lines[i+3].strip().split(',')))
        false_negatives.append(len(lines[i+4].strip().split(',')))

        # Counting number of genes
        num_genes.append(len(lines[i+3].strip().split(',')))

    total_count = num_genes_in_intersection*len(num_genes)
    rmse = np.sqrt(sum([error ** 2 for error in errors]) / total_count)
    fnr = sum(false_negatives) / total_count
    fpr = sum(false_positives) / total_count
    median_spearman = np.median(spearman_corrs)
    median_spearman_zeroes_included = np.median(spearman_corrs_zeroes_included)
    median_pearson = np.median(pearson_corrs)
    median_pearson_zeroes_included = np.median(pearson_corrs_zeroes_included)

    return {
        'num_barcodes_in_intersection': num_barcodes_in_intersection,
        'num_barcodes_in_simulation': num_barcodes_in_simulation,
        'num_barcodes_in_program': num_barcodes_in_program,
        'num_genes_in_intersection': num_genes_in_intersection,
        'num_genes_in_simulation': num_genes_in_simulation,
        'num_genes_in_program': num_genes_in_program,
        'spearman_corrs': spearman_corrs,
        'spearman_corrs_zeroes_included': spearman_corrs_zeroes_included,
        'pearson_corrs': pearson_corrs,
        'pearson_corrs_zeroes_included': pearson_corrs_zeroes_included,
        'errors': errors,
        'false_positives': false_positives,
        'false_negatives': false_negatives,
        'num_genes': num_genes,
        'total_count': total_count,
        'rmse': rmse,
        'fnr': fnr,
        'fpr': fpr,
        'median_spearman_corrs': median_spearman,
        'median_spearman_corrs_zeroes_included': median_spearman_zeroes_included,
        'median_pearson_corrs': median_pearson,
        'median_pearson_corrs_zeroes_included': median_pearson_zeroes_included,
    }

