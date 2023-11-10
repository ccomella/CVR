#!/usr/bin/env bash

######### CVR analysis preprocessing and analysis per subject
# Author:  Cristina Comella
# Version: 1.0
# Date:    09.02.2023
#########

#!bin/bash

module load freesurfer/7.2.0
module load afni/latest
module load python/python3.6

PRJDIR="/bcbl/home/public/CVR/PRESURGICAL_BIDS"
SCRIPTS_DIR=/bcbl/home/public/CVR/Scripts/fmri
SCRIPTS_PREPROC_DIR="${SCRIPTS_DIR}/fmri_preproc"
SCRIPTS_ANALYSIS_DIR="${SCRIPTS_DIR}/fmri_analysis"

# acquisition parameters
TEs="10.6 28.69 46.78 64.87"
nTE=4

# preprocessing parameters
vdsc=10 # volumes to cut to achieve steady state magnetization
std=MNI152_2009_template.nii.gz # Template for normalization
mmres=2.4 # final spatial resolution in template space
fwhm=2 # full-width half maximum spatial smoothing
polort=5 # order of legendre polynomials for detrending

siot=none  # If != none, perform slice timing correction
# slice order file (full path to)
# siot=${wdr}/sliceorder.txt

dspk=none # If != none, perform despiking

step=2 # step = 1 will perform up to TEDANA (ME-ICA classification), step = 2 will use manual classication and perform or the rest of preprocessing

# BIDS parameters
TASK=BH # name of task for BIDS purposes

# sub=$1
# ses=$2
# run=$3
# wdr_preproc=$4
# wdr_analysis=$5
# task=$6
# preproc=$7 #If != none, performe preprocessing
# PRJDIR= $8

set -e  
SUBJ=(058)
SES=(1)
run=1
# task=BH
preproc=0 #preproc is 1, do preprocessing
docvr=1

for i in '0'
do 
  if [ "${preproc}" -eq 1 ]; then

    adir="${PRJDIR}/sub-${SUBJ[$i]}/ses-${SES[$i]}/anat"   
    anat="sub-${SUBJ[$i]}_ses-${SES[$i]}_run-${run}} _T1w.nii.gz"
    unidir="${PRJDIR}/sub-${SUBJ[$i]}/ses-${SES[$i]}/anat"
    aseg="sub-${SUBJ[$i]}_ses-${SES_ANAT[$i]}_run-${RUN} _T1w.nii.gz"
    fdir="${PRJDIR}/sub-${SUBJ[$i]}/ses-${SES[$i]}/func_preproc"
    
    ${SCRIPTS_PREPROC_DIR}/full_preproc.sh ${SUBJ[$i]} ${SES[$i]} ${run} ${PRJDIR} ${task} \
      "${adir}"/"${anat}"\
      "${fdir}" "${vdsc}" "${TEs}" "${nTE}" \
      "${siot}" "${dspk}" \
      "${SCRIPTS_PREPROC_DIR}" "${step}" \
      "${fwhm}" "${polort}" "${std}" "${mmres}"

    echo "Preprocessing done for ${SUBJ[$i]} in session ${SES[$i]}"

  fi

# if [ "${func_in}" = "none"]; then
#   func_in="sub-${sub}_ses-${ses}_task-${task}_run-${run}_optcomDenoised_bold"
# fi

  if [ "${docvr}" -eq 1 ]; then

    fdir="${PRJDIR}/sub-${SUBJ[$i]}/ses-${SES[$i]}/func_preproc"
    #3dcopy -overwrite "${PRJDIR}/Peakdet/sub-${SUBJ[i]}_task-breathhold_recording-125Hz_physio_peak_ch-co2.phys" "${PRJDIR}/sub-${SUBJ[$i]}/ses-${SES[$i]}/func_preproc"
    func_in="${PRJDIR}/sub-${SUBJ[i]}/ses-${SES[$i]}/func_preproc/sub-${SUBJ[i]}_ses-${SES[i]}_task-${TASK}_run-${run}_optcomDenoised_bold"
    fmask="${PRJDIR}/sub-${SUBJ[i]}/ses-${SES[$i]}/func_preproc/sub-${SUBJ[i]}_ses-${SES[i]}_task-${TASK}_optcom_mask"
    co2file="${PRJDIR}/sub-${SUBJ[i]}/ses-${SES[$i]}/func_preproc/sub-${SUBJ[i]}_task-breathhold_recording-125Hz_physio_peak_ch-co2.phys"

    # parameters for CVR fitting model
    fs_co2=40
    lm=9
    ls=1
    tlen=58
    ntrail=8
    ldeg=5

    # generate output folder according to CVR parameters
    out_dir="${fdir}/CVR/CVR_simple"
    out_dir2="${fdir}/CVR/CVR_ldeg5_ntrial8"

    ${SCRIPTS_ANALYSIS_DIR}/analysis_phys2cvr.sh ${SUBJ[$i]} ${SES[i]} ${run} ${TASK} ${fdir} \
      ${func_in} ${fmask} ${co2file} ${fs_co2} ${lm} ${ls} ${tlen} ${ntrail} ${ldeg}
    
  fi

done        
            

# "${tlen}" \
#             "${ntrial}" "${ldeg}" \
#             "${dmat}"\
            

# phys2cvr 
# -i sub-050_ses-1_task-BH_run-1_optcomDenoised_bold.nii.gz 
# -o ./CVR/CVR_ldeg5_ntrial8_dmat -m sub-050_ses-1_task-BH_optcom_mask.nii.gz 
# -co2 sub-050_task-breathhold_recording-125Hz_physio_peak_ch-co2.phys 
# -lm 9 -ls 1 --r2full -tlen 58 -ntrial 8 -ldeg 5 -dmat sub-050_ses-1_task-BH_run-1_echo-1_bold_cr_mcf_demean.1D -dmat sub-050_ses-1_task-BH_run-1_echo-1_bold_cr_mcf_deriv1.1D

            # qsub -q long.q -N "sub-${SUBJ[$i]}" \
            #      -o /bcbl/home/public/CVR/PRESURGICAL_BIDS/Output_sub-${SUBJ[$i]}_ses-${SES_FUNC}_run-${RUN}_task-${TASK}.txt \
            #      -e /bcbl/home/public/CVR/PRESURGICAL_BIDS/Output_sub-${SUBJ[$i]}_ses-${SES_FUNC}_run-${RUN}_task-${TASK}.txt\