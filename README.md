# RepSeq

- Immune repoirtoire sequencing
- TCRb, IGHG, IGKC, IGLC
- 5'-RACE
- Illumina NextSeq500
- Dual-indexed library 
- Paired-end, 150nt
- Dependent: cutadapt, MiXCR
- Run order:
  1. stat_index.sh
  2. stat_readLength.sh
  3. cutadapt_PE.sh
  4. run_mixcr.sh
  5. stat_align.sh
  6. stat_assemble.sh
