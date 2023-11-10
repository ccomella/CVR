#!/usr/bin/env bash
#$ -cwd
#$ -o out.txt
#$ -e err.txt
#$ -m be
#$ -M c.comella@bcbl.eu
#$ -N TA
#$ -S /bin/bash
#$ -q long.q

######### Preprocessing Anatomical Images
# Author:  Cristina Comella
# Version: 1.0
# Date:    04/08/2023
#########

module load python/python3.6
source activate /bcbl/home/public/CVR/setup/conda_phys2cvr
module load afni/latest



#Variables
#sub=(046 047 049 050 052 053 054 055 056 057 058 059 060 061 062 063 064 065)
sub=(046 050 054 056 057 058 061 062 063 064 065)
#Anatomical Sesion
ses=(1 1 1 1 1 1 1 1 1 1 1)

presurgical=(Presurgical Presurgical Presurgical Presurgical PRESURGICAL Presurgical PRESURGICAL PRESURGICAL PRESURGICAL Presurgical PRESURGICAL)
name=(GLIOCOM_KGH GLIOCOM_MCL ARG JH ETM DUP ISO TMR MGLM MLS HAS)
date=(20210302 20210916 20220118 20220210 20220322 20220519 20230116 20230201 20230207 20230214 20230309)
num=(006 025 025 025 025 029 025 025 025 025 025)
tumor=(s4 s4 s4 s4 s4 s6 s6 s4 s4 s6 s4)

#First step, Copy files to anatomical folder
for i in $(seq 0 9); 
do  
    #Create anat_preproc folder for working 
    wdr_new="/bcbl/home/public/CVR/PRESURGICAL_BIDS/sub-${sub[i]}/ses-${ses[i]}/anat_preproc"
    #     if [[ ! -d "${wdr_new}" ]]; then
    #         echo "Creating folder ${wdr_new}"
    #         mkdir -p "${wdr_new}"
    #     fi

    # #Need to copy files to anatomical folder
    # wdr_ileana="/bcbl/home/public/Presurgical_Ileana/Morphometry/${sub[i]}_Presurgical_${name[i]}_Preop/T1_sag"
    # # file_1=("c1tb_${sub[i]}_${presurgical[i]}_${name[i]}_${date[i]}_001_${num[i]}_t1_mprage_sag_p2_1iso_MGH.nii")
    # # cp ${wdr_ileana}/${file_1} ${wdr_new}/${file_1}
    # # echo "Copied ${file_1} to ${wdr_new}"
    
    # files_to_copy=("c1tb_${sub[i]}_${presurgical[i]}_${name[i]}_${date[i]}_001_${num[i]}_t1_mprage_sag_p2_1iso_MGH.nii" "c2tb_${sub[i]}_${presurgical[i]}_${name[i]}_${date[i]}_001_${num[i]}_t1_mprage_sag_p2_1iso_MGH.nii" "c3tb_${sub[i]}_${presurgical[i]}_${name[i]}_${date[i]}_001_${num[i]}_t1_mprage_sag_p2_1iso_MGH.nii" "tb_${sub[i]}_${presurgical[i]}_${name[i]}_${date[i]}_001_${num[i]}_t1_mprage_sag_p2_1iso_MGH.nii" "rbin_${tumor[i]}_Tumor.nii")
    # for file in "${files_to_copy[@]}"; do
    #     cp "${wdr_ileana}/${file}" "${wdr_new}"
    #     echo "Copied ${file}" to ${wdr_new} 
    # done    
    
    # echo "Compute anatomical brain mask as the sum of the tissue segmentations previously computed in SPM"
    # 3dcalc -a ${wdr_new}/c1tb_${sub[i]}_${presurgical[i]}_${name[i]}_${date[i]}_001_${num[i]}_t1_mprage_sag_p2_1iso_MGH.nii -b ${wdr_new}/c2tb_${sub[i]}_${presurgical[i]}_${name[i]}_${date[i]}_001_${num[i]}_t1_mprage_sag_p2_1iso_MGH.nii \
    #     -c ${wdr_new}/c3tb_${sub[i]}_${presurgical[i]}_${name[i]}_${date[i]}_001_${num[i]}_t1_mprage_sag_p2_1iso_MGH.nii -expr 'step(a+b+c)' -prefix ${wdr_new}/tb_${sub[i]}_brain_mask.nii -overwrite \

    # echo "Refine anatomical brain mask with 3dmask_tool"
    # 3dmask_tool -input ${wdr_new}/tb_${sub[i]}_brain_mask.nii -dilate_inputs -1 +1 -fill_holes -prefix  ${wdr_new}/tb_${sub[i]}_brain_mask.nii -overwrite

    echo "Compute anatomical brain mask without the tumor"
    3dcalc -a ${wdr_new}/tb_${sub[i]}_brain_mask.nii -b ${wdr_new}/rbin_${tumor}_Tumor.nii -expr 'a*(a-b)' -prefix ${wdr_new}/rbin_s4_nontumor_mask.nii

done

# #There are file that are not saved correctly, folder names not match files names
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
#     #Create anat_preproc folder for working 
#     wdr_new="/bcbl/home/public/CVR/PRESURGICAL_BIDS/sub-${sub_2[i]}/ses-${ses_2[i]}/anat_preproc"
#         if [[ ! -d "${wdr_new}" ]]; then
#             echo "Creating folder ${wdr_new}"
#             mkdir -p "${wdr_new}"
#         fi

