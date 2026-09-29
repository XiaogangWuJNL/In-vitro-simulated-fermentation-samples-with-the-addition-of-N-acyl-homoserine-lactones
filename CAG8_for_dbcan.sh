#!/bin/bash
for i in $(tail -n+2 /mnt/hwdata/Users/wuxg/Batch_culture/AHL_addition/qsub_sh/CAG8_sh/dbcan_sh/CAG8_faa.txt | cut -f1); 
do
export TMPDIR=/mnt/hwdata/Users/wuxg/tmp/dbCAN
mamba run -n dbcan_v6 \
run_dbcan /mnt/hwdata/Users/wuxg/Batch_culture/AHL_addition/faa/CAG8/${i}.faa protein \
--out_dir /mnt/hwdata/Users/wuxg/Batch_culture/AHL_addition/CAG8_results/CAG8_dbcan_results/${i}_dbcan_results \
--db_dir /mnt/hwdata/Users/wuxg/database/dbcan414 \
--tools all
done