#! /bin/bash

# list of fastq files (split fastq files from different lanes)
fastq=`find -name '*.fastq' | sort`
echo "$fastq" | cut -d "/" -f2 | cut -d "_" -f1,2,3 | uniq > list_fastq.txt

# adapter sequences
switchingOligo_fwd="ATCAAGCAGTGGTATCAACGCAGAGTAC"
switchingOligo_rev="GTACTCTGCGTTGATACCACTGCTTGAT"
R2Primer_fwd="GTGACTGGAGTTCAGACGTGTGCTCTTCCGATCT"
R2Primer_rev="AGATCGGAAGAGCACACGTCTGAACTCCAGTCAC"

# trimming process for each fastq file 
for input in `cat ./list_fastq.txt`
do 

# display the processing file name
echo $input

# file names
R1_input="${input}_R1_001.fastq"
R2_input="${input}_R2_001.fastq"
R1_output="cutadapt_${R1_input}"
R2_output="cutadapt_${R2_input}"
report="${input}.report"

# trim 5' switching oligo  and R2 primer
cutadapt --nextseq-trim=10 -g $switchingOligo_fwd -a $R2Primer_rev -G $R2Primer_fwd -A $switchingOligo_rev --match-read-wildcards -o $R1_output -p $R2_output $R1_input $R2_input > $report

done
mkdir cutadapt
mv ./cutadapt_*.fastq ./cutadapt
mv ./*.report ./cutadapt