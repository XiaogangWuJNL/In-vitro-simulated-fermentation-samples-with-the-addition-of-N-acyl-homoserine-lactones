#!/bin/bash
for i in $(tail -n+2 /mnt/hwdata/Users/wuxg/Batch_culture/AHL_addition/qsub_sh/dbcan_sh/CAG12_faa.txt | cut -f1); 
do  
diamond blastp -d /mnt/hwdata/Users/wuxg/database/QSDB/LuxI.dmnd \
-q /mnt/hwdata/Users/wuxg/Batch_culture/AHL_addition/faa/CAG12/${i}.faa \
-o /mnt/hwdata/Users/wuxg/Batch_culture/AHL_addition/CAG12_blastp_LuxI_results/${i}_LuxI.out \
--sensitive -e 1e-5 -f 6 -k 1 --threads 40
done



