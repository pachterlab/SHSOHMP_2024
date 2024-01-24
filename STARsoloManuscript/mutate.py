import random
import argparse

random.seed(42)

def modify_sequence(seq, num_substitutions, num_deletions, num_insertions):
    """Modify the sequence with substitutions, deletions, and insertions."""
    bases = ['A', 'T', 'C', 'G']

    # Substitutions
    for _ in range(num_substitutions):
        idx = random.randint(0, len(seq) - 1)
        seq = seq[:idx] + random.choice(bases) + seq[idx + 1:]

    # Deletions
    for _ in range(num_deletions):
        if len(seq) > 0:
            idx = random.randint(0, len(seq) - 1)
            seq = seq[:idx] + seq[idx + 1:]

    # Insertions
    for _ in range(num_insertions):
        idx = random.randint(0, len(seq))
        seq = seq[:idx] + random.choice(bases) + seq[idx:]

    return seq

def process_fastq(file_name, num_substitutions, num_deletions, num_insertions):
    """Process a FASTQ file and apply modifications to each sequence."""
    with open(file_name, 'r') as file:
        while True:
            # Read one record (4 lines)
            header = file.readline().strip()
            if not header:
                break
            sequence = file.readline().strip()
            plus = file.readline().strip()
            quality = file.readline().strip()

            # Modify the sequence
            modified_sequence = modify_sequence(sequence, num_substitutions, num_deletions, num_insertions)

            # Output the modified FASTQ record
            print(header)
            print(modified_sequence)
            print(plus)
            print(quality)

def main():
    parser = argparse.ArgumentParser(description='Modify sequences in a FASTQ file.')
    parser.add_argument('file_name', type=str, help='FASTQ file name')
    parser.add_argument('x', type=int, help='Number of substitutions')
    parser.add_argument('y', type=int, help='Number of deletions')
    parser.add_argument('z', type=int, help='Number of insertions')

    args = parser.parse_args()

    process_fastq(args.file_name, args.x, args.y, args.z)

if __name__ == "__main__":
    main()

