#!/usr/bin/env bash
#$ -cwd
#$ -o out.txt
#$ -e err.txt
#$ -m be
#$ -M c.comella@bcbl.eu
#$ -N TA
#$ -S /bin/bash
#$ -q long.q

######### Phys2CVR with nontumour mask as ROI
# Author:  Cristina Comella
# Version: 1.0
# Date:    10/08/2023
#########

#Load in Cajal01 all the module necessary 
#In module load python/python3.6 there ir phys2cvr lastest version 
module load python/python3.6
module load afni/latest

PRJDIR="/bcbl/home/public/CVR/PRESURGICAL_BIDS"
#Patients
#Variables
# sub=(046 050 052 054 055 056 057 058 059 060 061 062 063 064 065 47 49 53)

# #Anatomical Sesion and Functional Sesion
# ses_anat=(1 1 1 1 1 1 1 1 2 1 1 1 1 1 1 1 1 1)
# ses_func=(1 1 1 1 2 1 1 1 2 1 1 1 1 1 1 1 1 2)
# run=1
# task=BH
# model=cons
# tumor=(s4 s4 s4 s4 s4 s4 s4 s6 s6 s6 s6 s4 s4 s6 s4 s2 s s4)


sub=(054)

#Anatomical Sesion and Functional Sesion
ses_anat=(1)
ses_func=(1)
run=1
task=BH
model=cons
tumor=(s4)

