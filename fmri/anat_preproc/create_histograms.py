#!/usr/bin/env bash
#$ -cwd
#$ -o out.txt
#$ -e err.txt
#$ -m be
#$ -M c.comella@bcbl.eu
#$ -N TA
#$ -S /bin/bash
#$ -q long.q

######### CVR analysis with phys2cvr
# Author:  Cristina Comella
# Version: 1.0
# Date:    10.03.2023
#########

#Load in Cajal01 all the module necessary 
module load python/python3.6
module load afni/latest
module load freesurfer/7.2.0

# #Project Directory
PRJDIR="/bcbl/home/public/CVR/PRESURGICAL_BIDS"

#Project Directory
# PRJDIR="/bcbl/home/public/CVR/PRESURGICAL_BIDS/PRESURGICAL"

#First List of Presurgical
# sub=(046 050 052 054 055 056 057 058 47 49 53)
# ses=(1 1 1 1 2 1 1 1 1 1 2)

#Second List of the Presurgical 
# sub=(059 060 061 062 063 064)
# ses=(2 1 1 1 1 1)

#CVR_cons2 was because I did again the peakdet 

# sub=$1
# ses=$2
# run=$3
# wdr=$4
# task=$5
# #Choose the model of each case: mpr, aggr, mode or cons 
# model=${6:-cons}

#Indicate the list of subjects and session of interst
# sub=(01 046 048 050 051 052 054 055 056 057 058 47 49 53)
# ses=(1 1 2 1 1 1 1 2 1 1 1 1 1 2)

# sub=(059 060 061 062 063 064)
# ses=(2 1 1 1 1 1)
#sub=(01 046)
#ses=(1 1)
# sub=(050 052 054 055 056 057 058 47 53)
# ses=(1 1 1 1 1 2 1 1 1 1 2)
sub=(065)
ses=(1)
run=1
task=BH
model=cons




#INTENTANDO HACER EL QSUB CODIGO 

# #Indicate the Fun_preproc directory
# # wdr=${PRJDIR}/sub-${sub[$i]}/ses-${ses[i]}/func_preproc
# # echo $wdr 


# # phys2cvr calculates the signal percentage change internally. So no need to do it before.
# #Indicate the bold signal and mask 
# func_in=$7
# # func_in="sub-${sub[$i]}_ses-${ses[i]}_task-${task}_run-${run}_optcom_bold_sm"
# # echo $func_in

# fmask=${8}
# # fmask="sub-${sub[$i]}_ses-${ses[i]}_task-${task}_optcom_mask"
# #  echo $fmask


# #CO2 file that is in the Peakdet folder 
# co2file=$9
# # co2file="/bcbl/home/public/CVR/PRESURGICAL_BIDS/Peakdet/sub-${sub[$i]}_task-breathhold_recording-125Hz_physio_peak_ch-co2.phys"
# # echo $co2file


# #MEICA folder where manual classification is stored
# meica=${10}
# # MEICA=${PRJDIR}/sub-${sub[$i]}/ses-${ses[i]}/tmp/task-${task}/sub-${sub[$i]}_ses-${ses[$i]}_task-${task}_run-${run}_meica
# # echo $MEICA

# #demat matrices initial: deman and derivatives 
# demat=${11}

# # demat="sub-${sub[$i]}_ses-${ses[i]}_task-${task}_run-${run}_echo-1_bold_cr_mcf"
# # echo $demat

#  #Indicate all the variables needed for phys2cvr (will be ask outside the function)

#     #Legendre polynomial 
#     ldeg=4
#     #Lag considered
#     lm=9
#     #Lag step
#     ls=0.3
#     #scale factor for beta maps will be divided to create CVR maps 
#     scale=71.2

#  # optimally combined (motion + legendre) approach (mpr)
#     if [ "${model}" == "mpr" ]; then

#         echo "*********************************************"
#         echo "***Compute the optimally combined approach***"
#         echo "*********************************************"

