library(seqinr)
library(pqsfinder)
library(rtracklayer)

# Process command line arguments
args = commandArgs(trailingOnly=TRUE)
argsLen <- length(args);
if (argsLen != 4) {
  stop("Specify the fasta file, output file, minimum score, and overlapping flag", call.=FALSE)
}

FastaFile = paste0(args[1])
OutputFile = paste0(args[2])
MinScore = paste0(args[3])
Overlapping = paste0(args[4])

sprintf("FastaFile: %s", FastaFile)
sprintf("OutputFile: %s", OutputFile)
sprintf("MinScore: %s", MinScore)
sprintf("Overlapping: %s", Overlapping)

# Read the sequence in the Fasat file
seq<-read.fasta(FastaFile, as.string=True)

# Run pqsfinder
pqs <- pqsfinder(seq, min_score=MinScore, overlapping=Overlapping)

# Sort the results by score to see the best one
pqs_s <- pqs[order(score(pqs), decreasing = TRUE)]

# Export all PQS into a GFF3-formatted file
export(as(pqs, "GRanges"), OutputFile, version = "3")
