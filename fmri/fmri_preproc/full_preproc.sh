#!/usr/bin/env bash
#$ -cwd
#$ -o out.txt
#$ -e err.txt
#$ -m be
#$ -M c.comella@bcbl.eu
#$ -N TA
#$ -S /bin/bash
#$ -q long.q

######### Preprocessing of CVR
# Author:  Cristina Comella
# Version: 1.0
# Date:    10.03.2023
#########

module load python/venv
source activate /bcbl/home/public/CVR/py_3.9
module load afni/latest
module load freesurfer/7.2.0

sub=$1
ses=$2
run=$3
wdr=$4
task=$5

flpr=sub-${sub}_ses-${ses}

anat=${6:-none}
aseg=${7:-none}

fdir=$8

if [ ! -d "${fdir}" ]; then
	echo "Creating ${fdir}"
	mkdir -p "${fdir}"
fi

vdsc=$9

TEs=${10}
nTE=${11}

siot=${12} # DO SLICE TIMING CORRECTION?  

dspk=${13} # DO DESPIKING

scriptdir=${14}
echo "This is the scripts folder: ${scriptdir}" 
# scriptdir=${wdr}/scripts
# scriptdir=${scripts}

tmp=${wdr}/sub-${sub}/ses-${ses}/tmp/task-${task}

step=${15:-1}
fwhm=${16:-0}
polort=${17:-0}

anat_mni=${18:-false}
vox_res=${19:-none}

# This is the absolute sbref. Don't change it.
fdir_no_preproc=${wdr}/sub-${sub}/ses-${ses}/func
# sbrf=${wdr}/sub-${sub}/ses-${ses}/reg/sub-${sub}_sbref
sbrf=${fdir_no_preproc}/${flpr}_task-${task}_run-${run}_echo-1_sbref
mask=${sbrf}_brain_mask

# fmap=${wdr}/sub-${sub}/ses-${ses}/fmap_preproc
# bfor=${fmap}/${flpr}_acq-breathhold_dir-PA_epi
# brev=${fmap}/${flpr}_acq-breathhold_dir-AP_epi


### print input
printline=$( basename -- "$0" )
echo "${printline} " "$@"
######################################
#########    Task preproc    #########
######################################

#Start making the tmp folder
mkdir -p "${tmp}"

set -e

# If step is 1, then do until tedana (included)
if [ "${step}" -eq 1 ]; then

	for e in $( seq 1 "${nTE}" )
	do
		echo "************************************"
		echo "*** Copy ${task} BOLD echo ${e} ****"
		echo "************************************"
		echo "************************************"

		echo "${flpr}_task-${task}_run-${run}_echo-${e}_bold"
		bold=${flpr}_task-${task}_run-${run}_echo-${e}_bold

		echo "Copy raw dataset ${bold}.nii.gz  to ${tmp}"
		echo "3dcalc -a ${wdr}/sub-${sub}/ses-${ses}/func/${bold}.nii.gz -expr 'a' -prefix ${tmp}/${bold}.nii.gz -overwrite"
		3dcalc -a "${wdr}"/sub-"${sub}"/ses-"${ses}"/func/"${bold}".nii.gz -expr 'a' -prefix "${tmp}"/"${bold}".nii.gz -overwrite

		if [ ! -e "${tmp}"/"${bold}".nii.gz ]
		then
			echo "Something went wrong with the copy"
			# exit
		else
			echo "File copied, start preprocessing"
		fi

		echo "************************************"
		echo "*** Func correct ${task} BOLD echo ${e}"
		echo "************************************"
		echo "************************************"

		sh "${scriptdir}"/02.func_preproc/01.func_correct.sh "${bold}" "${fdir}" "${vdsc}" "${dspk}" "${siot}" "${tmp}" "${sbrf}" "${e}"

	done

	echo "************************************"
	echo "*** Func spacecomp ${task} echo 1 **"
	echo "************************************"
	echo "************************************"

	echo "fmat=${flpr}_task-${task}_run-${run}_echo-1_bold_cr"
	fmat=${flpr}_task-${task}_run-${run}_echo-1_bold_cr

	# #sh "${scriptdir}"/02.func_preproc/03.func_generate_mask.sh "${fdir}" "${sbrf}" # SBRF of first echo only
	sh "${scriptdir}"/02.func_preproc/04.motion_realign.sh "${fmat}.nii.gz" "${fdir}" "${sbrf}" "${tmp}" "yes" "${nTE}" # With first echo

	echo "************************************"
	echo "************ Tedana ${task} ********"
	echo "************************************"
	echo "************************************"
	sh "${scriptdir}"/02.func_preproc/10.func_meica.sh "sub-${sub}_ses-${ses}_task-${task}_run-${run}_echo-1_bold_cr_mcf.nii.gz" "${fdir}" "${TEs}" "${tmp}" "${step}"


