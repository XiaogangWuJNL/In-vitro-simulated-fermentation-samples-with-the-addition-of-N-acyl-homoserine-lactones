#!/bin/bash
for i in $(tail -n+2 /mnt/hwdata/Users/wuxg/Batch_culture/AHL_addition/qsub_sh/dbcan_sh/CAG13_faa.txt | cut -f1); 
do
export TMPDIR=/mnt/hwdata/Users/wuxg/tmp/dbCAN
mamba run -n dbcan_v6 \
run_dbcan /mnt/hwdata/Users/wuxg/Batch_culture/AHL_addition/faa/CAG13/${i}.faa protein \
--out_dir /mnt/hwdata/Users/wuxg/Batch_culture/AHL_addition/dbcan/CAG13/${i}__dbcan_results \
--db_dir /mnt/hwdata/Users/wuxg/database/dbcan414 \
--tools all
done