#!/bin/bash
for i in $(tail -n+2 /mnt/hwdata/Users/wuxg/Batch_culture/AHL_addition/qsub_sh/dbcan_sh/CAG13_faa.txt | cut -f1); 
do  
diamond blastp -d /mnt/hwdata/Users/wuxg/database/QSDB/HdtS.dmnd \
-q /mnt/hwdata/Users/wuxg/Batch_culture/AHL_addition/faa/CAG13/${i}.faa \
-o /mnt/hwdata/Users/wuxg/Batch_culture/AHL_addition/CAG13_blastp_results/${i}_HdtS.out \
--sensitive -e 1e-5 -f 6 -k 1 --threads 40
done
