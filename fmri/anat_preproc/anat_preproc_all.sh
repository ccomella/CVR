#!/usr/bin/env bash
#$ -cwd
#$ -o out.txt
#$ -e err.txt
#$ -m be
#$ -M c.comella@bcbl.eu
#$ -N TA
#$ -S /bin/bash
#$ -q long.q

######### Anat preproc of all subjects
# Author:  Cristina Comella
# Version: 1.0
# Date:    07/08/2023
#########

module load afni/latest


PRJDIR="/bcbl/home/public/CVR/PRESURGICAL_BIDS"
#VARIABLES
#Patients
#Variables
# sub=(046 050 052 054 055 056 057 058 059 060 061 062 063 064 065 47 49 53)

# #Anatomical Sesion
# ses_anat=(1 1 1 1 1 1 1 1 2 1 1 1 1 1 1 1 1 1)
# ses_func=(1 1 1 1 2 1 1 1 2 1 1 1 1 1 1 1 1 2)

# #Variables in name of the file
# presurgical=(Presurgical Presurgical Presurgical Presurgical Presurgical Presurgical PRESURGICAL Presurgical Presurgical PRESURGICAL PRESURGICAL PRESURGICAL PRESURGICAL Presurgical PRESURGICAL PRESURGICAL Presurgical Presurgical)
# name=(GLIOCOM_KGH GLIOCOM_MCL IBM ARG JLS JH ETM DUP SIH IZG ISO TMR MGLM MLS HAS EJCR MHB Epiconn_OADM)
# date=(20210302 20210916 20211013 20220118 20220126 20220210 20220322 20220519 20220718 20221115 20230116 20230201 20230207 20230214 20230309 20210326 20210713 20211028)
# num_1=(001 001 001 001 001 001 001 001 002 001 001 001 001 001 001 001 001 001)
# num_2=(006 025 025 025 006 025 025 029 025 025 025 025 025 025 025 025 025 006)
# tumor=(s4 s4 s4 s4 s4 s4 s4 s6 s6 s6 s6 s4 s4 s6 s4 s2 s s4)

sub=(056)
#Anatomical Sesion
ses_anat=(1)
ses_func=(1)

presurgical=(Presurgical)
name=(JH)
date=(20220210)
num_1=(001)
num_2=(025)
tumor=(s4)
# # Create masks


