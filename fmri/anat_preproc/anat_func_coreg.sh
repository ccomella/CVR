#!/usr/bin/env bash
#$ -cwd
#$ -m be
#$ -M c.comella@bcbl.eu
#$ -N TA
#$ -S /bin/bash
#$ -q long.q

######### AFNI CVR MAPS for Presurgical Patients
# Author:  Cristina Comella
# Version: 1.0
# Date:    22.03.2023
#########

module load python/venv
module load afni/latest

#Working Directory
sub=$1
ses=$2
task=$3
run=$4

#Project Directory
PRJDIR="/bcbl/home/public/CVR/PRESURGICAL_BIDS"
anat_dir="${PRJDIR}/sub-${sub}/ses-${ses}/anat"
func_dir="${PRJDIR}/sub-${sub}/ses-${ses}/func"
anat_preproc="${PRJDIR}/sub-${sub}/ses-${ses}/anat_preproc"
func_preproc="${PRJDIR}/sub-${sub}/ses-${ses}/func_preproc"
tmp_dir="${PRJDIR}/sub-${sub}/ses-${ses}/tmp/task-${task}"



anat_t1="sub-${sub}_ses-${ses}_run-${run}_UNIT1"
anat_t2="sub-${sub}_ses-${ses}_acq-t2spacesagp21isoMGH_run-${run}_T2w"
sbrf="sub-${sub}_ses-${ses}_task-${task}_run-${run}_echo-1_sbref"
func_mask="sub-${sub}_ses-${ses}_task-${task}_run-${run}_echo-1_bold_brain_mask"

if [[ ! -d ${anat_preproc} ]]; then
    echo "Creating folder ${anat_preproc}"
    mkdir ${anat_preproc}
fi

# echo "Perform skull stripping of T1-w anatomical image"

# Skull-stripping of MP2RAGE image does not work directly with AFNI. We need to explore other options. 
# For instance, https://github.com/srikash/3dMPRAGEise
# We could also use @SSwarper as described in https://neurostars.org/t/mp2rage-background-removal-in-lemon-dataset/19987/5
# see also https://github.com/JosePMarques/MP2RAGE-related-scripts

# 3dSkullStrip -input ${anat_dir}/${anat_t1}.nii.gz -prefix ${anat_preproc}/${anat_t1}_brain.nii.gz

echo "Perform skull stripping of T2-w anatomical image"
3dSkullStrip -input ${anat_dir}/${anat_t2}.nii.gz -prefix ${anat_preproc}/${anat_t2}_brain.nii.gz -push_to_edge -overwrite

echo "Apply EPI mask to SBref volume"
3dcalc -a ${func_dir}/${sbrf}.nii.gz -m ${tmp_dir}/${func_mask}.nii.gz -expr "a*m" -prefix ${tmp_dir}/${sbrf}_brain.nii.gz -overwrite

3dcopy ${anat_preproc}/${anat_t2}_brain.nii.gz ${anat_preproc}/${anat_t2}_brain -overwrite

echo "Coregister skull stripped T1-w anatomical image to functional reference volumen"
cd ${anat_preproc}
# convert to afni format because align_epi_anat appends suffix into AFNI-like filenames
3dcopy ${anat_preproc}/${anat_t2}_brain.nii.gz ${anat_preproc}/${anat_t2}_brain -overwrite
# align_epi_anat will use the cost function lpa because the T2w and functional data have the same contrast
align_epi_anat.py -anat ${anat_preproc}/${anat_t2}_brain+orig -epi ${tmp_dir}/${sbrf}_brain.nii.gz -epi_base 0 \
    -anat2epi -suffix _al_epi -cost lpa -big_move -anat_has_skull no -epi_strip None -volreg off -tshift off -overwrite
# convert again to NIFTI volumes and remove the AFNI format volumes
3dcalc -a ${anat_preproc}/${anat_t2}_brain_al_epi+orig -expr 'a' -prefix ${anat_preproc}/${anat_t2}_brain_al_epi.nii.gz -overwrite 
rm ${anat_preproc}/${anat_t2}_brain*HEAD ${anat_preproc}/${anat_t2}_brain*BRIK



