#$ -q long.q

######### Anat preproc of sub-067
# Author:  Cristina Comella
# Version: 1.0
# Date:    04/10/2023
#########

module load afni/latest


PRJDIR="/bcbl/home/public/CVR/PRESURGICAL_BIDS/PRESURGICAL"


sub=(067)
#Anatomical Sesion
ses_anat=(1)
ses_func=(1)

presurgical=(Presurgical)
name=(SLD)
date=(20230928)
num_1=(001)
num_2=(028)
tumor=(s6)

for i in 0
do
    wdr=${PRJDIR}/sub-${sub[i]}/ses-${ses_anat[i]}/anat_preproc

    cd ${wdr}
    # #First Step: Obtain the tumor contralateral mask in GM
    # echo "*********Resample**************"
    # 3dresample -rmode NN -master c1tb_${sub[i]}_${presurgical[i]}_${name[i]}_${date[i]}_${num_1[i]}_${num_2[i]}_t1_mprage_sag_p2_1iso_MGH.nii -prefix winv_wT_bin_${tumor[i]}_Tumor_flip_roi_resample.nii -input winv_wT_bin_${tumor}_Tumor_flip_roi.nii 
    
    # echo "************************************************"
    # echo "Compute anatomical brain mask without the tumor"
    # echo "************************************************"
    # #3dcalc -a c1tb_${sub[i]}_${presurgical[i]}_${name[i]}_${date[i]}_${num_1[i]}_${num_2[i]}_t1_mprage_sag_p2_1iso_MGH.nii -b winv_wT_bin_${tumor[i]}_Tumor_flip_roi.nii -expr 'a*b' -prefix rbin_${tumor[i]}_tumor_contralateral_GM_mask.nii -overwrite
    # 3dcalc -a c1tb_${sub[i]}_${presurgical[i]}_${name[i]}_${date[i]}_${num_1[i]}_${num_2[i]}_t1_mprage_sag_p2_1iso_MGH.nii -b winv_wT_bin_${tumor[i]}_Tumor_flip_roi_resample.nii -expr 'a*b' -prefix winv_wT_bin_${tumor[i]}_Tumor_GM_mask.nii -overwrite

    # #Perform Skull Stripping
    # echo "************************************************"
    # echo "Perform skull stripping of T1-w anatomical image"
    # echo "************************************************"

    #ESTO LO COMENTO PERO ES PORQUE QUIERO LA SKULLSTRIPPING DE MI T1
    # 3dSkullStrip -input tb_${sub[i]}_${presurgical[i]}_${name[i]}_${date[i]}_${num_1[i]}_${num_2[i]}_t1_mprage_sag_p2_1iso_MGH.nii -prefix tb_${sub[i]}_T1w_ns.nii.gz -push_to_edge -overwrite

    # echo "************************************************"
    # echo "Apply EPI mask to EPI SBref volume and anatomical"
    # echo "************************************************"
    # #Esto se hace para tener mi volumen de referencia
    # 3dcalc -a sub-${sub[i]}_ses-${ses_func[i]}_task-BH_run-1_echo-1_sbref.nii.gz -m sub-${sub[i]}_ses-${ses_func[i]}_task-BH_optcom_mask.nii.gz -expr "a*m" -prefix sbref_${sub[i]}_ns.nii.gz -overwrite
    
    
    # # echo "***********************************"
    # # echo "3D copy without nifti of ${sub[i]}"
    # # echo "************************************"
    # # 3dcopy tb_${sub[i]}_T1w_ns.nii.gz tb_${sub[i]}_T1w_ns -overwrite
    # 3dcopy winv_wT_bin_${tumor[i]}_Tumor_GM_mask.nii winv_wT_bin_${tumor[i]}_Tumor_GM_mask -overwrite
    # 3dcopy c1tb_${sub[i]}_${presurgical[i]}_${name[i]}_${date[i]}_${num_1[i]}_${num_2[i]}_t1_mprage_sag_p2_1iso_MGH.nii GM_mask_sub_${sub[i]}_c1tb.nii -overwrite

    # # # echo "***************************"
    # # # echo "Align_epi_anat of ${sub[i]}"
    # # # echo "***************************"
    # # # align_epi_anat.py -anat tb_${sub[i]}_T1w_ns+orig -epi sbref_${sub[i]}_ns.nii.gz -epi_base 0 \
    # # #     -anat2epi -suffix _al_epi -anat_has_skull no -cost lpa -giant_move -epi_strip None \
    # # #     -volreg off -tshift off -overwrite

    # echo "***********************************************************************************"
    # echo "3dAllineate of ${sub[i]} to apply spatial transformation to the nontumor brain mask"
    # echo "***********************************************************************************"
    # # apply this spatial transformation to the nontumor brain mask
    # 3dAllineate -base sbref_${sub[i]}_ns.nii.gz -1Dmatrix_apply tb_${sub[i]}_T1w_ns_al_epi_mat.aff12.1D -final NN -prefix winv_wT_bin_${tumor[i]}_Tumor_GM_mask_al_epi.nii winv_wT_bin_${tumor[i]}_Tumor_GM_mask.nii -final NN -overwrite
    3dAllineate -base sbref_${sub[i]}_ns.nii.gz -1Dmatrix_apply tb_${sub[i]}_T1w_ns_al_epi_mat.aff12.1D -final NN -prefix rbin_${tumor[i]}_Tumor_al_epi.nii rbin_${tumor[i]}_Tumor.nii -overwrite

    # 3dAllineate -base sbref_${sub[i]}_ns.nii.gz -1Dmatrix_apply tb_${sub[i]}_T1w_ns_al_epi_mat.aff12.1D -final NN -prefix GM_mask_sub_${sub[i]}_c1tb_al_epi.nii -input GM_mask_sub_${sub[i]}_c1tb.nii -overwrite

    # multiply by the functional brain mask because the anatomical brain mask always has larger extent (e.g. in areas with signal dropout)
    3dcalc -a winv_wT_bin_${tumor[i]}_Tumor_GM_mask_al_epi.nii -expr 'step(a-0.5)' -prefix winv_wT_bin_${tumor[i]}_Tumor_GM_mask_al_epi.nii -overwrite

    3dcalc -a GM_mask_sub_${sub[i]}_c1tb_al_epi.nii -expr 'step(a-0.5)' -prefix GM_mask_sub_${sub[i]}_c1tb_al_epi.nii -overwrite

    # echo "*******************************************************************************************************"
    # echo "3dcalc of ${sub[i]} to multiply the functional brain mask to the anatomical one as it has larger extent"
    # echo "*******************************************************************************************************"
    # # multiply by the functional brain mask because the anatomical brain mask always has larger extent (e.g. in areas with signal dropout)
    # 3dcalc -a rbin_${tumor[i]}_nontumor_mask_al_epi.nii -b sub-${sub[i]}_ses-${ses_func[i]}_task-BH_optcom_mask.nii.gz -expr 'a*b' -prefix rbin_${tumor[i]}_nontumor_mask_al_epi.nii -overwrite
    # # 3dcalc -a rbin_${tumor[i]}_tumor_mask2_al_epi.nii -b sub-${sub[i]}_ses-${ses_func[i]}_task-BH_optcom_mask.nii.gz -expr 'a*b' -prefix rbin_${tumor[i]}_tumor_mask2_al_epi.nii -overwrite

    #Sacar Peritumoral
    3dmask_tool -dilate_inputs 3 -prefix rbin_${tumor[i]}_Tumor_al_epi_dilated.nii -input rbin_${tumor[i]}_Tumor_al_epi.nii 

    3dcalc -a rbin_${tumor[i]}_Tumor_al_epi_dilated.nii -b rbin_${tumor[i]}_Tumor_al_epi.nii -m sbref_${sub[i]}_ns.nii.gz -expr '(a-b)*bool(m)' -prefix rbin_${tumor[i]}_Peritumor_al_epi.nii

    #ROIStats CODIGO CESAR
    3dROIstats -nomeanout -nobriklab -nzmean -nzmedian -mask rbin_${tumor[i]}_Tumor_al_epi.nii sub-${sub[i]}_ses-${ses_anat[i]}_task-BH_run-1_optcom_bold_sm_cvr_scaled.nii.gz 


done
