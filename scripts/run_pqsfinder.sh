#!/bin/bash

if [ $# -ne 4 ]; then
    echo "Incorrect number of parameters"
    echo "Specify the fasta file, output file, minimum score, and overlapping flag  (1 or 0, for True or False)"
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

FastaFileName=`basename $FastaFile`
OutputDir=`dirname $OutputFile`
OutputFileName=`basename $OutputFile`

DOCKER_CMD="docker run -v $FastaFile:/$FastaFileName -v $OutputDir:/output kxk302/pqsfinder:1.0.0 /$FastaFileName /output/$OutFileName $MinScore $Overlapping"
echo $DOCKER_CMD
$DOCKER_CMD
