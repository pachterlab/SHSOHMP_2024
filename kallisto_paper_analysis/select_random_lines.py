import random
import sys

def select_random_lines(input_file, output_file, num_lines, seed):
    random.seed(seed)  # Set the seed for reproducibility
    with open(input_file, 'r') as file:
        lines = file.readlines()
        
    random_lines = random.sample(lines, num_lines)
    
    with open(output_file, 'w') as file:
        for line in random_lines:
            file.write(line)

if __name__ == "__main__":
    # Check if the correct number of arguments is provided
    if len(sys.argv) != 5:
        print("Usage: python select_random_lines.py <input_file> <output_file> <num_lines> <seed>")
        sys.exit(1)
    
    input_file = sys.argv[1]
    output_file = sys.argv[2]
    num_lines = int(sys.argv[3])
    seed = int(sys.argv[4])
    
    select_random_lines(input_file, output_file, num_lines, seed)

