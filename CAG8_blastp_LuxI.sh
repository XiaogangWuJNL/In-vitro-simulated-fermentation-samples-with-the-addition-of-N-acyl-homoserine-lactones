#!/bin/bash
for i in $(tail -n+2 /mnt/hwdata/Users/wuxg/Batch_culture/AHL_addition/qsub_sh/CAG8_sh/blastp_sh/CAG8_faa.txt | cut -f1); 
do  
diamond blastp -d /mnt/hwdata/Users/wuxg/database/QSDB/LuxI.dmnd \
-q /mnt/hwdata/Users/wuxg/Batch_culture/AHL_addition/faa/CAG8/${i}.faa \
-o /mnt/hwdata/Users/wuxg/Batch_culture/AHL_addition/CAG8_results/CAG8_blastp_results/LuxI/${i}_LuxI.out \
--sensitive -e 1e-5 -f 6 -k 1 --threads 40
done