#     #Need to copy files to anatomical folder
#     wdr_ileana_2="/bcbl/home/public/Presurgical_Ileana/Morphometry/${sub_2[i]}_Presurgical_GLIOCOM_${name_2[i]}_Preop/T1_sag"
#     # file_1=("c1tb_${sub[i]}_${presurgical[i]}_${name[i]}_${date[i]}_001_${num[i]}_t1_mprage_sag_p2_1iso_MGH.nii")
#     # cp ${wdr_ileana}/${file_1} ${wdr_new}/${file_1}
#     # echo "Copied ${file_1} to ${wdr_new}"
    
#     files_to_copy=("c1tb_${sub_2[i]}_${presurgical_2[i]}_${name_2[i]}_${date_2[i]}_${num_1[i]}_${num_2[i]}_t1_mprage_sag_p2_1iso_MGH.nii" "c2tb_${sub_2[i]}_${presurgical_2[i]}_${name_2[i]}_${date_2[i]}_${num_1[i]}_${num_2[i]}_t1_mprage_sag_p2_1iso_MGH.nii" "c3tb_${sub_2[i]}_${presurgical_2[i]}_${name_2[i]}_${date_2[i]}_${num_1[i]}_${num_2[i]}_t1_mprage_sag_p2_1iso_MGH.nii" "tb_${sub_2[i]}_${presurgical_2[i]}_${name_2[i]}_${date_2[i]}_${num_1[i]}_${num_2[i]}_t1_mprage_sag_p2_1iso_MGH.nii" "${tumor_2[i]}_Tumor.nii")
#     for file in "${files_to_copy[@]}"; do
#         cp "${wdr_ileana_2}/${file}" "${wdr_new}"
#         echo "Copied ${file}" to ${wdr_new} 
#     done    
# done


# #Three subjects that have 47 amd 047
# sub_3=(047 049 053)
# ses_3=(1 1 1)
# presurgical_3=(PRESURGICAL presurgical presurgical)
# name_3=(EJCR MHB Epiconn_OADM)
# date_3=(20211013 20220126 20220718 20221115)
# num_3=(025 025 006)
# tumor_2=(s4 s4 s6 s6)

# for i in $(seq 0 3); 
# do  
#     #Create anat_preproc folder for working 
#     wdr_new="/bcbl/home/public/CVR/PRESURGICAL_BIDS/sub-${sub_2[i]}/ses-${ses_2[i]}/anat_preproc"
#         if [[ ! -d "${wdr_new}" ]]; then
#             echo "Creating folder ${wdr_new}"
#             mkdir -p "${wdr_new}"
#         fi

#     #Need to copy files to anatomical folder
#     wdr_ileana_2="/bcbl/home/public/Presurgical_Ileana/Morphometry/${sub_2[i]}_Presurgical_GLIOCOM_${name_2[i]}_Preop/T1_sag"
#     # file_1=("c1tb_${sub[i]}_${presurgical[i]}_${name[i]}_${date[i]}_001_${num[i]}_t1_mprage_sag_p2_1iso_MGH.nii")
#     # cp ${wdr_ileana}/${file_1} ${wdr_new}/${file_1}
#     # echo "Copied ${file_1} to ${wdr_new}"
    
#     files_to_copy=("c1tb_${sub_2[i]}_${presurgical_2[i]}_${name_2[i]}_${date_2[i]}_001_${num_2[i]}_t1_mprage_sag_p2_1iso_MGH.nii" "c2tb_${sub_2[i]}_${presurgical_2[i]}_${name_2[i]}_${date_2[i]}_001_${num_2[i]}_t1_mprage_sag_p2_1iso_MGH.nii" "c3tb_${sub_2[i]}_${presurgical_2[i]}_${name_2[i]}_${date_2[i]}_${num_1[i]}_${num_2[i]}_t1_mprage_sag_p2_1iso_MGH.nii" "tb_${sub_2[i]}_${presurgical_2[i]}_${name_2[i]}_${date_2[i]}_${num_1[i]}_${num_2[i]}_t1_mprage_sag_p2_1iso_MGH.nii" "${tumor_2[i]}_Tumor.nii")
#     for file in "${files_to_copy[@]}"; do
#         cp "${wdr_ileana_2}/${file}" "${wdr_new}"
#         echo "Copied ${file}" to ${wdr_new} 
#     done    
# done

# # # Create mask with non tumoural area 
# for i in $(seq 0 17)
# do

#     wdr_new=${PRJDIR}/sub-${sub}/ses-${ses}/anat_preproc
#     if [[ ! -d "${wdr_new}" ]]; then
#         echo "Creating folder ${wdr_new}"
#         mkdir -p "${wdr_new}"  
#     fi

#     wdr_ileana="/bcbl/home/public/Presurgical_Ileana/Morphometry/${sub[i]}_Presurgical_${name[i]}_Preop/T1_sag"
    
#     cp ${wdr_ileana}/c1tb_${sub[i]}_${presurgical[i]}_${name[i]}_${date[i]}_001_${num[i]}_t1_mprage_sag_p2_1iso_MGH.nii 
#     3dcalc -a ${wdr}/c1tb_${sub[i]}_${presurgical[i]}_${name[i]}_${date[i]}_001_${num[i]}_t1_mprage_sag_p2_1iso_MGH.nii -b ${wdr}/c2tb_${sub[i]}_${presurgical[i]}_${name[i]}_${date[i]}_001_${num[i]}_t1_mprage_sag_p2_1iso_MGH.nii \
#         -c ${wdr}/c3tb_${sub[i]}_${presurgical[i]}_${name[i]}_${date[i]}_001_${num[i]}__t1_mprage_sag_p2_1iso_MGH.nii -expr 'step(a+b+c)' prefix ${wdr}/tb_${sub[i]}_brain_mask.nii \
# done


