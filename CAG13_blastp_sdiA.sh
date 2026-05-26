#!/bin/bash
for i in $(tail -n+2 /mnt/hwdata/Users/wuxg/Batch_culture/AHL_addition/qsub_sh/dbcan_sh/CAG13_faa.txt | cut -f1); 
do  
diamond blastp -d /mnt/hwdata/Users/wuxg/database/BCG_wuxg_DB/sdiA.dmnd \
-q /mnt/hwdata/Users/wuxg/Batch_culture/AHL_addition/faa/CAG13/${i}.faa \
-o /mnt/hwdata/Users/wuxg/Batch_culture/AHL_addition/CAG13_results/CAG13_blastp_sdiA_results/${i}_sdiA.out \
--sensitive -e 1e-5 -f 6 -k 1 --threads 40
done



