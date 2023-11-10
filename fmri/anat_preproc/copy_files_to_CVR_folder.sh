#!/usr/bin/env bash
#$ -cwd
#$ -o out.txt
#$ -e err.txt
#$ -m be
#$ -M c.comella@bcbl.eu
#$ -N TA
#$ -S /bin/bash
#$ -q long.q

######### Copy files from Presurgical Ileana to CVR
# Author:  Cristina Comella
# Version: 1.0
# Date:    04/08/2023
#########

module load python/python3.6
source activate /bcbl/home/public/CVR/py_3.9
module load afni/latest

#This steps are divided into 3 groups depending on how there are save

# #GROUP 1: Folders name = Files name
# #Patients
# sub=(046 050 054 056 057 058 061 062 063 064 065)
# #Anatomical Sesion
# ses=(1 1 1 1 1 1 1 1 1 1 1)

# presurgical=(Presurgical Presurgical Presurgical Presurgical PRESURGICAL Presurgical PRESURGICAL PRESURGICAL PRESURGICAL Presurgical PRESURGICAL)
# name=(GLIOCOM_KGH GLIOCOM_MCL ARG JH ETM DUP ISO TMR MGLM MLS HAS)
# date=(20210302 20210916 20220118 20220210 20220322 20220519 20230116 20230201 20230207 20230214 20230309)
# num=(006 025 025 025 025 029 025 025 025 025 025)
# tumor=(s4 s4 s4 s4 s4 s6 s6 s4 s4 s6 s4)

sub=(067)
#Anatomical Sesion
ses=(1)

presurgical=(Presurgical)
name=(SLD)
date=(20230928)
num=(028)
tumor=(s6)
#Loop for each subject
for i in 0 #$(seq 0 9); 
do  
    #wdr_anat="/bcbl/home/public/CVR/PRESURGICAL_BIDS/sub-${sub[i]}/ses-${ses[i]}/anat_preproc"
    wdr_anat="/bcbl/home/public/CVR/PRESURGICAL_BIDS/PRESURGICAL/sub-${sub[i]}/ses-${ses[i]}/anat_preproc"
    #Create anat_preproc folder for working directory (anat_preproc) if it dosent exist 
        if [[ ! -d "${wdr_anat}" ]]; then
            echo "Creating folder ${wdr_anat}"
            mkdir -p "${wdr_anat}"
        fi

    #Second Directory: Presurgical_Ileana
    wdr_ileana="/bcbl/home/public/Presurgical_Ileana/Morphometry/${sub[i]}_Presurgical_${name[i]}_Preop/T1_sag"

    #Files to copy is a list of all of the files I want to copy, if you need to copy new ones, just add them to the list
    #In this case files to copy are: the three files (c1, c2, c3) which added form the brain mask, and rbin tumor and tumor 
    files_to_copy=("c1tb_${sub[i]}_${presurgical[i]}_${name[i]}_${date[i]}_001_${num[i]}_t1_mprage_sag_p2_1iso_MGH.nii" "c2tb_${sub[i]}_${presurgical[i]}_${name[i]}_${date[i]}_001_${num[i]}_t1_mprage_sag_p2_1iso_MGH.nii" "c3tb_${sub[i]}_${presurgical[i]}_${name[i]}_${date[i]}_001_${num[i]}_t1_mprage_sag_p2_1iso_MGH.nii" "tb_${sub[i]}_${presurgical[i]}_${name[i]}_${date[i]}_001_${num[i]}_t1_mprage_sag_p2_1iso_MGH.nii" "${tumor[i]}_Tumor.nii" "rbin_${tumor[i]}_Tumor.nii")
    
    for file in "${files_to_copy[@]}"; do
        cp "${wdr_ileana}/${file}" "${wdr_anat}"
        echo "Copied ${file}" to ${wdr_anat} 
    done    
done

# #GROUP 2: Folders name different to Files name

# #Patients
# sub_2=(052 055 059 060)
# ses_2=(1 1 2 1)
# presurgical_2=(Presurgical Presurgical Presurgical PRESURGICAL)
# name_2=(IBM JLS SIH IZG)
# date_2=(20211013 20220126 20220718 20221115)
# num_1=(001 001 002 001)
# num_2=(025 006 025 025)
# tumor_2=(s4 s4 s6 s6)

