import scipy.io
import numpy as np
import sys
import pandas as pd

# Load the MatrixMarket file
mm_file = sys.argv[1]  # Replace with your file path
matrix = scipy.io.mmread(mm_file)

# Sum across all cells (rows) for each gene (column)
pseudobulked_data = matrix.sum(axis=0)

# Convert the summed data to a 2D array (1 row x number of genes)
pseudobulked_data_2d = np.array(pseudobulked_data).reshape(-1, 1)

# Write the pseudobulked data to a new MatrixMarket file
output_file = sys.argv[2]  # Replace with your desired output file path
# scipy.io.mmwrite(output_file, pseudobulked_data_2d)

# print(f'Pseudobulked data written to {output_file}')


pseudobulked_data_dense = pseudobulked_data_2d.astype(int)

df = pd.DataFrame(pseudobulked_data_dense)

# Write the pseudobulked data to a CSV file
df.to_csv(output_file, index=False, header=False)

print(f'Pseudobulked data (dense format) written to {output_file}')