elif [ "${step}" -eq 2 ]; then

	# echo "************************************"
	# echo "************ Tedana ${task} ********"
	# echo "************************************"
	# echo "fmat=${flpr}_task-${task}_run-${run}_echo-1_bold"
	# fmat=${flpr}_task-${task}_run-${run}_echo-1_bold
	# sh "${scriptdir}"/02.func_preproc/10.func_meica.sh "${fmat}_mcf_al.nii.gz" "${fdir}" "${TEs}" "${tmp}" "${step}"

	# echo "***********************************************************"
	# echo "*** Compute warping for geometric distortion correction ***"
	# echo "***********************************************************"
	# echo "***********************************************************"
	# sh "${scriptdir}"/02.func_preproc/02.func_blip_updown.sh "${brev}" "${bfor}" "${fdir}"

	# for e in $( seq 1 "${nTE}" )
	# do
	# 	echo "***********************************************************"
	# 	echo "*** Apply warping for geometric distortion correction ***"
	# 	echo "***********************************************************"
	# 	# echo "**** First, on BOLD data ${bold} ****" # We don't apply geometric distortion correction on BOLD data. It'll be applied in a single spatial transformation 
	# 	# sh "${scriptdir}"/02.func_preproc/02b.func_apply_blip_updown.sh "${tmp}/${bold}_cr" "${tmp}/${bold}_blip" "${bfor}"+orig "${fdir}"	
	# 	sbrf_echo=${fdir_no_preproc}/${flpr}_task-breathhold_rec-magnitude_echo-${e}_sbref
	# 	echo "**** On the corresponding SBRef ${sbrf_echo} ****"
	# 	sh "${scriptdir}"/02.func_preproc/02b.func_apply_blip_updown.sh "${sbrf_echo}" "${sbrf_echo}_blip" "${fmap}"/"${flpr}"_acq-breathhold_dir-PA_epi+orig "${fdir}"
	# done

	# echo "***************************************************"
	# echo "** Coregistration of ${anat} to ${sbrf##*/}_blip **"
	# echo "***************************************************"
	# echo "***************************************************"
	# sh "${scriptdir}"/02.func_preproc/05.func_alignto_anat.sh "${fdir}" "${anat}" "${sbrf##*/}_blip" "${tmp}"

	# # Align T1 to T2
	# # Extract everything except the last slash from anat
	# echo "**************************************"
	# echo "** Coregistration of ${anat} to T1w **"
	# echo "**************************************"
	# echo "**************************************"
	# adir=${anat%/*}
	# echo "anat_no_slash=${adir}"
	# sh "${scriptdir}"/02.func_preproc/06.align_T1toT2.sh "${adir}" "${anat##*/}" "${aseg}"

	# nada de estolo necesito para phys2cvr
	# for e in optcom # $( seq 1 "${nTE}" )
	# do
	# 	echo "************************************"
	# 	echo "*** Applying transformations *******"
	# 	echo "************************************"
	# 	echo "************************************"
    #     if [ "${e}" == "optcom" ]; then
	# 		echo "fmat=sub-${sub}_ses-${ses}_task-${task}_meica_manual/desc-optcomDenoised_bold.nii.gz"
	# 	    fmat=sub-${sub}_ses-${ses}_task-${task}_meica_manual/desc-optcomDenoised_bold.nii.gz
    #     else
    #         echo "fmat=sub-${sub}_ses-${ses}_task-${task}_meica_manual/echo-${e}_desc-Denoised_bold.nii.gz"
	# 	    fmat=sub-${sub}_ses-${ses}_task-${task}_meica_manual/echo-${e}_desc-Denoised_bold.nii.gz
    #     fi 
    #     sh "${scriptdir}"/02.func_preproc/07.func_nwarp_apply_to_echos.sh "${fmat}" "${sub}" "${ses}" "${fdir}" \
    #         "${tmp}" "${anat_mni}" "${e}" "${task}" "${vox_res}" "${wdr}"
	# done

	# Copy tedana results to main folder
	echo "************************************"
	echo "*** Copying tedana results *********"
	echo "************************************"

	MEICA_Folder="${tmp}/${flpr}_task-${task}_run-${run}_meica"

	# echo "************************************"
	# echo "*** Creating ICA Classification regressors ****"
	# #DUDA: en cluster no me deja llamar a mi conda
	# tedana_regressors -ctab ${MEICA_Folder}/manual_classification.tsv -mix ${MEICA_Folder}/desc-ICA_mixing.tsv -prefix ${MEICA}/ICA_components

	# copy optimcally combined dataset (without denoising) from MEICA folder to fdir folder and rename
	
	bold=${flpr}_task-${task}_run-"${run}"_optcom_bold
	
	3dcopy -overwrite "${MEICA_Folder}/desc-optcomDenoised_bold.nii.gz" "${fdir}/${bold}.nii.gz"
	3dcopy -overwrite "${MEICA_Folder}/desc-optcomDenoised_bold.nii.gz" "${fdir}/${bold}.nii.gz"
	# copy brain masks to fdir folder and rename
	mask_rm=${flpr}_task-${task}_run-${run}_echo-1_bold_brain_mask 
	mask=${flpr}_task-${task}_optcom_mask
	echo "mask=${mask_rm}"
	3dcopy -overwrite "${tmp}/${mask_rm}.nii.gz" "${fdir}/${mask}.nii.gz"

	# generate ROI with eroded (1 voxel) of brain mask so that the estimation of the bulk shift does not consider edge-brain voxels
	echo "**********************************************"
	echo "*** Erosion of brain mask by 1 voxel *********"
	echo "**********************************************"
    if [ ! -e "${fdir}"/"${mask}_eroded".nii.gz ]
    then
        3dmask_tool -inputs ${fdir}/${mask}.nii.gz -prefix ${fdir}/${mask}_eroded.nii.gz -dilate_inputs -1 -overwrite
    fi

	bold_rm=${bold}
	echo "bold_rm=${bold_rm}"

	if [ "${fwhm}" -gt 0 ]; then
		echo "***************************************************"
		echo "*** Func smoothing ${task} BOLD ${e}"
		echo "***************************************************"
		echo "***************************************************"
		sh "${scriptdir}"/02.func_preproc/08b.func_smooth.sh "${bold_rm}" "${fdir}" "${fwhm}" "${mask}" "${tmp}" "${bold}"_sm
		bold_rm=${bold}_sm
		3dcopy -overwrite "${tmp}/${bold_rm}.nii.gz" "${fdir}/${bold_rm}.nii.gz"
	fi

	if [ "${polort}" -gt 0 ]; then
		echo "***************************************************"
		echo "*** Func detrending ${task} BOLD ${e}"
		echo "***************************************************"
		echo "***************************************************"
		sh "${scriptdir}"/02.func_preproc/08c.func_detrend.sh "${bold_rm}" "${fdir}" "${polort}" "${mask}" "${tmp}" "${bold}"_dt
		bold_dt=${bold}_dt
	fi

	echo "************************************" 
	echo "*** Func SPC ${task} BOLD ${e}"
	echo "************************************"
	echo "************************************"
	sh "${scriptdir}"/02.func_preproc/09.func_spc.sh "${bold_rm}" "${fdir}" "${mask}" "${tmp}" "${bold}"_spc

	# echo "*****************************************"
	# echo "*** Func grayplot ${task} BOLD echo ${e}"
	# echo "*****************************************"
	# echo "*****************************************"
	# sh "${scriptdir}"/02.func_preproc/12.func_grayplot.sh "${bold}"_SPC "${fdir}" "${anat%/*}" "${flpr}"_MNI_bucket "${tmp}"


fi