#         echo "phys2cvr -i "${wdr}/${func_in}.nii.gz" -o "${wdr}/CVR_mpr" -r ${wdr}/${fmask}_eroded.nii.gz -m "${wdr}/${fmask}.nii.gz" -co2 ${co2file} -ldeg "${ldeg}" \
#          -dmat "${wdr}/${demat}_demean.1D" "${wdr}/${demat}_deriv1.1D" -scale "${scale}" -lm "${lm}" -ls "${ls}" --r2full"

#         phys2cvr -i "${wdr}/${func_in}.nii.gz" -o "${wdr}/CVR_mpr" -r ${wdr}/${fmask}_eroded.nii.gz -m "${wdr}/${fmask}.nii.gz" -co2 ${co2file} -ldeg ${ldeg}  \
#              -dmat "${wdr}/${demat}_demean.1D" "${wdr}/${demat}_deriv1.1D" -scale ${scale} -lm ${lm} -ls ${ls} --r2full
#     fi

    
# # agressive approach (aggr)
#     if [ "${model}" == "aggr" ]; then
    

#         echo "*********************************************"
#         echo "***Compute the aggresive approach***"
#         echo "*********************************************"
    
#         echo "phys2cvr -i "${wdr}/${func_in}.nii.gz" -o "${wdr}/CVR_aggr" -r ${wdr}/${fmask}_eroded.nii.gz -m "${wdr}/${fmask}.nii.gz" -co2 ${co2file} -ldeg "${ldeg}" \
#             -dmat "${wdr}/${demat}_demean.1D" "${wdr}/${demat}_deriv1.1D" "${MEICA}/ICA_components_rejected.1D"  \
#             -scale "${scale}" -lm "${lm}" -ls "${ls}" --r2full"

#         phys2cvr -i "${wdr}/${func_in}.nii.gz" -o "${wdr}/CVR_aggr" -r ${wdr}/${fmask}_eroded.nii.gz -m "${wdr}/${fmask}.nii.gz" -co2 ${co2file} -ldeg ${ldeg} \
#              -dmat "${wdr}/${demat}_demean.1D" "${wdr}/${demat}_deriv1.1D" "${MEICA}/ICA_components_rejected.1D"  \
#             -scale ${scale} -lm ${lm} -ls ${ls} --r2full
#     fi

    
# # moderate approach (mode)
#     if [ "${model}" == "mode" ]; then

#         echo "************************************"
#         echo "***Compute the modarate approach***"
#         echo "************************************"

#         echo " phys2cvr -i "${wdr}/${func_in}.nii.gz" -o "${wdr}/CVR_mode" -r ${wdr}/${fmask}_eroded.nii.gz -m "${wdr}/${fmask}.nii.gz" -co2 ${co2file} -ldeg "${ldeg}"  \
#             -dmat "${wdr}/${demat}_demean.1D" "${wdr}/${demat}_deriv1.1D" -omat "${MEICA}/ICA_components_rejected.1D"  \
#             -scale "${scale}" -lm "${lm}" -ls "${ls}" --r2full"

#         phys2cvr -i "${wdr}/${func_in}.nii.gz" -o "${wdr}/CVR_mode" -r ${wdr}/${fmask}_eroded.nii.gz -m "${wdr}/${fmask}.nii.gz" -co2 ${co2file} -ldeg ${ldeg} \
#             -dmat "${wdr}/${demat}_demean.1D" "${wdr}/${demat}_deriv1.1D" -omat "${MEICA}/ICA_components_rejected.1D"  \
#             -scale ${scale} -lm ${lm} -ls ${ls} --r2full

#     fi


# # conservative approach (cons)
#     if [ "${model}" == "cons" ]; then

# 		echo "************************************"
#         echo "***Compute the conservative approach*"
# 		echo "************************************"
        
#         echo " phys2cvr -i "${wdr}/${func_in}.nii.gz" -o "${wdr}/CVR_cons" -r ${wdr}/${fmask}_eroded.nii.gz -m "${wdr}/${fmask}.nii.gz" -co2 ${co2file} -ldeg "${ldeg}" \
#             -dmat "${wdr}/${demat}_demean.1D" "${wdr}/${demat}_deriv1.1D" -omat "${MEICA}/ICA_components_rejected.1D"  \
#             -emat "${MEICA}/ICA_components_accepted.1D" -scale "${scale}" -lm "${lm}" -ls "${ls}" --r2full"
    
