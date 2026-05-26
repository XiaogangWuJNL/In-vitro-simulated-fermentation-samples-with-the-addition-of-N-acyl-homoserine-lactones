#!/bin/bash
for i in $(tail -n+2 /mnt/hwdata/Users/wuxg/Batch_culture/AHL_addition/qsub_sh/CAG8_sh/hmm_sh/CAG8_faa.txt | cut -f1); 
do  
export TMPDIR=/mnt/hwdata/Users/wuxg/tmp
mamba run -n hmmer \
hmmscan --cut_ga \
--cpu 40 \
--domtblout /mnt/hwdata/Users/wuxg/Batch_culture/AHL_addition/CAG8_results/CAG8_hmmscan_results/${i}.out.pfam.domtbl \
/mnt/hwdata/Users/wuxg/database/Pfam_382/Pfam-A.hmm \
/mnt/hwdata/Users/wuxg/Batch_culture/AHL_addition/faa/CAG8/${i}.faa
done
