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


#Load in Cluster all the module necessary 
module load python/pythonvenv
module load afni/latest
module load freesurfer/7.2.0

source activate /bcbl/home/public/CVR/conda_phys2cvr


#Project Directory
PRJDIR="/bcbl/home/public/CVR/PRESURGICAL_BIDS"
#Inputs of interest

sub=$1
ses=$2
run=$3
wdr=$4
task=$5

#Choose the model of each case: mpr, aggr, mode or cons 
model=${6:-cons}



# phys2cvr calculates the signal percentage change internally. So no need to do it before.

#Indicate the bold signal and mask 
func_in=$7
fmask=${8}


#CO2 file that is in the Peakdet folder 
co2file=$9

#MEICA folder where manual classification is stored
meica=${10}

#demat matrices initial: deman and derivatives 
demat=${11}

#Indicate all the variables needed for phys2cvr (will be ask outside the function)

#Legendre polynomial 
ldeg=4
#Lag considered
lm=9
#Lag step
ls=0.3
#scale factor for beta maps will be divided to create CVR maps 
scale=71.2

 
# optimally combined (motion + legendre) approach (mpr)
if [ "${model}" == "mpr" ]; then

    echo "*********************************************"
    echo "***Compute the optimally combined approach***"
    echo "*********************************************"

    echo "phys2cvr -i "${wdr}/${func_in}.nii.gz" -o "${wdr}/CVR_mpr" -r ${wdr}/${fmask}_eroded.nii.gz -m "${wdr}/${fmask}.nii.gz" -co2 ${co2file} -ldeg "${ldeg}" \
     -dmat "${wdr}/${demat}_demean.1D" "${wdr}/${demat}_deriv1.1D" -scale "${scale}" -lm "${lm}" -ls "${ls}" --r2full"

    phys2cvr -i "${wdr}/${func_in}.nii.gz" -o "${wdr}/CVR_mpr" -r ${wdr}/${fmask}_eroded.nii.gz -m "${wdr}/${fmask}.nii.gz" -co2 ${co2file} -ldeg ${ldeg}  \
            -dmat "${wdr}/${demat}_demean.1D" "${wdr}/${demat}_deriv1.1D" -scale ${scale} -lm ${lm} -ls ${ls} --r2full
 fi

    
# agressive approach (aggr)
 if [ "${model}" == "aggr" ]; then
    
    echo "*********************************************"
    echo "***Compute the aggresive approach***"
    echo "*********************************************"
    
    echo "phys2cvr -i "${wdr}/${func_in}.nii.gz" -o "${wdr}/CVR_aggr" -r ${wdr}/${fmask}_eroded.nii.gz -m "${wdr}/${fmask}.nii.gz" -co2 ${co2file} -ldeg "${ldeg}" \
            -dmat "${wdr}/${demat}_demean.1D" "${wdr}/${demat}_deriv1.1D" "${MEICA}/ICA_components_rejected.1D"  \
            -scale "${scale}" -lm "${lm}" -ls "${ls}" --r2full"

    phys2cvr -i "${wdr}/${func_in}.nii.gz" -o "${wdr}/CVR_aggr" -r ${wdr}/${fmask}_eroded.nii.gz -m "${wdr}/${fmask}.nii.gz" -co2 ${co2file} -ldeg ${ldeg} \
        -dmat "${wdr}/${demat}_demean.1D" "${wdr}/${demat}_deriv1.1D" "${MEICA}/ICA_components_rejected.1D"  \
        -scale ${scale} -lm ${lm} -ls ${ls} --r2full
fi

    
# moderate approach (mode)
if [ "${model}" == "mode" ]; then

    echo "************************************"
    echo "***Compute the modarate approach***"
    echo "************************************"
    
    echo " phys2cvr -i "${wdr}/${func_in}.nii.gz" -o "${wdr}/CVR_mode" -r ${wdr}/${fmask}_eroded.nii.gz -m "${wdr}/${fmask}.nii.gz" -co2 ${co2file} -ldeg "${ldeg}"  \
            -dmat "${wdr}/${demat}_demean.1D" "${wdr}/${demat}_deriv1.1D" -omat "${MEICA}/ICA_components_rejected.1D"  \
            -scale "${scale}" -lm "${lm}" -ls "${ls}" --r2full"

    phys2cvr -i "${wdr}/${func_in}.nii.gz" -o "${wdr}/CVR_mode" -r ${wdr}/${fmask}_eroded.nii.gz -m "${wdr}/${fmask}.nii.gz" -co2 ${co2file} -ldeg ${ldeg} \
        -dmat "${wdr}/${demat}_demean.1D" "${wdr}/${demat}_deriv1.1D" -omat "${MEICA}/ICA_components_rejected.1D"  \
         -scale ${scale} -lm ${lm} -ls ${ls} --r2full

    fi


# conservative approach (cons)
if [ "${model}" == "cons" ]; then

	echo "************************************"
    echo "***Compute the conservative approach*"
	echo "************************************"
        
    echo " phys2cvr -i "${wdr}/${func_in}.nii.gz" -o "${wdr}/CVR_cons" -r ${wdr}/${fmask}_eroded.nii.gz -m "${wdr}/${fmask}.nii.gz" -co2 ${co2file} -ldeg "${ldeg}" \
          -dmat "${wdr}/${demat}_demean.1D" "${wdr}/${demat}_deriv1.1D" -omat "${MEICA}/ICA_components_rejected.1D"  \
          -emat "${MEICA}/ICA_components_accepted.1D" -scale "${scale}" -lm "${lm}" -ls "${ls}" --r2full"
    
    phys2cvr -i "${wdr}/${func_in}.nii.gz" -o "${wdr}/CVR_cons" -r ${wdr}/${fmask}_eroded.nii.gz -m "${wdr}/${fmask}.nii.gz" -co2 ${co2file} -ldeg ${ldeg} \
            -dmat "${wdr}/${demat}_demean.1D" "${wdr}/${demat}_deriv1.1D" -omat "${MEICA}/ICA_components_rejected.1D"  \
            -emat "${MEICA}/ICA_components_accepted.1D" -scale ${scale} -lm ${lm} -ls ${ls} --r2full
    fi