#         phys2cvr -i "${wdr}/${func_in}.nii.gz" -o "${wdr}/CVR_cons" -r ${wdr}/${fmask}_eroded.nii.gz -m "${wdr}/${fmask}.nii.gz" -co2 ${co2file} -ldeg ${ldeg} \
#              -dmat "${wdr}/${demat}_demean.1D" "${wdr}/${demat}_deriv1.1D" -omat "${MEICA}/ICA_components_rejected.1D"  \
#              -emat "${MEICA}/ICA_components_accepted.1D" -scale ${scale} -lm ${lm} -ls ${ls} --r2full
#     fi


for i in 0 #$(seq 0 4)
do
 
    #Indicate the Fun_preproc directory
    wdr=${PRJDIR}/sub-${sub[$i]}/ses-${ses[$i]}/func_preproc
    echo $wdr 
    cd $wdr


    # phys2cvr calculates the signal percentage change internally. So no need to do it before.
    #Indicate the bold signal and mask 
    #func_in=$6
    func_in="sub-${sub[$i]}_ses-${ses[$i]}_task-${task}_run-${run}_optcom_bold_sm"
    echo $func_in

    #fmask=${7}
    fmask="sub-${sub[$i]}_ses-${ses[$i]}_task-${task}_optcom_mask"
    echo $fmask

    #CO2 file that is in the Peakdet folder 
    #co2file=$8
    co2file="/bcbl/home/public/CVR/PRESURGICAL_BIDS/Peakdet/sub-${sub[$i]}_task-breathhold_recording-125Hz_physio_peak_ch-co2.phys"
    echo $co2file


    #MEICA folder where manual classification is stored
    MEICA=${PRJDIR}/sub-${sub[$i]}/ses-${ses[$i]}/tmp/task-${task}/sub-${sub[$i]}_ses-${ses[$i]}_task-${task}_run-${run}_meica
    echo $MEICA

    #demat matrices initial: deman and derivatives 
    demat="sub-${sub[$i]}_ses-${ses[$i]}_task-${task}_run-${run}_echo-1_bold_cr_mcf"
    echo $demat

    #Indicate all the variables needed for phys2cvr (will be ask outside the function)

    #Legendre polynomial 
    ldeg=4
    #Lag considered
    lm=9
    #Lag step
    ls=0.3
    #scale factor for beta maps will be divided to create CVR maps 
    scale=71.2

#     # optimally combined (motion + legendre) approach (mpr)
#     if [ "${model}" == "mpr" ]; then

#         echo "*********************************************"
#         echo "***Compute the optimally combined approach***"
#         echo "*********************************************"

#         echo "phys2cvr -i "${wdr}/${func_in}.nii.gz" -o "${wdr}/CVR_mpr1" -r ${wdr}/${fmask}_eroded.nii.gz -m "${wdr}/${fmask}.nii.gz" -co2 ${co2file} -ldeg "${ldeg}" \
#          -dmat "${wdr}/${demat}_demean.1D" "${wdr}/${demat}_deriv1.1D" -scale "${scale}" -lm "${lm}" -ls "${ls}" --r2full" "-debug"

#         phys2cvr -i "${wdr}/${func_in}.nii.gz" -o "${wdr}/CVR_mpr" -r ${wdr}/${fmask}_eroded.nii.gz -m "${wdr}/${fmask}.nii.gz" -co2 ${co2file} -ldeg ${ldeg}  \
#              -dmat "${wdr}/${demat}_demean.1D" "${wdr}/${demat}_deriv1.1D" -scale ${scale} -lm ${lm} -ls ${ls} --r2full -debug
#     fi

    
#     # agressive approach (aggr)
#     if [ "${model}" == "aggr" ]; then
    

#         echo "*********************************************"
#         echo "***Compute the aggresive approach***"
#         echo "*********************************************"
    
#         echo "phys2cvr -i "${wdr}/${func_in}.nii.gz" -o "${wdr}/CVR_aggr" -r ${wdr}/${fmask}_eroded.nii.gz -m "${wdr}/${fmask}.nii.gz" -co2 ${co2file} -ldeg "${ldeg}" \
#             -dmat "${wdr}/${demat}_demean.1D" "${wdr}/${demat}_deriv1.1D" "${MEICA}/ICA_components_rejected.1D"  \
#             -scale "${scale}" -lm "${lm}" -ls "${ls}" --r2full" "-debug"

