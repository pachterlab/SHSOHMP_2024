import sys

def parse_fasta(filename):
    with open(filename, 'r') as file:
        fasta_records = {}
        current_header = None
        current_sequence = []

        for line in file:
            if line.startswith(">"):
                if current_header:
                    fasta_records[current_header] = "".join(current_sequence)
                current_header = line.strip().split(' ')[0]  # Store the header (with the '>')
                current_header = current_header[1:]
                current_sequence = []
            else:
                current_sequence.append(line.strip())

        # Add the last record
        if current_header:
            fasta_records[current_header] = "".join(current_sequence)

    return fasta_records

def get_headers_from_file(header_file):
    with open(header_file, 'r') as file:
        headers = set(line.strip() for line in file)
    return headers

def select_fasta_records_by_headers(fasta_records, headers):
    selected_records = {header: seq for header, seq in fasta_records.items() if header in headers}
    return selected_records

def write_fasta_to_stdout(fasta_records):
    for header, sequence in fasta_records.items():
        print(f">{header}")
        print(f"{sequence}")

def main():
    if len(sys.argv) != 3:
        print("Usage: python select_fasta_by_headers.py <input_fasta> <headers_file>", file=sys.stderr)
        sys.exit(1)

    fasta_file = sys.argv[1]
    header_file = sys.argv[2]

    fasta_records = parse_fasta(fasta_file)
    headers = get_headers_from_file(header_file)
    selected_records = select_fasta_records_by_headers(fasta_records, headers)
    write_fasta_to_stdout(selected_records)

if __name__ == "__main__":
    main()