for i in 0 #$(seq 0 1);  #$(seq 0 17);
do
    # Work directory Anat Preproc
     wdr=${PRJDIR}/sub-${sub[i]}/ses-${ses_anat[i]}/anat_preproc
     cd ${wdr}

    # # First mask: GM Mask (c1)
    echo "**********************************************************************************************" 
    echo "Rename GM Mask (c1) previously in SPM"
    echo "**********************************************************************************************"
    3dcopy c1tb_${sub[i]}_${presurgical[i]}_${name[i]}_${date[i]}_${num_1[i]}_${num_2[i]}_t1_mprage_sag_p2_1iso_MGH.nii tb_${sub[i]}_GM_mask.nii -overwrite

    # # Second mask: WM Mask (c2)
    echo "**********************************************************************************************"
    echo "Rename WM Mask (c2) previously in SPM"
    echo "**********************************************************************************************"
    3dcopy c2tb_${sub[i]}_${presurgical[i]}_${name[i]}_${date[i]}_${num_1[i]}_${num_2[i]}_t1_mprage_sag_p2_1iso_MGH.nii tb_${sub[i]}_WM_mask.nii -overwrite

    # DUDA: se hace antes o despues 
    # # Third mask: GM - Tumor Mask 
    3dcalc -a tb_${sub[i]}_GM_mask.nii -b rbin_${tumor[i]}_Tumor.nii -expr 'a*(a-b)' -prefix tb_${sub[i]}_GM_nontumor_mask.nii -overwrite
    
    
    
    # #  # Fourth Mask: Complete Brain mask, adding three files 
    # echo "**********************************************************************************************"
    # echo "Compute anatomical brain mask as the sum of the tissue segmentations previously computed in SPM"
    # echo "**********************************************************************************************"
    # 3dcalc -a c1tb_${sub[i]}_${presurgical[i]}_${name[i]}_${date[i]}_${num_1[i]}_${num_2[i]}_t1_mprage_sag_p2_1iso_MGH.nii -b c2tb_${sub[i]}_${presurgical[i]}_${name[i]}_${date[i]}_${num_1[i]}_${num_2[i]}_t1_mprage_sag_p2_1iso_MGH.nii \
    #     -c c3tb_${sub[i]}_${presurgical[i]}_${name[i]}_${date[i]}_${num_1[i]}_${num_2[i]}_t1_mprage_sag_p2_1iso_MGH.nii -expr 'step(a+b+c)' -prefix tb_${sub[i]}_brain_mask.nii -overwrite

    # echo "***********************************************"
    # echo "Refine anatomical brain mask with 3dmask_tool"
    # echo "***********************************************"
    # 3dmask_tool -input tb_${sub[i]}_brain_mask.nii -dilate_inputs -1 +1 -fill_holes -prefix tb_${sub[i]}_brain_mask.nii -overwrite

    # # # Fifth Mask: Brain mask without the tumor
    # echo "************************************************"
    # echo "Compute anatomical brain mask without the tumor"
    # echo "************************************************"
    # 3dcalc -a tb_${sub[i]}_brain_mask.nii -b rbin_${tumor[i]}_Tumor.nii -expr 'a*(a-b)' -prefix rbin_${tumor[i]}_nontumor_mask.nii -overwrite

    # # # Sixth Mask: Tumor mask TO Obtain peritumoral area
    echo "************************************************"
    echo "Compute anatomical brain mask of the tumor"
    echo "************************************************"
    3dcalc -a tb_${sub[i]}_brain_mask.nii -b rbin_${tumor[i]}_Tumor.nii -expr 'b' -prefix rbin_${tumor[i]}_tumor_mask.nii -overwrite


    # # # Perform Skull Stripping of T1-w anatomical image
    # echo "************************************************"
    # echo "Perform skull stripping of T1-w anatomical image"
    # echo "************************************************"
    # 3dSkullStrip -input tb_${sub[i]}_${presurgical[i]}_${name[i]}_${date[i]}_${num_1[i]}_${num_2[i]}_t1_mprage_sag_p2_1iso_MGH.nii -prefix tb_${sub[i]}_T1w_ns.nii.gz -push_to_edge -overwrite

    # # # Apply  Sbref (reference vol) as mask to Optcom volume
    # echo "************************************************"
    # echo "Apply EPI mask to EPI SBref volume and anatomical"
    # echo "************************************************"
    # 3dcalc -a sub-${sub[i]}_ses-${ses_func[i]}_task-BH_run-1_echo-1_sbref.nii.gz -m sub-${sub[i]}_ses-${ses_func[i]}_task-BH_optcom_mask.nii.gz -expr "a*m" -prefix sbref_${sub[i]}_ns.nii.gz -overwrite

    # # Copy all nifti without nifti extension because align_epi_anat does not work with nifti extension
    echo "***********************************"
    echo "3D copy without nifti of ${sub[i]}"
    echo "************************************"
    3dcopy tb_${sub[i]}_T1w_ns.nii.gz tb_${sub[i]}_T1w_ns -overwrite
    3dcopy tb_${sub[i]}_GM_mask.nii tb_${sub[i]}_GM_mask -overwrite
    3dcopy tb_${sub[i]}_WM_mask.nii tb_${sub[i]}_WM_mask -overwrite

    #3dcopy rbin_${tumor[i]}_nontumor_mask.nii rbin_${tumor[i]}_nontumor_mask -overwrite
    # 3dcopy rbin_${tumor[i]}_tumor_mask2.nii rbin_${tumor[i]}_tumor_mask2 -overwrite 

    # #remember that the anatomical dataset for align_epi_anat must be in afni format (i.e. +orig), so you can save them directly with 3dcalc in this format
    
    echo "***************************"
    echo "Align_epi_anat of ${sub[i]}"
    echo "***************************"
    align_epi_anat.py -anat tb_${sub[i]}_T1w_ns+orig -epi sbref_${sub[i]}_ns.nii.gz -epi_base 0 \
        -anat2epi -suffix _al_epi -anat_has_skull no -cost lpa -giant_move -epi_strip None \
        -volreg off -tshift off -overwrite

    
    # # 3d Allineate of the 
    echo "***********************************************************************************"
    echo "3dAllineate of ${sub[i]} to apply spatial transformation to the nontumor brain mask"
    echo "***********************************************************************************"
    # apply this spatial transformation to the nontumor brain mask
    # 3dAllineate -base sbref_${sub[i]}_ns.nii.gz -1Dmatrix_apply tb_${sub[i]}_T1w_ns_al_epi_mat.aff12.1D -final NN -prefix rbin_${tumor[i]}_nontumor_mask_al_epi.nii rbin_${tumor[i]}_nontumor_mask.nii -overwrite
    #3dAllineate -base sbref_${sub[i]}_ns.nii.gz -1Dmatrix_apply tb_${sub[i]}_T1w_ns_al_epi_mat.aff12.1D -final NN -prefix rbin_${tumor[i]}_tumor_mask2_al_epi.nii rbin_${tumor[i]}_tumor_mask2.nii -overwrite
    3dAllineate -base sbref_${sub[i]}_ns.nii.gz -1Dmatrix_apply tb_${sub[i]}_T1w_ns_al_epi_mat.aff12.1D -final NN -prefix tb_${sub[i]}_GM_mask.nii tb_${sub[i]}_GM_mask.nii -overwrite
    3dAllineate -base sbref_${sub[i]}_ns.nii.gz -1Dmatrix_apply tb_${sub[i]}_T1w_ns_al_epi_mat.aff12.1D -final NN -prefix tb_${sub[i]}_WM_mask.nii tb_${sub[i]}_WM_mask.nii -overwrite
    3dAllineate -base sbref_${sub[i]}_ns.nii.gz -1Dmatrix_apply tb_${sub[i]}_T1w_ns_al_epi_mat.aff12.1D -final NN -prefix tb_${sub[i]}_GM_nontumor_mask.nii tb_${sub[i]}_GM_nontumor_mask.nii -overwrite
    
    # # Allineate with tumor mask 
    # 3dAllineate -base sbref_${sub[i]}_ns.nii.gz -1Dmatrix_apply tb_${sub[i]}_T1w_ns_al_epi_mat.aff12.1D -final NN -prefix rbin_${tumor[i]}_Tumor_al_epi.nii rbin_${tumor[i]}_Tumor.nii -overwrite

    # # multiply by the functional brain mask because the anatomical brain mask always has larger extent (e.g. in areas with signal dropout)
    # 3dcalc -a winv_wT_bin_${tumor[i]}_Tumor_GM_mask_al_epi.nii -expr 'step(a-0.5)' -prefix winv_wT_bin_${tumor[i]}_Tumor_GM_mask_al_epi.nii -overwrite

    # 3dcalc -a GM_mask_sub_${sub[i]}_c1tb_al_epi.nii -expr 'step(a-0.5)' -prefix GM_mask_sub_${sub[i]}_c1tb_al_epi.nii -overwrite

    
    echo "*************************************"
    echo "3dmasktool of ${sub[i]} to refine mask"
    echo "*************************************"
    # refine nontumor brain mask (but not use fill holes because it will close the tumor unless it is located in the borders of the brain)
    # 3dmask_tool -input rbin_${tumor[i]}_nontumor_mask_al_epi.nii -dilate_inputs +1 -1 -prefix rbin_${tumor[i]}_nontumor_mask_al_epi.nii -overwrite
    # 3dmask_tool -input rbin_${tumor[i]}_tumor_mask2_al_epi.nii -dilate_inputs +1 -1 -prefix rbin_${tumor[i]}_tumor_mask2_al_epi.nii -overwrite

    echo "*******************************************************************************************************"
    echo "3dcalc of ${sub[i]} to multiply the functional brain mask to the anatomical one as it has larger extent"
    echo "*******************************************************************************************************"
    # multiply by the functional brain mask because the anatomical brain mask always has larger extent (e.g. in areas with signal dropout)
    # 3dcalc -a rbin_${tumor[i]}_nontumor_mask_al_epi.nii -b sub-${sub[i]}_ses-${ses_func[i]}_task-BH_optcom_mask.nii.gz -expr 'a*b' -prefix rbin_${tumor[i]}_nontumor_mask_al_epi.nii -overwrite
    # 3dcalc -a rbin_${tumor[i]}_tumor_mask2_al_epi.nii -b sub-${sub[i]}_ses-${ses_func[i]}_task-BH_optcom_mask.nii.gz -expr 'a*b' -prefix rbin_${tumor[i]}_tumor_mask2_al_epi.nii -overwrite
    3dcalc -a tb_${sub[i]}_GM_mask.nii -b sub-${sub[i]}_ses-${ses_func[i]}_task-BH_optcom_mask.nii.gz -expr 'a*b' -prefix tb_${sub[i]}_GM_mask.nii -overwrite
    3dcalc -a tb_${sub[i]}_GM_mask.nii -b sub-${sub[i]}_ses-${ses_func[i]}_task-BH_optcom_mask.nii.gz -expr 'a*b' -prefix tb_${sub[i]}_WM_mask.nii -overwrite
    3dcalc -a tb_${sub[i]}_GM_mask.nii -b sub-${sub[i]}_ses-${ses_func[i]}_task-BH_optcom_mask.nii.gz -expr 'a*b' -prefix tb_${sub[i]}_GM_nontumor_mask.nii -overwrite
done