#         phys2cvr -i "${wdr}/${func_in}.nii.gz" -o "${wdr}/CVR_aggr" -r ${wdr}/${fmask}_eroded.nii.gz -m "${wdr}/${fmask}.nii.gz" -co2 ${co2file} -ldeg ${ldeg} \
#              -dmat "${wdr}/${demat}_demean.1D" "${wdr}/${demat}_deriv1.1D" "${MEICA}/ICA_components_rejected.1D"  \
#             -scale ${scale} -lm ${lm} -ls ${ls} --r2full -debug
#     fi

    
#     # moderate approach (mode)
#     if [ "${model}" == "mode" ]; then

#         echo "************************************"
#         echo "***Compute the modarate approach***"
#         echo "************************************"

#         echo " phys2cvr -i "${wdr}/${func_in}.nii.gz" -o "${wdr}/CVR_mode" -r ${wdr}/${fmask}_eroded.nii.gz -m "${wdr}/${fmask}.nii.gz" -co2 ${co2file} -ldeg "${ldeg}"  \
#             -dmat "${wdr}/${demat}_demean.1D" "${wdr}/${demat}_deriv1.1D" -omat "${MEICA}/ICA_components_rejected.1D"  \
#             -scale "${scale}" -lm "${lm}" -ls "${ls}" --r2full" "-debug"

#         phys2cvr -i "${wdr}/${func_in}.nii.gz" -o "${wdr}/CVR_mode" -r ${wdr}/${fmask}_eroded.nii.gz -m "${wdr}/${fmask}.nii.gz" -co2 ${co2file} -ldeg ${ldeg} \
#             -dmat "${wdr}/${demat}_demean.1D" "${wdr}/${demat}_deriv1.1D" -omat "${MEICA}/ICA_components_rejected.1D"  \
#             -scale ${scale} -lm ${lm} -ls ${ls} --r2full -debug

#     fi


# # conservative approach (cons)

    if [ "${model}" == "cons" ]; then

		echo "************************************"
        echo "***Compute the conservative approach*"
		echo "************************************"
        
        echo " phys2cvr -i "${wdr}/${func_in}.nii.gz" -o "${wdr}/phys2cvr_cons_newpeakdet" -r ${wdr}/${fmask}_eroded.nii.gz -m "${wdr}/${fmask}.nii.gz" -co2 ${co2file} -ldeg "${ldeg}" \
            -dmat "${wdr}/${demat}_demean.1D" "${wdr}/${demat}_deriv1.1D" -omat "${MEICA}/ICA_components_rejected.1D"  \
            -emat "${MEICA}/ICA_components_accepted.1D" -scale "${scale}" -lm "${lm}" -ls "${ls}" --r2full -debug"
    
        phys2cvr -i "${wdr}/${func_in}.nii.gz" -o "${wdr}/phys2cvr_cons_newpeakdet" -m "${wdr}/${fmask}.nii.gz" -co2 ${co2file} -ldeg ${ldeg} \
             -dmat "${wdr}/${demat}_demean.1D" "${wdr}/${demat}_deriv1.1D" -omat "${MEICA}/ICA_components_rejected.1D"  \
             -emat "${MEICA}/ICA_components_accepted.1D" -scale ${scale} -lm ${lm} -ls ${ls} --r2full -debug


  fi


    echo "3dcalc -a "${wdr}/phys2cvr_cons_newpeakdet/sub-${sub[$i]}_ses-${ses[i]}_task-${task}_run-${run}_optcom_bold_sm_cvr.nii.gz" -expr 'a/0.0712' \
            -prefix "${wdr}/phys2cvr_cons_newpeakdet/sub-${sub[$i]}_ses-${ses[i]}_task-${task}_run-${run}_optcom_bold_sm_cvr_scaled.nii.gz""
               
    3dcalc -a "${wdr}/phys2cvr_cons_newpeakdet/sub-${sub[$i]}_ses-${ses[i]}_task-${task}_run-${run}_optcom_bold_sm_cvr.nii.gz" -expr 'a/0.0712' \
            -prefix "${wdr}/phys2cvr_cons_newpeakdet/sub-${sub[$i]}_ses-${ses[i]}_task-${task}_run-${run}_optcom_bold_sm_cvr_scaled.nii.gz" 

