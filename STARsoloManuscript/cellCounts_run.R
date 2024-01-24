require(Rsubread)
require(Matrix)

args <- commandArgs(trailingOnly = TRUE)

save_res <- FALSE
umi.cutoff <- NULL
unique_mapping <- TRUE
nBestLocations <- 1
out_path <- NULL
if (args[5] == "MULT") {
  unique_mapping <- FALSE
  nBestLocations <- 16
}
if (args[6] != "NULL") {
  save_res <- TRUE
  out_path <- args[6]
  umi.cutoff <- 5 # We set a low umi.cutoff of 5 to ensure that we get all cells to compare with sims
}

cC_results <- cellCounts(
    index=args[2],
    sample=args[1],
    input.mode = "FASTQ-dir",
    cell.barcode = args[4],
    annot.ext = args[3],
    isGTFAnnotationFile = TRUE,
    GTF.featureType = "exon",
    GTF.attrType = "gene_id",
    nthreads = 20,
    reportExcludedBarcodes=FALSE,
    umi.cutoff=umi.cutoff,
    uniqueMapping=unique_mapping,
    nBestLocations=nBestLocations
)



if (save_res) {
  writeMM(as(cC_results$counts$`5k_pbmc_sims_v3`, "sparseMatrix"), paste(out_path, "matrix.mtx", sep="/"))
  writeLines(colnames(cC_results$counts$`5k_pbmc_sims_v3`), paste(out_path, "barcodes.tsv", sep="/"))
  writeLines(rownames(cC_results$counts$`5k_pbmc_sims_v3`), paste(out_path, "features.tsv", sep="/"))
}
