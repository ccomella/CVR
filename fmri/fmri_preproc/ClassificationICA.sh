

#!/usr/bin/env bash


######### Classification ICA
# Author:  Cristina Comella
# Version: 1.0
# Date:    09.03.2023
#########

#Cluster with py_3.9 environment 
module load python/venv
source activate /bcbl/home/public/CVR/py_3.9

#Project Directory for all
#PRJDIR="/bcbl/home/public/CVR/PRESURGICAL_BIDS"

#Project Directory for all
PRJDIR="/bcbl/home/public/CVR/PRESURGICAL_BIDS"
#Extract all variables of interest except 056 because we already had it
#sub=(01 046 048 050 051 052 054 055 056 057 058 47 49 53)
#sub=(01)
sub=(065)
ses=(1)

echo sub=$sub
#ses=(1 1 2 1 1 1 1 2 1 1 1 1 1 2)
#ses=(2)
echo ses=$ses
task=BH
echo task=BH
run=1
echo run=1
wdr="/bcbl/home/public/CVR/PRESURGICAL_BIDS"
echo wdr=$wdr
flpr=sub-${sub}_ses-${ses}


# for i in 0 #$(seq 0 2)
# do 
#     echo "MEICA=${wdr}/sub-${sub[$i]}/ses-${ses[i]}/tmp/task-${task}/sub-${sub[$i]}_ses-${ses[$i]}_task-${task}_run-${run}_meica"
#     MEICA=${wdr}/sub-${sub[$i]}/ses-${ses[i]}/tmp/task-${task}/sub-${sub[$i]}_ses-${ses[$i]}_task-${task}_run-${run}_meica

#     echo "tedana_regressors -ctab ${MEICA}/manual_classification.tsv -mix ${MEICA}/desc-ICA_mixing.tsv -prefix ${MEICA}/ICA_components"
#     tedana_regressors -ctab ${MEICA}/manual_classification.tsv -mix ${MEICA}/desc-ICA_mixing.tsv -prefix ${MEICA}/ICA_components
# done


# This works but the loop has an error in not recognizing the MEICA file
MEICA=${wdr}/sub-${sub}/ses-${ses}/tmp/task-${task}/sub-${sub}_ses-${ses}_task-${task}_run-${run}_meica

tedana_regressors -ctab ${MEICA}/manual_classification.tsv -mix ${MEICA}/desc-ICA_mixing.tsv -prefix ${MEICA}/ICA_components
# done



