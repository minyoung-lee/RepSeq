#!/bin/bash

#list of assembleReport_*.log files 
find ./mixcr_assemble -name 'assembleReport_*.log' | sort > list_log.txt

# parse alignment stats 
input=`head -n 1 list_log.txt`
output=`sed -n '2,14p' $input | cut -d ":" -f1 | tr '\n' ';'`
echo $output >> stat_assemble.txt

for input in `cat ./list_log.txt`
do

# display the processing file name
echo $input

output=`sed -n '2,14p' $input | cut -d ":" -f2 | tr '\n' ';'`
echo $output >> stat_assemble.txt

done

