import random
import sys

def parse_fasta(filename):
    with open(filename, 'r') as file:
        fasta_records = []
        current_record = []
        
        for line in file:
            if line.startswith(">"):
                if current_record:
                    fasta_records.append("".join(current_record))
                    current_record = []
                current_record.append(line)
            else:
                current_record.append(line.strip())
        
        if current_record:
            fasta_records.append("".join(current_record))
    
    return fasta_records

def select_random_fasta_records(fasta_records, n, seed=42):
    random.seed(seed)
    return random.sample(fasta_records, n)

def write_fasta(output_filename, fasta_records):
    with open(output_filename, 'w') as file:
        for record in fasta_records:
            file.write(record + "\n")

def main(input_fasta, n, output_fasta):
    fasta_records = parse_fasta(input_fasta)
    selected_records = select_random_fasta_records(fasta_records, n)
    write_fasta(output_fasta, selected_records)

# Usage
input_fasta = sys.argv[1]  # Your input FASTA file
n = int(sys.argv[2])  # Number of records to select
output_fasta = sys.argv[3]  # Your output FASTA file

main(input_fasta, n, output_fasta)