for i in 0 #$(seq 0 16); 
do
    #Indicate the Fun_preproc directory
    wdr_anatpreproc=${PRJDIR}/sub-${sub[$i]}/ses-${ses_anat[$i]}/anat_preproc
    wdr_funcpreproc=${PRJDIR}/sub-${sub[$i]}/ses-${ses_func[$i]}/func_preproc
    echo "The func preproc diretory is $wdr_funcpreproc and the anat preproc directory is in $anat_preproc"

    cvr_folder=${wdr_funcpreproc}/phys2cvr_cons_nontumor_mask

     #Create phys2cvr_cons_nontumour folder for working directory (anat_preproc) if it dosent exist 
        if [[ ! -d "${wdr_funcpreproc}/phys2cvr_cons_nontumor_mask" ]]; then
            echo "Creating folder ${cvr_folder}"
            mkdir -p "${cvr_folder}"
        fi

    cd $cvr_folder

    # phys2cvr calculates the signal percentage change internally. So no need to do it before.
    #Indicate the bold signal and mask 
    #func_in=$6
    func_in="sub-${sub[$i]}_ses-${ses_func[$i]}_task-${task}_run-${run}_optcom_bold_sm"
    echo $func_in

    #fmask=${7}
    fmask="sub-${sub[$i]}_ses-${ses_func[$i]}_task-${task}_optcom_mask"
    echo $fmask

    #froi=${8} rbin_s4_nontumor_mask_al_epi.nii
    froi="rbin_${tumor[$i]}_nontumor_mask_al_epi"
    echo $froi


    #CO2 file that is in the Peakdet folder 
    #co2file=$8
    co2file="/bcbl/home/public/CVR/PRESURGICAL_BIDS/Peakdet/sub-${sub[$i]}_task-breathhold_recording-125Hz_physio_peak_ch-co2.phys"
    echo $co2file


    #MEICA folder where manual classification is stored
    MEICA=${PRJDIR}/sub-${sub[$i]}/ses-${ses_func[$i]}/tmp/task-${task}/sub-${sub[$i]}_ses-${ses_func[$i]}_task-${task}_run-${run}_meica
    echo $MEICA

    #demat matrices initial: deman and derivatives 
    demat="sub-${sub[$i]}_ses-${ses_func[$i]}_task-${task}_run-${run}_echo-1_bold_cr_mcf"
    echo $demat

    #Indicate all the variables needed for phys2cvr (will be ask outside the function)

    #Legendre polynomial 
    ldeg=4
    #Lag considered
    lm=9
    #Lag step
    ls=0.3
    #scale factor for beta maps will be divided to create CVR maps 
    scale=71.2


    # conservative approach (cons)

    if [ "${model}" == "cons" ]; then

		echo "************************************"
        echo "***Compute the conservative approach*"
		echo "************************************"
        
        # echo " phys2cvr -i "${wdr_funcpreproc}/${func_in}.nii.gz" -o "${wdr_funcpreproc}/CVR_cons_nontumor_mask" -r ${wdr_anatpreproc}/${froi}.nii -m "${wdr_funcpreproc}/${fmask}.nii.gz" -co2 ${co2file} -ldeg "${ldeg}" \
        #     -dmat "${wdr_funcpreproc}/${demat}_demean.1D" "${wdr_funcpreproc}/${demat}_deriv1.1D" -omat "${MEICA}/ICA_components_rejected.1D"  \
        #     -emat "${MEICA}/ICA_components_accepted.1D" -scale "${scale}" -lm "${lm}" -ls "${ls}" --r2full -debug"
    
        # phys2cvr -i "${wdr_funcpreproc}/${func_in}.nii.gz" -o "${wdr_funcpreproc}/CVR_cons_nontumor_mask" -r "${wdr_anatpreproc}/${froi}.nii" -m "${wdr_funcpreproc}/${fmask}.nii.gz" -co2 ${co2file} -ldeg ${ldeg} \
        #     -dmat "${wdr_funcpreproc}/${demat}_demean.1D" "${wdr_funcpreproc}/${demat}_deriv1.1D" -omat "${MEICA}/ICA_components_rejected.1D"  \
        #     -emat "${MEICA}/ICA_components_accepted.1D" -scale ${scale} -lm ${lm} -ls ${ls} --r2full -debug -overwrite

        echo " phys2cvr -i "${wdr_funcpreproc}/${func_in}.nii.gz" -o "${cvr_folder}" -r ${wdr_anatpreproc}/${froi}.nii -m "${wdr_funcpreproc}/${fmask}.nii.gz" -co2 ${co2file} -ldeg "${ldeg}" \
            -dmat "${wdr_funcpreproc}/${demat}_demean.1D" "${wdr_funcpreproc}/${demat}_deriv1.1D" -omat "${MEICA}/ICA_components_rejected.1D"  \
            -emat "${MEICA}/ICA_components_accepted.1D" -scale "${scale}" -lm "${lm}" -ls "${ls}" --r2full -debug"
    
        phys2cvr -i "${wdr_funcpreproc}/${func_in}.nii.gz" -o "${cvr_folder}" -r "${wdr_anatpreproc}/${froi}.nii" -m "${wdr_funcpreproc}/${fmask}.nii.gz" -co2 ${co2file} -ldeg ${ldeg} \
            -dmat "${wdr_funcpreproc}/${demat}_demean.1D" "${wdr_funcpreproc}/${demat}_deriv1.1D" -omat "${MEICA}/ICA_components_rejected.1D"  \
            -emat "${MEICA}/ICA_components_accepted.1D" -scale ${scale} -lm ${lm} -ls ${ls} --r2full -debug


    fi


    echo "3dcalc -a "${cvr_folder}/phys2cvr_cons_nontumor_mask/sub-${sub[$i]}_ses-${ses_func[i]}_task-${task}_run-${run}_optcom_bold_sm_cvr.nii.gz" -expr 'a/0.0712' \
            -prefix "${wdr_funcpreproc}/phys2cvr_cons_nontumor_mask/sub-${sub[$i]}_ses-${ses_func[i]}_task-${task}_run-${run}_optcom_bold_sm_cvr_scaled.nii.gz""
               
    3dcalc -a "${cvr_folder}/sub-${sub[$i]}_ses-${ses_func[i]}_task-${task}_run-${run}_optcom_bold_sm_cvr.nii.gz" -expr 'a/0.0712' \
            -prefix "${wdr_funcpreproc}/phys2cvr_cons_nontumor_mask/sub-${sub[$i]}_ses-${ses_func[i]}_task-${task}_run-${run}_optcom_bold_sm_cvr_scaled.nii.gz" 
    
done

    # echo "3dcalc -a "${cvr_folder}/phys2cvr_cons_nontumor_mask/sub-${sub[$i]}_ses-${ses_func[i]}_task-${task}_run-${run}_optcom_bold_sm_cvr.nii.gz" -expr 'a/0.0712' \
    #         -prefix "${wdr_funcpreproc}/phys2cvr_cons_nontumor_mask/sub-${sub[$i]}_ses-${ses_func[i]}_task-${task}_run-${run}_optcom_bold_sm_cvr_scaled.nii.gz""
               
    # 3dcalc -a sub-064_ses-1_task-BH_run-1_optcom_bold_sm_cvr.nii.gz -expr 'a/0.0712' \
    #         -prefix sub-064_ses-1_task-BH_run-1_optcom_bold_sm_cvr_scaled.nii.gz -overwrite
