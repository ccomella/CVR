#!bin/bash

##First: select the path of interest 

##Presurgical Proyect 
#PRJDIR="/bcbl/home/public/CVR/PRESURGICAL_BIDS"
##Solo en el paciente 067
#PRJDIR="/bcbl/home/public/CVR/PRESURGICAL_BIDS/PRESURGICAL"

##BIPLAS Proyect 
#PRJDIR="/bcbl/home/public/CVR/BIPLAS_BIDS"


##LANGCONN Proyect 
PRJDIR="/bcbl/home/public/CVR/LANGCONN_BIDS"



# module load freesurfer/7.2.0
# module load afni/latest
# module load python/python3.6

##Script Directories 
SCRIPTS_DIR=/bcbl/home/public/CVR/Scripts/fmri
SCRIPTS_PREPROC_DIR="${SCRIPTS_DIR}/fmri_preproc"
SCRIPTS_ANALYSIS_DIR="${SCRIPTS_DIR}/fmri_analysis"

## Acquisition Parameters
TEs="10.6 28.69 46.78 64.87"
nTE=4

## Preprocessing Parameters
vdsc=10 # volumes to cut to achieve steady state magnetization
std=MNI152_2009_template.nii.gz # Template for normalization
mmres=2.4 # final spatial resolution in template space
fwhm=2 # full-width half maximum spatial smoothing
polort=5 # order of legendre polynomials for detrending

siot=none  # If != none, perform slice timing correction
# slice order file (full path to)
# siot=${wdr}/sliceorder.txt

dspk=none # If != none, perform despiking

step=1 # step = 1 will perform up to TEDANA (ME-ICA classification), step = 2 will use manual classication and perform or the rest of preprocessing

# BIDS parameters
task=BH # name of task for BIDS purposes


set -e  

## PRESURGICAL SUBJECTS
# #Subjects in first run 
# sub=(01 046 048 050 051 052 054 055 056 057 058 47 49 53)
# SES_ANAT=(2 1 1 1 1 1 1 1 1 1 1 1 1 1)
# SES_FUNC=(1 1 2 1 1 1 1 2 1 1 1 1 1 2)
# run=1

#Subjects in second run 
# sub=(060 061 062 063 064)
# SES_ANAT=(1 1 1 1 1)
# SES_FUNC=(1 1 1 1 1)
# run=1

##Subject individual runs
# sub=067
# SES_ANAT=1
# SES_FUNC=1
# run=1


## BIPLAS SUBJECTS
# sub=(10027 10487 10499 10501 10506 10512 10517 10522 10523 10566 10573 10609 10610 10613 PRO6560 PRO7939 PRO8592 PRO9535 PRO9838 PRO10046 PRO10124)
# SES_ANAT=(1 2 1 1 1 4 1 2 1 1 1 3 2 1 2 2 2 1 1 1 2)
# SES_FUNC=(2 1 2 1 1 1 2 1 1 2 2 1 1 2 1 1 1 2 1 2 1)
# run=1

# sub=(8838)
# SES_ANAT=(1)
# SES_FUNC=(1)


##LANGCONN SUBJECTS

#BAD
#sub=(238 496 3037 3145 3898 5820 7721 9913 10061 10200 10324 10392)

#WARNING OR BLANK
#sub=(522 600 3774 4436 4800 5274 5487 6365 6521 6729 8420 8808 8812 8978 8994 9047 9330 9337 9406 9494 9783 9931 9944 9973 10083 10100 10101 10453)

#Good

#Part1: 21 subjets
sub=(449 522 1092 2037 2762 2787 3061 3122 3181 3349 3437 3893 4209 4281 4898 5083 5127 5325 5742 5973)
SES_ANAT=(1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1)
SES_FUNC=(1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1)
run=1

# sub=(312)
# SES_ANAT=(2)
# SES_FUNC=(2)
# run=1

# #Part 2:20 subjects
# sub=(6084 6226 6483 6509 7033 7540 7591 7636 8239 8252 8516 8592 8727 9055 9322 9351 9378 9474 9491 9679)
# SES_ANAT=(1 1 1 1 1 1 1 1 1 1 1 1 1 1 2 1 1 1 1 1 1 1 1 1 1)
# SES_FUNC=(1 1 1 1 1 1 1 1 1 1 1 1 1 1 2 1 1 1 1 1 1 1 1 1 1)
# run=1

# #Part 3:20 subjects
# sub=(9696 9796 9883 9912 9969 9993 10007 10103 10246 10393 10397 10399 10413 10449 10473 10485 IRENE LUCIA VICENTE)
# SES_ANAT=(1 1 1 1 1 2 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1)
# SES_FUNC=(1 1 1 1 1 2 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1)
# run=1

for i in $(seq 0 19)
  do
    for run in 1
      do
            adir="${PRJDIR}/sub-${sub[$i]}/ses-${SES_ANAT[$i]}/anat"   
            anat="sub-${sub[$i]}_ses-${SES_ANAT[$i]}_run-${run} _T1w.nii.gz"
            unidir="${PRJDIR}/sub-${sub[$i]}/ses-${SES_ANAT[$i]}/anat"
            aseg="sub-${sub[$i]}_ses-${SES_ANAT[$i]}_run-${run} _T1w.nii.gz"
            fdir="${PRJDIR}/sub-${sub[$i]}/ses-${SES_FUNC[$i]}/func_preproc"
             
            if [[ -e "${PRJDIR}/logs/Output_step1_sub-${sub[$i]}_ses-${SES_FUNC[$i]}_run-${run}_task-${task}.txt" ]]; then
            rm ${PRJDIR}/logs/Output_step1_sub-${sub[$i]}_ses-${SES_FUNC[$i]}_run-${run}_task-${task}.txt
            fi

            qsub -q short.q -N "sub-${sub[$i]}" \
                -o ${PRJDIR}/logs/Output_step1_sub-${sub[$i]}_ses-${SES_FUNC[$i]}_run-${run}_task-${task}.txt \
                -e ${PRJDIR}/logs/Output_step1_sub-${sub[$i]}_ses-${SES_FUNC[$i]}_run-${run}_task-${task}.txt \
                ${SCRIPTS_PREPROC_DIR}/full_preproc.sh ${sub[$i]} ${SES_FUNC[$i]} ${run} ${PRJDIR} ${task} \
                "${adir}"/"${anat}" "${uni_adir}"/"${aseg}" \
                "${fdir}" "${vdsc}" "${TEs}" "${nTE}" \
                "${siot}" "${dspk}" \
                "${SCRIPTS_PREPROC_DIR}" "${step}" \
                "${fwhm}" "${polort}" "${std}" "${mmres}"
    
    done
