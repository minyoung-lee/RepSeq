#! /bin/bash

# list of fastq files (trimmed fastq files)
find ./cutadapt  -name '*.fastq' | sort > list_fastq.txt

# 
for ((i=0;i<=151;i++));do echo $i >> set0_151;done
x=`cat set0_151`
xx=($x)
echo -e "file\t${xx[*]}" >> stat_readLength.txt

# parse read length 
for input in `cat ./list_fastq.txt`
do

# display the processing file name
echo $input

# parse read length
cat $input | awk '{if( (NR-2)%4==0){print length($1)}}' > RL
sort -h RL  | uniq -c > sorted
x=`cat sorted | tr -s ' ' | cut -d " " -f3` 
readLength=($x)
y=`cat sorted | tr -s ' ' | cut -d " " -f2`
readCount=($y)
N=`wc -l sorted | cut -d " " -f1`
for ((i=0; i<=N; i++));
do
C[${readLength[i]}]="${readCount[i]}"
done
C[${readLength[0]}]="${readCount[0]}"

# find empty read length
cat sorted | tr -s ' ' | cut -d " " -f3 > readLength
diff readLength set0_151 | grep ">" | cut -d " " -f2 > i_nan.txt

for i in `cat ./i_nan.txt`
do
C[i]="NaN"
done

echo -e "${input}\t${C[*]}" >> stat_readLength.txt 
rm RL sorted readLength i_nan.txt

done
rm set0_151 

