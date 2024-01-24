#!/bin/bash

# Check if exactly four arguments are given
if [ "$#" -ne 4 ]; then
    echo "Usage: $0 <input_matrix_file> <rows_file> <columns_file> <output_matrix_file>"
    exit 1
fi

# Assigning command-line arguments to variables
input_matrix_file=$1
rows_file=$2
cols_file=$3
output_matrix_file=$4

# Check if the specified input files exist
if [ ! -f "$input_matrix_file" ] || [ ! -f "$rows_file" ] || [ ! -f "$cols_file" ]; then
    echo "Error: One or more input files do not exist."
    exit 1
fi

# Count the number of rows and columns
num_rows=$(wc -l < "$rows_file")
num_cols=$(wc -l < "$cols_file")

# Count the number of non-zero entries in the matrix (assuming sparse format)
num_nonzero=$(grep -v '^%' "$input_matrix_file" | grep -v '^$' | wc -l)

# Create the new matrix file with the header
echo "%%MatrixMarket matrix coordinate real general" > "$output_matrix_file"
echo "$num_rows $num_cols $num_nonzero" >> "$output_matrix_file"

# Append the original matrix data to the new matrix file
cat "$input_matrix_file" >> "$output_matrix_file"