done


    


#Analysis of phys2cvr

# ses=(2 1 1 1 1 1)
# for model in mpr aggr mode cons
# do 
#   for i in $(seq 0 6)
#   do
#       #Indicate the Fun_preproc directory
#       wdr=${PRJDIR}/sub-${sub[$i]}/ses-${ses[i]}/func_preproc
#       #echo $wdr 


#     # phys2cvr calculates the signal percentage change internally. So no need to do it before.
#     #Indicate the bold signal and mask 
#     #func_in=$6
#     func_in="sub-${sub[$i]}_ses-${ses[i]}_task-${task}_run-${run}_optcom_bold_sm"
#     #echo $func_in

#     #fmask=${7}
#     fmask="sub-${sub[$i]}_ses-${ses[i]}_task-${task}_optcom_mask"
#     #echo $fmask


#     #CO2 file that is in the Peakdet folder 
#     #co2file=$8
#     co2file="/bcbl/home/public/CVR/PRESURGICAL_BIDS/Peakdet/sub-${sub[$i]}_task-breathhold_recording-125Hz_physio_peak_ch-co2.phys"
#     #echo $co2file


#     #MEICA folder where manual classification is stored
#     MEICA=${PRJDIR}/sub-${sub[$i]}/ses-${ses[i]}/tmp/task-${task}/sub-${sub[$i]}_ses-${ses[$i]}_task-${task}_run-${run}_meica
#     #echo $MEICA

#     #demat matrices initial: deman and derivatives 
#     demat="sub-${sub[$i]}_ses-${ses[i]}_task-${task}_run-${run}_echo-1_bold_cr_mcf"
#     #echo $demat


#     qsub -q long.q -N "sub-${sub[$i]}" \
#                  -o /bcbl/home/public/CVR/PRESURGICAL_BIDS/sub-${sub[$i]}/Output_sub-${sub[$i]}_ses-${ses}_run-${run}_task-${task}_model-${model}.txt \
#                   -e /bcbl/home/public/CVR/PRESURGICAL_BIDS/sub-${sub[$i]}/Output_sub-${sub[$i]}_ses-${ses}_run-${run}_task-${task}_model-${model}.txt\
#                 ${SCRIPTS_ANALYSIS_DIR}/analysis_phys2cvr.sh ${sub[$i]} ${ses[$i]} ${run} ${wdr} ${task} ${model} \
#                 "${func_in}" "${fmask}" "${co2file}" "${MEICA}" "${demat}"
#   done
# done

# model=cons

# for i in $(seq 0 6)
#   do
#     #Indicate the Fun_preproc directory
#     wdr=${PRJDIR}/sub-${sub[$i]}/ses-${ses[i]}/func_preproc
#     #echo $wdr 


#     # phys2cvr calculates the signal percentage change internally. So no need to do it before.
#     #Indicate the bold signal and mask 
#     #func_in=$6
#     func_in="sub-${sub[$i]}_ses-${ses[i]}_task-${task}_run-${run}_optcom_bold_sm"
#     #echo $func_in

#     #fmask=${7}
#     fmask="sub-${sub[$i]}_ses-${ses[i]}_task-${task}_optcom_mask"
#     #echo $fmask


#     #CO2 file that is in the Peakdet folder 
#     #co2file=$8
#     co2file="/bcbl/home/public/CVR/PRESURGICAL_BIDS/Peakdet/sub-${sub[$i]}_task-breathhold_recording-125Hz_physio_peak_ch-co2.phys"
#     #echo $co2file


#     #MEICA folder where manual classification is stored
#     MEICA=${PRJDIR}/sub-${sub[$i]}/ses-${ses[i]}/tmp/task-${task}/sub-${sub[$i]}_ses-${ses[$i]}_task-${task}_run-${run}_meica
#     #echo $MEICA

#     #demat matrices initial: deman and derivatives 
#     demat="sub-${sub[$i]}_ses-${ses[i]}_task-${task}_run-${run}_echo-1_bold_cr_mcf"
#     #echo $demat


#     qsub -q long.q -N "sub-${sub[$i]}" \
#                  -o /bcbl/home/public/CVR/PRESURGICAL_BIDS/sub-${sub[$i]}/Output_sub-${sub[$i]}_ses-${ses}_run-${run}_task-${task}_model-${model}.txt \
#                   -e /bcbl/home/public/CVR/PRESURGICAL_BIDS/sub-${sub[$i]}/Output_sub-${sub[$i]}_ses-${ses}_run-${run}_task-${task}_model-${model}.txt\
#                 ${SCRIPTS_ANALYSIS_DIR}/analysis_phys2cvr.sh ${sub[$i]} ${ses[$i]} ${run} ${wdr} ${task} ${model} \
#                 "${func_in}" "${fmask}" "${co2file}" "${MEICA}" "${demat}"
#   done
# done