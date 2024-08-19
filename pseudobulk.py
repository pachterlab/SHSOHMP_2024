import scipy.io
import numpy as np
import sys
import pandas as pd
from scipy.sparse import coo_matrix, csr_matrix

# Load the MatrixMarket file
mm_file = sys.argv[1]  # Replace with your file path
matrix = scipy.io.mmread(mm_file)

# Sum across all cells (rows) for each gene (column)
pseudobulked_data = matrix.sum(axis=0)

# Convert the summed data to a 2D array (1 row x number of genes)
pseudobulked_data_2d = np.array(pseudobulked_data).reshape(-1, 1)

output_file = sys.argv[2]


if output_file.endswith(".mtx"):
  subset_matrix = coo_matrix(pseudobulked_data_2d).T
  with open(output_file, 'w') as f:
    # Write the header for the MatrixMarket file
    f.write(f"%%MatrixMarket matrix coordinate integer general\n")
    f.write(f"{subset_matrix.shape[0]} {subset_matrix.shape[1]} {subset_matrix.nnz}\n")
    for i, j, v in zip(subset_matrix.row, subset_matrix.col, subset_matrix.data):
        f.write(f"{i + 1} {j + 1} {int(v)}\n")
  print(f'Pseudobulked data written to {output_file}')
  sys.exit(0)

pseudobulked_data_dense = pseudobulked_data_2d.astype(int)
df = pd.DataFrame(pseudobulked_data_dense)

# Write the pseudobulked data to a CSV file
df.to_csv(output_file, index=False, header=False)

print(f'Pseudobulked data (dense format) written to {output_file}')

