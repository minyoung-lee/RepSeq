#! /bin/bash

# list of fastq files (split fastq files from different lanes)
fastq=`find -maxdepth 1 -name '*.fastq' | sort`
echo "$fastq" | cut -d "/" -f2 > list_fastq.txt

# parse index sequences
for input in `cat ./list_fastq.txt`
do

# display the processing file name
echo $input

# output file name
output=`echo $input | cut -d '.' -f1`
output="$output.indexSeq"

# parse all index sequences and counts
grep "@" ${input} | cut -d ":" -f10 | sort | uniq -c | sort -n -r > $output
N=`sed -n '1,1p' $output | cut -d " " -f2`
index=`sed -n '1,1p' $output | cut -d " " -f3`
S=`wc -l ${input} | cut -d " " -f1`
let S=S/4
R=`echo "scale=4; $N/$S" | bc`
echo -e "${input}\t$S\t$index\t$N\t$R" >> stat_index.txt 

done
