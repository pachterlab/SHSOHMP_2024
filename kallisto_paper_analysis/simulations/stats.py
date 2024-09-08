import pandas as pd
import numpy as np
import scipy.stats as stats
import sys
import matplotlib.pyplot as plt

prog = []
sim = []

# Loop through the file numbers from 1 to 20
for i in range(1, 21):
    # Construct the filenames
    file1_name = f'NA12716_7/rsem/sim/30000000/{i}/{sys.argv[1]}/abundance.tsv'
    #file1_name = f'NA12716_7/rsem/sim/30000000/{i}/rsem/out.isoforms.results'
    file2_name = f'NA12716_7/rsem/sim/30000000/{i}.sim.isoforms.results'
    
    # Load the two TSV files
    file1 = pd.read_csv(file1_name, sep='\t')
    file2 = pd.read_csv(file2_name, sep='\t')

    # Rename columns if necessary to ensure they are consistent
    file1 = file1.rename(columns={'expected_count': 'est_counts'})
    file2 = file2.rename(columns={'expected_count': 'est_counts'})
    file1 = file1.rename(columns={'count': 'est_counts'})
    file2 = file2.rename(columns={'count': 'est_counts'})


    # Merge the two dataframes on the first column
    merged_df = pd.merge(file1, file2, left_on=file1.columns[0], right_on=file2.columns[0], suffixes=('_file1', '_file2'))

    est_counts_file1 = 'est_counts_file1'
    est_counts_file2 = 'est_counts_file2'


    # Calculate the absolute difference divided by the average
    merged_df['relative_difference'] = merged_df.apply(
        lambda row: 0 if row[est_counts_file1] == 0 and row[est_counts_file2] == 0 
        else abs(row[est_counts_file1] - row[est_counts_file2]) / ((row[est_counts_file1] + row[est_counts_file2]) / 2),
        axis=1
    )

    #print(merged_df)
 
    # Calculate some statistics
    a = merged_df.loc[:,est_counts_file1]
    b = merged_df.loc[:,est_counts_file2]
    prog.extend(a)
    sim.extend(b)
    r_corr, _ = stats.pearsonr(np.log2(a+1),np.log2(b+1))


errors = [abs(s - p) for s, p in zip(sim, prog) if s != p]
total_count = len(prog)

rmse = np.sqrt(sum([error ** 2 for error in errors]) / total_count)
median_r = np.median(r_corr)

print("RMSE", rmse)
print("median_r", median_r)
print("total_count", total_count)

#print(errors)

#print(sim)
#print(prog)

plt.scatter(np.log2(np.array(sim)+1), np.log2(np.array(prog)+1))

# Add labels and title
plt.xlabel('Sim')
plt.ylabel('Prog')
plt.title('Scatter Plot of Sim vs. Prog')

# Show the plot
plt.savefig('scatter_plot.pdf', format='pdf')


