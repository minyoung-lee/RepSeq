#! /bin/bash

flag_TCRb=0
flag_IGHG=0
flag_IGKC=0
flag_IGLC=0

# list of fastq files (trimmed fastq files)
fastq=`find ./cutadapt  -name '*.fastq' | sort`
echo "$fastq" | cut -d "/" -f3 | cut -d "_" -f1,2,3,4 | uniq > list_fastq.txt

# run MiXCR 
for input in `cat ./list_fastq.txt`
do 

# display the processing file name
echo $input

# which gene 
gene=`echo $input | cut -d "_" -f2` 
gene=`expr substr $gene 1 4`
flag_TCRb=`expr $gene == "TCRb"`
flag_IGHG=`expr $gene == "IGHG"`
flag_IGKC=`expr $gene == "IGKC"`
flag_IGLC=`expr $gene == "IGLC"`

# file names
R1_input="./cutadapt/${input}_R1_001.fastq"
R2_input="./cutadapt/${input}_R2_001.fastq"
alignment="alignments_${input}.vdjca"
alignmentReport="alignmentReport_${input}.log"
alignmentTxt="alignments_${input}.txt"
assembleReport="assembleReport_${input}.log"
clone="clones_${input}.clns"
cloneTxt="clones_${input}.txt"

if ((flag_TCRb==1))
then
mixcr align --species hs --loci TRB -OvParameters.geneFeatureToAlign=VTranscript --report $alignmentReport $R1_input $R2_input $alignment
mixcr assemble --report $assembleReport $alignment $clone
mixcr exportAlignments $alignment $alignmentTxt
mixcr exportClones -nFeature CDR3 $clone $cloneTxt
fi

if ((flag_IGHG==1))
then
mixcr align --species hs --loci IGH -OvParameters.geneFeatureToAlign=VTranscript --report $alignmentReport $R1_input $R2_input $alignment
mixcr assemble --report $assembleReport $alignment $clone
mixcr exportAlignments $alignment $alignmentTxt
mixcr exportClones -nFeature CDR3 $clone $cloneTxt
fi

if ((flag_IGKC==1))
then
mixcr align --species hs --loci IGK -OvParameters.geneFeatureToAlign=VTranscript --report $alignmentReport $R1_input $R2_input $alignment
mixcr assemble --report $assembleReport $alignment $clone
mixcr exportAlignments $alignment $alignmentTxt
mixcr exportClones -nFeature CDR3 $clone $cloneTxt
fi

if ((flag_IGLC==1))
then
mixcr align --species hs --loci IGL -OvParameters.geneFeatureToAlign=VTranscript --report $alignmentReport $R1_input $R2_input $alignment
mixcr assemble --report $assembleReport $alignment $clone
mixcr exportAlignments $alignment $alignmentTxt
mixcr exportClones -nFeature CDR3 $clone $cloneTxt
fi

done
mkdir mixcr_align
mkdir mixcr_assemble
mkdir mixcr_clones
mv ./alignment* ./mixcr_align
mv ./assembleReport_*.log ./mixcr_assemble
mv ./clones* ./mixcr_clones
