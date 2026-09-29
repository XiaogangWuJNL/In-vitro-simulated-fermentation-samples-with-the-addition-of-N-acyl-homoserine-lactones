#!/bin/bash
for i in $(tail -n+2 /mnt/hwdata/Users/wuxg/Batch_culture/AHL_addition/qsub_sh/dbcan_sh/CAG12_faa.txt | cut -f1); 
do  
export TMPDIR=/mnt/hwdata/Users/wuxg/tmp
mamba run -n interproscan \
interproscan.sh \
  -i /mnt/hwdata/Users/wuxg/Batch_culture/AHL_addition/faa/CAG12/${i}.faa \
  -b /mnt/hwdata/Users/wuxg/Batch_culture/AHL_addition/CAG12_results/CAG12_interproscan_results/${i} \
  -f tsv \
  -appl pfam,smart \
  -cpu 16 \
  -dp
done