done



#PRIMER
# module load afni/latest
# module load python/python3.6

# PRJDIR="/bcbl/home/public/CVR/PRESURGICAL_BIDS"

# #sub=$1
# #ses=$2
# #run=$3
# #task=$4
# #wdr=$5

# sub=056
# ses=1
# run=1
# task=BH

#Choose the model of each case: mpr, aggr, mode or cons 
# model=mode



# wdr=${PRJDIR}/sub-${sub}/ses-${ses}/func_preproc 



# # phys2cvr calculates the signal percentage change internally. So no need to do it before.
# #func_in=$6
# func_in="${flpr}_task-${task}_optcom_bold_sm"
# #fmask=${7}
# fmask="${flpr}_task-${task}_optcom_mask"
# #co2file=$8
# co2file="/bcbl/home/public/CVR/PRESURGICAL_BIDS/Peakdet/sub-050_task-breathhold_recording-125Hz_physio_peak_ch-co2.phys"
# #fs_co2=$9
# demat="${flpr}_task-${task}_run-${run}_echo-1_bold_cr_mcf"

# # tr=$(3dinfo -tr "${wdr}/${func_in}.nii.gz")

# #echo "phys2cvr -i "${wdr}/${func_in}.nii.gz" -m "${wdr}/${fmask}.nii.gz" -co2 ${co2file} -lm 9 -ls 1 -r2full"
# echo "phys2cvr -i "${MEICA}/${func_in}.nii.gz" -m "${wdr}/${fmask}.nii.gz" -co2 ${co2file} -ldeg 5 -dmat "${wdr}/${demat}_demean.1D" "${wdr}_deriv1.1D" -omat "${MEICA}/ICA_rejected.1D" -emat "${MEICA}/ICA_accepted.1D" -scale 71.2 --brightspin -debug"
# #phys2cvr -i "${wdr}/${func_in}.nii.gz" -m "${wdr}/${fmask}.nii.gz" -co2 ${co2file} -lm 9 -ls 1 -r2full 

# # optimally combined (motion + legendre) approach (mpr)
# if [ "${model}" == "mpr" ]; then
#     echo "***Compute the optimally combined approach***"
#     echo "phys2cvr -i "${wdr}/${func_in}.nii.gz" -o "${wdr}/CVR_mpr" -m "${wdr}/${fmask}.nii.gz" -co2 ${co2file} -ldeg 5 \
#      -dmat "${wdr}/${demat}_demean.1D" "${wdr}/${demat}_deriv1.1D" -scale 71.2 -lm 9 -ls 0.3 --r2full -debug"

#     phys2cvr -i "${wdr}/${func_in}.nii.gz" -o "${wdr}/CVR_mpr" -m "${wdr}/${fmask}.nii.gz" -co2 ${co2file} -ldeg 5 \
#      -dmat "${wdr}/${demat}_demean.1D" "${wdr}/${demat}_deriv1.1D" -scale 71.2 -lm 9 -ls 0.3 --r2full -debug
# fi

# # agressive approach (aggr)
# if [ "${model}" == "aggr" ]; then
#     echo "***Compute the aggresive approach***"
#     echo "phys2cvr -i "${wdr}/${func_in}.nii.gz" -o "${wdr}/CVR_aggr" -m "${wdr}/${fmask}.nii.gz" -co2 ${co2file} -ldeg 5 \
#     -dmat "${wdr}/${demat}_demean.1D" "${wdr}/${demat}_deriv1.1D" "${MEICA}/ICA_components_rejected.1D"  \
#     -scale 71.2 -lm 9 -ls 0.3 -r2full -debug"

#     phys2cvr -i "${wdr}/${func_in}.nii.gz" -o "${wdr}/CVR_aggr" -m "${wdr}/${fmask}.nii.gz" -co2 ${co2file} -ldeg 5 \
#      -dmat "${wdr}/${demat}_demean.1D" "${wdr}/${demat}_deriv1.1D" "${MEICA}/ICA_components_rejected.1D"  \
#         -scale 71.2 -lm 9 -ls 0.3 --r2full -debug
# fi

