#!/usr/bin/env bash

######### Link to AFNI Scripts for Phys2CVR nontumor
# Author:  Cristina Comella
# Version: 1.0
# Date:    22.03.2023
#########

#Load in Cajal01 all the module necessary 
module load python/python3.6
module load afni/latest

#Project Directory
PRJDIR="/bcbl/home/public/CVR/PRESURGICAL_BIDS"

#Indicate the list of subjects and session of interst
# sub=(01 046 048 050 051 052 054 055 056 057 058 47 49 53)
# ses=(1 1 2 1 1 1 1 2 1 1 1 1 1 2)

#Presurgical group 2
sub=(052 054)
ses=(1 1)
run=1
task=BH
model=cons


for i in $(seq 0 1)
do

    #Indicate the Fun_preproc directory
    wdr=${PRJDIR}/sub-${sub[$i]}/ses-${ses[i]}/func_preproc
    echo $wdr 

    func_in="sub-${sub[$i]}_ses-${ses[i]}_task-${task}_run-${run}_optcom_bold_sm"
    echo $func_in


    # create symbolic link to a folder for visualization with AFNI
    if [[ ! -d "${wdr}/links_4_AFNI_phys2cvr_nontumor" ]]; then
        echo "Creating folder links_4_AFNI_phys2cvr_nontumor to put all volumes for better visualization in AFNI"
        mkdir -p "${wdr}/links_4_AFNI_phys2cvr_nontumor"
    fi

    for model in cons
    do
        # run 3dcalc with identity so that the values of the AFNI header are correct (since they are not updated by phys2cvr)
        for metric in cvr cvr_simple lag lag_mkrel tstat tstat_simple
        do

            3dcalc -a "${wdr}/phys2cvr_cons_ROI/${func_in}_${metric}.nii.gz" -expr 'a' -prefix "${wdr}/phys2cvr_cons_ROI//${func_in}_${metric}.nii.gz" -overwrite
            
            ln -s "${wdr}/phys2cvr_cons_ROI/${func_in}_${metric}.nii.gz" "${wdr}/links_4_AFNI_phys2cvr_nontumor/${func_in}_${metric}_${model}.nii.gz"
        done
    done
done
