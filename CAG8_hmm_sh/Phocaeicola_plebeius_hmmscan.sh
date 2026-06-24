#!/bin/bash
export TMPDIR=/mnt/hwdata/Users/wuxg/tmp
mamba run -n hmmer \
hmmscan --cut_ga \
--cpu 16 \
--domtblout /mnt/hwdata/Users/wuxg/Batch_culture/AHL_addition/CAG8_results/CAG8_hmmscan_results/Phocaeicola_plebeius.out.pfam.domtbl \
/mnt/hwdata/Users/wuxg/database/Pfam_382/Pfam-A.hmm \
/mnt/hwdata/Users/wuxg/Batch_culture/AHL_addition/faa/CAG8/Phocaeicola_plebeius.faa