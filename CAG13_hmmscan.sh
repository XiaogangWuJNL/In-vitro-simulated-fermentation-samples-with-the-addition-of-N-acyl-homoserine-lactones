#!/bin/bash
for i in $(tail -n+2 /mnt/hwdata/Users/wuxg/Batch_culture/AHL_addition/qsub_sh/dbcan_sh/CAG13_faa.txt | cut -f1); 
do  
export TMPDIR=/mnt/hwdata/Users/wuxg/tmp
mamba run -n hmmer \
hmmscan --cut_ga --domtblout /mnt/hwdata/Users/wuxg/Batch_culture/AHL_addition/CAG13_hmmscan_results/${i}.out.pfam.domtbl \
/mnt/hwdata/Users/wuxg/database/Pfam_382/Pfam-A.hmm \
/mnt/hwdata/Users/wuxg/Batch_culture/AHL_addition/faa/CAG13/${i}.faa
done