# for i in $(seq 0 3); 
# do  
#     #Create anat_preproc folder in patients from group 2
#     wdr_anat="/bcbl/home/public/CVR/PRESURGICAL_BIDS/sub-${sub_2[i]}/ses-${ses_2[i]}/anat_preproc"
#         if [[ ! -d "${wdr_anat}" ]]; then
#             echo "Creating folder ${wdr_anat}"
#             mkdir -p "${wdr_anat}"
#         fi

#     #Second Directory: Presurgical_Ileana
#     wdr_ileana="/bcbl/home/public/Presurgical_Ileana/Morphometry/${sub_2[i]}_Presurgical_GLIOCOM_${name_2[i]}_Preop/T1_sag"
    
#     #In this case files to copy are: the three files (c1, c2, c3) which added form the brain mask, and rbin tumor and tumor 
#     files_to_copy=("c1tb_${sub_2[i]}_${presurgical_2[i]}_${name_2[i]}_${date_2[i]}_${num_1[i]}_${num_2[i]}_t1_mprage_sag_p2_1iso_MGH.nii" "c2tb_${sub_2[i]}_${presurgical_2[i]}_${name_2[i]}_${date_2[i]}_${num_1[i]}_${num_2[i]}_t1_mprage_sag_p2_1iso_MGH.nii" "c3tb_${sub_2[i]}_${presurgical_2[i]}_${name_2[i]}_${date_2[i]}_${num_1[i]}_${num_2[i]}_t1_mprage_sag_p2_1iso_MGH.nii" "tb_${sub_2[i]}_${presurgical_2[i]}_${name_2[i]}_${date_2[i]}_${num_1[i]}_${num_2[i]}_t1_mprage_sag_p2_1iso_MGH.nii" "${tumor_2[i]}_Tumor.nii" "rbin_${tumor_2[i]}_Tumor.nii")
   
#     for file in "${files_to_copy[@]}"; do
#         cp "${wdr_ileana}/${file}" "${wdr_anat}"
#         echo "Copied ${file}" to ${wdr_anat} 
#     done    
# done


# #GROUP 3: Patients in CVR save differently from Presurgical (ex: 047 and 47)
# sub_3=(047 049)
# ses_3=(1 1)
# presurgical_3=(PRESURGICAL Presurgical)
# name_3=(EJCR MHB)
# date_3=(20210326 20210713)
# num_3=(025 025)
# tumor_3=(s2_tumor sTumor)

# #After cp files, need to rename them as the folder in CVR is different
# new_sub=(47 49)
# for i in $(seq 0 1); 
# do  
#     #Create anat_preproc folder for working 
#     wdr_anat="/bcbl/home/public/CVR/PRESURGICAL_BIDS/sub-${new_sub[i]}/ses-${ses_3[i]}/anat_preproc"
#         if [[ ! -d "${wdr_anat}" ]]; then
#             echo "Creating folder ${wdr_anat}"
#             mkdir -p "${wdr_anat}"
#         fi

#     #Second Directory: Presurgical_Ileana
#     wdr_ileana_3="/bcbl/home/public/Presurgical_Ileana/Morphometry/${sub_3[i]}_Presurgical_GLIOCOM_${name_3[i]}_Preop/T1_sag"

#     #In this case files to copy are: the three files (c1, c2, c3) which added form the brain mask, and rbin tumor and tumor 
#     files_to_copy=("c1tb_${sub_3[i]}_${presurgical_3[i]}_${name_3[i]}_${date_3[i]}_001_${num_3[i]}_t1_mprage_sag_p2_1iso_MGH.nii" "c2tb_${sub_3[i]}_${presurgical_3[i]}_${name_3[i]}_${date_3[i]}_001_${num_3[i]}_t1_mprage_sag_p2_1iso_MGH.nii" "c3tb_${sub_3[i]}_${presurgical_3[i]}_${name_3[i]}_${date_3[i]}_001_${num_3[i]}_t1_mprage_sag_p2_1iso_MGH.nii" "tb_${sub_3[i]}_${presurgical_3[i]}_${name_3[i]}_${date_3[i]}_001_${num_3[i]}_t1_mprage_sag_p2_1iso_MGH.nii" "${tumor_3[i]}.nii" "rbin_${tumor_3[i]}.nii")
#     for file in "${files_to_copy[@]}"; do
#         cp "${wdr_ileana_3}/${file}" "${wdr_anat}"
#         echo "Copied ${file}" to ${wdr_anat} 
#     done 
# done