# # moderate approach (mode)
# if [ "${model}" == "mode" ]; then
#      echo "***Compute the modarate approach***"
#      echo " phys2cvr -i "${wdr}/${func_in}.nii.gz" -o "${wdr}/CVR_mode2" -m "${wdr}/${fmask}.nii.gz" -co2 ${co2file} -ldeg 4 \
#     -dmat "${wdr}/${demat}_demean.1D" "${wdr}/${demat}_deriv1.1D" -omat "${MEICA}/ICA_components_rejected.1D"  \
#     -scale 71.2 -lm 9 -ls 0.3 --r2full -debug"

#     phys2cvr -i "${wdr}/${func_in}.nii.gz" -o "${wdr}/CVR_mode2" -m "${wdr}/${fmask}.nii.gz" -co2 ${co2file} -ldeg 4 \
#         -dmat "${wdr}/${demat}_demean.1D" "${wdr}/${demat}_deriv1.1D" -omat "${MEICA}/ICA_components2_rejected.1D"  \
#         -scale 71.2 -lm 9 -ls 0.3 --r2full -debug

# fi

# # conservative approach (cons)
# if [ "${model}" == "cons" ]; then
#     echo "***Compute the conservative approach***"
#     echo " phys2cvr -i "${wdr}/${func_in}.nii.gz" -o "${wdr}/CVR_cons2" -m "${wdr}/${fmask}.nii.gz" -co2 ${co2file} -ldeg 4 \
#         -dmat "${wdr}/${demat}_demean.1D" "${wdr}/${demat}_deriv1.1D" -omat "${MEICA}/ICA_components_rejected.1D"  \
#         -emat "${MEICA}/ICA_components_accepted.1D" -scale 71.2 -lm 9 -ls 0.3 --r2full -debug"
    
#     phys2cvr -i "${wdr}/${func_in}.nii.gz" -o "${wdr}/CVR_cons2" -m "${wdr}/${fmask}.nii.gz" -co2 ${co2file} -ldeg 4 \
#         -dmat "${wdr}/${demat}_demean.1D" "${wdr}/${demat}_deriv1.1D" -omat "${MEICA}/ICA_components2_rejected.1D"  \
#         -emat "${MEICA}/ICA_components2_accepted.1D" -scale 71.2 -lm 9 -ls 0.3 --r2full -debug
# fi

# # create symbolic link to a folder for visualization with AFNI
# if [[ !-d "${wdr}/links_4_AFNI" ]]; then
#     echo "Createing folder links_4_AFNI to put all volumes for better visualization in AFNI"
#     mkdir -p "${wdr}/links_4_AFNI"
# fi

# # run 3dcalc with identity so that the values of the AFNI header are correct (since they are not updated by phys2cvr)
# for metric in cvr cvr_simple lag lag_mkrel tstat tstat_simple
# do
#     3dcalc -a "${wdr}/CVR_${model}/${func_in}_${metric}.nii.gz" -expr 'a' -prefix "${wdr}/CVR_${model}/${func_in}_${metric}.nii.gz" -overwrite
#     ln -s "${wdr}/CVR_${model}/${func_in}_${metric}.nii.gz" "${wdr}/links_4_AFNI/${func_in}_${metric}_${model}.nii.gz"
# done

# optional arguments to try
# change -ls to 0.3
# -tlen : 58s & -ntrial : 8
# -ldeg: 5
# -dmat: multiple options (motion parameters (${func}_mcf_demean.1D) and derivatives (${func}_mcf_deriv.1D), ME-ICA conservative approach)

#  phys2cvr -i "func2.nii.gz" -o "CVR_cons_phys2cvr" -m "mask2.nii.gz" -r "roi2.nii.gz" -co2 "co2.phys" -ldeg 4 \
#         -dmat "motpar.par" "motderiv.par" -omat "omat.1D"  \
#         -emat "emat.1D" -scale 71.2 -lm 9 -ls 0.3 --r2full -debug"



  