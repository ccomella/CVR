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


#PRJDIR="/bcbl/home/public/CVR/PRESURGICAL_BIDS"

PRJDIR="/bcbl/home/public/CVR/PRESURGICAL_BIDS/PRESURGICAL"
# #Patients
# #Variables
# sub=(046 050 052 054 055 056 057 058 059 060 061 062 063 064 065 47 49 53)
# #Anatomical Sesion
# ses=(1 1 1 1 1 1 1 1 2 1 1 1 1 1 1 1 1 1)

# #Variables in name of the file
# presurgical=(Presurgical Presurgical Presurgical Presurgical Presurgical Presurgical PRESURGICAL Presurgical Presurgical PRESURGICAL PRESURGICAL PRESURGICAL PRESURGICAL Presurgical PRESURGICAL PRESURGICAL Presurgical Presurgical)
# name=(GLIOCOM_KGH GLIOCOM_MCL IBM ARG JLS JH ETM DUP SIH IZG ISO TMR MGLM MLS HAS EJCR MHB Epiconn_OADM)
# date=(20210302 20210916 20211013 20220118 20220126 20220210 20220322 20220519 20220718 20221115 20230116 20230201 20230207 20230214 20230309 20210326 20210713 20211028)
# num_1=(001 001 001 001 001 001 001 001 002 001 001 001 001 001 001 001 001 001)
# num_2=(006 025 025 025 006 025 025 029 025 025 025 025 025 025 025 025 025 006)
# tumor=(s4 s4 s4 s4 s4 s4 s4 s6 s6 s6 s6 s4 s4 s6 s4 s2 s s4)

sub=(067)
#Anatomical Sesion
ses=(1)

presurgical=(Presurgical)
name=(SLD)
date=(20230928)
num_1=(001)
num_2=(028)
tumor=(s6)

for i in 0 #$(seq 0 17); 
do  
    wdr=${PRJDIR}/sub-${sub[i]}/ses-${ses[i]}/anat_preproc
    files_to_change=("c1tb_${sub[i]}_${presurgical[i]}_${name[i]}_${date[i]}_${num_1[i]}_${num_2[i]}_t1_mprage_sag_p2_1iso_MGH.nii" "c2tb_${sub[i]}_${presurgical[i]}_${name[i]}_${date[i]}_${num_1[i]}_${num_2[i]}_t1_mprage_sag_p2_1iso_MGH.nii" "c3tb_${sub[i]}_${presurgical[i]}_${name[i]}_${date[i]}_${num_1[i]}_${num_2[i]}_t1_mprage_sag_p2_1iso_MGH.nii" "tb_${sub[i]}_${presurgical[i]}_${name[i]}_${date[i]}_${num_1[i]}_${num_2[i]}_t1_mprage_sag_p2_1iso_MGH.nii" "rbin_${tumor[i]}_Tumor.nii" "rbin_${tumor[i]}_Tumor.nii" "winv_wT_bin_${tumor[i]}_Tumor_flip_roi.nii")
    
    for fname in "${files_to_change[@]}"
    do
        3drefit -space ORIG -view orig ${wdr}/${fname}
        echo "Change ${sub[i]} file in ${wdr}/${fname} to orig"
    done

done




