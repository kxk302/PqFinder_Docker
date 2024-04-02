#!/bin/bash

if [ $# -ne 4 ]; then
    echo "Incorrect number of parameters"
    echo "Specify the fasta file, output file, minimum score, and overlapping flag"
    exit
fi

FastaFile=$1
OutputFile=$2
MinScore=$3
Overlapping=$4

echo "FastaFile: <$FastaFile>"
echo "OutputFile: <$OutputFile>"
echo "MinScore: <$MinScore>"
echo "Overlapping: <$Overlapping>"

cd ./scripts
Rscript run_pqsfinder.R $FastaFile $OutputFile $MinScore $Overlapping

