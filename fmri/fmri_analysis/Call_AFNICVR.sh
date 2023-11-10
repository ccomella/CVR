#!/usr/bin/env bash

######### Call AFNI_CVR
# Author:  Cristina Comella
# Version: 1.0
# Date:    05.04.2023
#########



#Name of Sub and Ses
# sub=(046 052 054 055 056 057 058 47 49 53)
# ses_func=(1 1 1 2 1 1 1 1 1 2) 
# # sub=(53)
# # ses_func=(2)
# task=BH
# run=1

#Name of Sub and Ses de las que tengo listas
sub=(059 060 061 062 063 064)
ses_func=(2 1 1 1 1 1) 
# sub=(53)
# ses_func=(2)
task=BH
run=1

#Parameters of interest
lag=9
step=0.3 
freq=40
step_idx=12
pval=0.05

#Project Directory
PRJDIR="/bcbl/home/public/CVR/PRESURGICAL_BIDS"

#Script folder
script_path="/bcbl/home/public/CVR/Scripts/fmri"


lag_pcorr=yes
ftype=meica_cons

# for ftype in meica_cons #optcom_mpr meica_aggr meica_mode meica_cons
# do
#     for i in $(seq 0 12)  # this index goes through the subject and session lists
    
#     do
        
#         #Indicate the Fun_preproc directory
#         wdr="${PRJDIR}/sub-${sub[$i]}/ses-${ses[i]}/func_preproc"
#         logs_dir="${PRJDIR}/sub-${sub[$i]}/ses-${ses[i]}/func_preproc/logs"

#         if [[ ! -d ${logs_dir} ]]; then
#             mkdir -p ${logs_dir}
#         fi
    
#         #Func File
#         func_in="${wdr}/sub-${sub[$i]}_ses-${ses[i]}_task-${task}_run-${run}_optcom_bold_sm"

#         #Mask
#         fmask="${wdr}/sub-${sub[$i]}_ses-${ses[i]}_task-${task}_optcom_mask"

#         #MEICA folder where manual classification is stored
#         MEICA=${PRJDIR}/sub-${sub[$i]}/ses-${ses[i]}/tmp/task-${task}/sub-${sub[$i]}_ses-${ses[$i]}_task-${task}_run-${run}_meica
    
#         #demat matrices initial: deman and derivatives 
#         demean="${wdr}/sub-${sub[$i]}_ses-${ses[i]}_task-${task}_run-${run}_echo-1_bold_cr_mcf_demean"
#         deriv="${wdr}/sub-${sub}_ses-${ses}_task-${task}_run-${run}_echo-1_bold_cr_mcf_deriv1"

#         if [[ -e "${logs_dir}/Output_AFNICVR_sub-${sub[$i]}_ses-${ses}_run-${run}_task-${task}_model-${ftype}.txt" ]]; then
#             rm ${logs_dir}/Output_AFNICVR_sub-${sub[$i]}_ses-${ses}_run-${run}_task-${task}_model-${ftype}.txt
#         fi

        
        
#         qsub -q long.q -N "sub-${sub[$i]}" \
#                  -o "${logs_dir}/Output_AFNICVR_sub-${sub[$i]}_ses-${ses}_run-${run}_task-${task}_model-${ftype}.txt" \
#                  -e "${logs_dir}/Output_AFNICVR_sub-${sub[$i]}_ses-${ses}_run-${run}_task-${task}_model-${ftype}.txt" \
#                     ${script_path}/AFNI_CVR.sh ${sub[$i]} ${ses[$i]} ${task} ${run} ${wdr} ${ftype} \
#                     "${lag}" "${step}" "${freq}" "${step_idx}" "${pval}" "${lag_pcorr}" "${func_in}" "${fmask}" \
#                     "${MEICA}" "${demean}" "${deriv}"   
    
#     done


# done


for i in $(seq 0 5) # this index goes through the subject and session lists
do
        
    #Indicate the Fun_preproc directory
    fdir="${PRJDIR}/sub-${sub[$i]}/ses-${ses_func[$i]}/func_preproc"
    logs_dir="${PRJDIR}/sub-${sub[$i]}/ses-${ses_func[$i]}/func_preproc/logs"

    if [[ ! -d ${logs_dir} ]]; then
        mkdir -p ${logs_dir}
    fi

    # if [[ -e "${logs_dir}/Output_AFNICVR_sub-${sub[$i]}_ses-${ses}_run-${run}_task-${task}_model-${ftype}.txt" ]]; then
    # rm ${logs_dir}/Output_AFNICVR_sub-${sub[$i]}_ses-${ses}_run-${run}_task-${task}_model-${ftype}.txt
    # fi
    
    #Func File
    func_in="sub-${sub[$i]}_ses-${ses_func[$i]}_task-${task}_run-${run}_optcom_bold_sm"

    #Mask
    fmask="sub-${sub[$i]}_ses-${ses_func[$i]}_task-${task}_optcom_mask"

    # #MEICA folder where manual classification is stored
    # MEICA=${PRJDIR}/sub-${sub[$i]}/ses-${ses[i]}/tmp/task-${task}/sub-${sub[$i]}_ses-${ses[$i]}_task-${task}_run-${run}_meica
    
    #demat matrices initial: deman and derivatives 
    demean="sub-${sub[$i]}_ses-${ses_func[$i]}_task-${task}_run-${run}_echo-1_bold_cr_mcf_demean"
    deriv="sub-${sub[$i]}_ses-${ses_func[$i]}_task-${task}_run-${run}_echo-1_bold_cr_mcf_deriv1"

    if [[ -e "${logs_dir}/log_AFNICVR_presurgical_sub-${sub[$i]}_ses-${ses_func[$i]}_run-${run}_task-${task}_model-${ftype}.txt" ]]; then
        rm ${logs_dir}/log_AFNICVR_presurgical_sub-${sub[$i]}_ses-${ses_func[$i]}_run-${run}_task-${task}_model-${ftype}.txt
    fi

    qsub -q long.q -N "sub-${sub[$i]}" \
        -o "${logs_dir}/log_AFNICVR_presurgical_sub-${sub[$i]}_ses-${ses_func[$i]}_run-${run}_task-${task}_model-${ftype}.txt" \
        -e "${logs_dir}/log_AFNICVR_presurgical_sub-${sub[$i]}_ses-${ses_func[$i]}_run-${run}_task-${task}_model-${ftype}.txt" \
        ${script_path}/AFNI_CVR.sh ${sub[$i]} ${ses_func[$i]} ${task} ${run} ${PRJDIR} ${fdir} ${ftype} \
        "${lag}" "${step}" "${freq}" "${step_idx}" "${pval}" "${lag_pcorr}" "${fdir}"/"${func_in}" "${fdir}"/"${fmask}" \
        "${fdir}"/"${demean}" "${fdir}"/"${deriv}" 
done      
                
