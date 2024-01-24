require(Rsubread)

args <- commandArgs(trailingOnly = TRUE)

buildindex(
    paste(args[1], "default", sep="/"),
    args[2],
    gappedIndex = FALSE,
    indexSplit = FALSE,
    memory = 8000,
    TH_subread = 100,
    colorspace = FALSE)

buildindex(
    paste(args[1], "gapped", sep="/"),
    args[2],
    gappedIndex = TRUE,
    indexSplit = FALSE,
    memory = 8000,
    TH_subread = 100,
    colorspace = FALSE)
