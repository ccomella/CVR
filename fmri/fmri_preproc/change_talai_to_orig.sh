#!/usr/bin/env bash
#$ -cwd
#$ -o out.txt
#$ -e err.txt
#$ -m be
#$ -M c.comella@bcbl.eu
#$ -N TA
#$ -S /bin/bash
#$ -q long.q

######### Convert TALAI to ORIG files
# Author:  Cristina Comella
# Version: 1.0
# Date:    07/08/2023
#########

module load afni/latest

#GROUP 1: Folders name = Files name
#Patients
#Variables
sub=(046 050 052 054 055 056 057 058 059 060 061 062 063 064 065 47 49 53)
#Anatomical Sesion
ses=(1 1 1 1 1 1 1 1 2 1 1 1 1 1 1 1 1 1)

#Variables in name of the file
presurgical=(Presurgical Presurgical Presurgical Presurgical Presurgical Presurgical PRESURGICAL Presurgical Presurgical PRESURGICAL PRESURGICAL PRESURGICAL PRESURGICAL Presurgical PRESURGICAL PRESURGICAL Presurgical Presurgical)
name=(GLIOCOM_KGH GLIOCOM_MCL IBM ARG JLS JH ETM DUP ISO SIH IZG TMR MGLM MLS HAS EJCR MHB Epiconn_OADM)
date=(20210302 20210916 20211013 20220118 20220126 20220210 20220322 20220519 20220718 20221115 20230116 20230201 20230207 20230214 20230309 20210326 20210713 20211028)
num=(006 025 025 025 006 025 025 029 025 025 025 025 025 025 025 025 025 006)
tumor=(s4 s4 s4 s4 s4 s4 s4 s6 s4 s4 s6 s4 s4 s6 s4 s2 s s4)

for i in $(seq 0 17); 
do  
    wdr="/bcbl/home/public/CVR/PRESURGICAL_BIDS/sub-${sub[i]}/ses-${ses[i]}/anat_preproc"
    files_to_change=("c1tb_${sub[i]}_${presurgical[i]}_${name[i]}_${date[i]}_001_${num[i]}_t1_mprage_sag_p2_1iso_MGH.nii" "c2tb_${sub[i]}_${presurgical[i]}_${name[i]}_${date[i]}_001_${num[i]}_t1_mprage_sag_p2_1iso_MGH.nii" "c3tb_${sub[i]}_${presurgical[i]}_${name[i]}_${date[i]}_001_${num[i]}_t1_mprage_sag_p2_1iso_MGH.nii" "tb_${sub[i]}_${presurgical[i]}_${name[i]}_${date[i]}_001_${num[i]}_t1_mprage_sag_p2_1iso_MGH.nii" "rbin_${tumor[i]}_Tumor.nii")
    
    for fname in "${files_to_change[@]}"
    do
        3drefit -space ORIG -view orig ${wdr}/${fname}
        echo "Change ${sub[i]} file in ${wdr}/${fname} to orig"
    done

done

#NOTA FALTA 47 49 Y 53

# # apply masks to EPI sbref and anatomical
# # 3dcalc 

# # remember that the anatomical dataset for align_epi_anat must be in afni format (i.e. +orig), so you can save them directly with 3dcalc in this format
# align_epi_anat.py -anat tb_054_T1w_ns+orig. -epi sub-054_ses-1_task-BH_run-1_echo-1_sbref_brain.nii.gz -epi_base 0 -anat2epi -suffix _al_epi -anat_has_skull no -cost lpa -giant_move -epi_strip None -volreg off -tshift off -overwrite

# # apply this spatial transformation to the nontumor brain mask
# 3dAllineate -overwrite -base sub-054_ses-1_task-BH_run-1_echo-1_sbref_brain.nii.gz -1Dmatrix_apply tb_054_T1w_nsal_epi_mat.aff12.1D -final NN -prefix rbin_s4_nontumor_al_epi.nii rbin_s4_nontumor.nii

# # refine nontumor brain mask (but not use fill holes because it will close the tumor unless it is located in the borders of the brain)
# 3dmask_tool -input rbin_s4_nontumor_al_epi.nii -dilate_inputs +1 -1 -prefix rbin_s4_nontumor_al_epi.nii -overwrite

# # multiply by the functional brain mask because the anatomical brain mask always has larger extent (e.g. in areas with signal dropout)
# 3dcalc -a rbin_s4_nontumor_al_epi.nii -b sub-054_ses-1_task-BH_optcom_mask.nii.gz -expr 'a*b' -prefix rbin_s4_nontumor_al_epi.nii -overwrite


