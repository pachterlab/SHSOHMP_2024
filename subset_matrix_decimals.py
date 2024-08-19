import scipy.io
import pandas as pd
import numpy as np
import sys
from scipy.sparse import coo_matrix, csr_matrix

# Usage: python subset_matrix_decimals.py cells_x_genes.mtx barcodes_subset.txt barcodes.txt output.mtx
# Note: Use this instead of subset_matrix.py when some of the matrix values can be decimals

# Step 1: Load the MatrixMarket file
matrix = scipy.io.mmread(sys.argv[1]).tocsr()

# Step 2: Load the list of cell barcodes
# Assuming the barcodes are stored in a text file, one per line
barcodes_to_keep = pd.read_csv(sys.argv[2], header=None)
barcodes_to_keep = pd.Series(barcodes_to_keep[0])

# Step 3: Load the barcodes from the MatrixMarket file
# Assuming the cell barcodes are stored in the rows (index) of the matrix
matrix_barcodes = pd.read_csv(sys.argv[3], header=None)
matrix_barcodes = pd.Series(matrix_barcodes[0])

# Find the indices of the barcodes to keep
indices_to_keep = np.where(matrix_barcodes.isin(barcodes_to_keep))[0]

# Subset the matrix to keep only the desired barcodes
subset_matrix = matrix[indices_to_keep, :].tocoo()  # Convert back to COO format for easier iteration

# Step 4: Write the subsetted matrix to a new MatrixMarket file

with open(sys.argv[4], 'w') as f:
    # Write the header for the MatrixMarket file
    f.write(f"%%MatrixMarket matrix coordinate integer general\n")
    f.write(f"{subset_matrix.shape[0]} {subset_matrix.shape[1]} {subset_matrix.nnz}\n")

    # Write the matrix entries directly as integers
    for i, j, v in zip(subset_matrix.row, subset_matrix.col, subset_matrix.data):
        f.write(f"{i + 1} {j + 1} {v:.6f}\n")  # Adjust the precision here (e.g., .6f for 6 decimal places) 

