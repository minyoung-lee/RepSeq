#!/bin/bash

# list of fastq files (trimmed fastq files)
find ./cutadapt  -name '*.fastq' | sort > list_fastq.txt

# parse read length 
for input in `cat ./list_fastq.txt`
do

# display the processing file name
echo $input

# parse read length
cat $input | awk '{if((NR-2)%4==0){print length($1)}}' > test
readLength=`sort -h test  | uniq -c | tr -s ' ' | cut -d " " -f2 | tr '\n' '\t'`
echo -e "${input}\t$readLength" >> stat_readLength.txt 

done