# #GROUP 4: SUb 053 que no tiene el GLIOCOM
# sub_53=053
# ses_53=1
# new_sub53=53
# presurgical_53=Presurgical
# name_53=Epiconn_OADM
# date_53=20211028
# num_53=006
# tumor_53=s4_Tumor

# #Create anat_preproc folder for working 
# wdr_anat="/bcbl/home/public/CVR/PRESURGICAL_BIDS/sub-${new_sub53}/ses-${ses_53}/anat_preproc"

# if [[ ! -d "${wdr_anat}" ]]; then
#     echo "Creating folder ${wdr_anat}"
#      mkdir -p "${wdr_anat}"
# fi

# #Second Directory: Presurgical_Ileana
# wdr_ileana_53="/bcbl/home/public/Presurgical_Ileana/Morphometry/${sub_53}_Presurgical_${name_53}_Preop/T1_sag"

# #In this case files to copy are: the three files (c1, c2, c3) which added form the brain mask, and rbin tumor and tumor 
# files_to_copy=("c1tb_${sub_53}_${presurgical_53}_${name_53}_${date_53}_001_${num_53}_t1_mprage_sag_p2_1iso_MGH.nii" "c2tb_${sub_53}_${presurgical_53}_${name_53}_${date_53}_001_${num_53}_t1_mprage_sag_p2_1iso_MGH.nii" "c3tb_${sub_53}_${presurgical_53}_${name_53}_${date_53}_001_${num_53}_t1_mprage_sag_p2_1iso_MGH.nii" "tb_${sub_53}_${presurgical_53}_${name_53}_${date_53}_001_${num_53}_t1_mprage_sag_p2_1iso_MGH.nii" "${tumor_53}.nii" "rbin_${tumor_53}.nii")

# for file in "${files_to_copy[@]}"; do
#      cp "${wdr_ileana_53}/${file}" "${wdr_anat}"
#     echo "Copied ${file}" to ${wdr_anat} 
# done 


# #Variables
# sub_all=(046 050 052 054 055 056 057 058 059 060 061 062 063 064 065 47 49 53)
# #Anatomical Sesion
# ses_anat=(1 1 1 1 1 1 1 1 2 1 1 1 1 1 1 1 1 1)
# ses_func=(1 1 1 1 2 1 1 1 2 1 1 1 1 1 1 1 1 2)

sub_all=(067)
#Anatomical Sesion
ses_anat=(1)
ses_func=(1)

#Copy files of interst to anat_preproc

PRJDIR="/bcbl/home/public/CVR/PRESURGICAL_BIDS/PRESURGICAL"

for i in 0 #$(seq 0 17); 
do  
    wdr_anatpreproc=${PRJDIR}/sub-${sub_all[i]}/ses-${ses_anat[i]}/anat_preproc
    wdr_funcpreproc=${PRJDIR}/sub-${sub_all[i]}/ses-${ses_func[i]}/func_preproc
    wdr_func=${PRJDIR}/sub-${sub_all[i]}/ses-${ses_func[i]}/func
    files_to_change_funcpreproc=("sub-${sub_all[i]}_ses-${ses_func[i]}_task-BH_optcom_mask.nii.gz" "sub-${sub_all[i]}_ses-${ses_func[i]}_task-BH_run-1_optcom_bold_sm.nii.gz")
    files_to_change_func=("sub-${sub_all[i]}_ses-${ses_func[i]}_task-BH_run-1_echo-1_sbref.nii.gz")
    
    for fname in "${files_to_change_funcpreproc[@]}"
    do
        cp "${wdr_funcpreproc}/${fname}" "${wdr_anatpreproc}"
        echo "Copied ${fname}" to ${wdr_anatpreproc}
    done

    for fname in "${files_to_change_func[@]}"
    do
        cp "${wdr_func}/${fname}" "${wdr_anatpreproc}"
        echo "Copied ${fname}" to ${wdr_anatpreproc}
    done
   


done


