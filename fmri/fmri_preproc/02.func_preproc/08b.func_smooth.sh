#!/usr/bin/env bash

######### FUNCTIONAL 04 for PJMASK
# Author:  Eneko Uruñuela
# Version: 1.0
# Date:    10.2021
#########

## Variables
# functional
func_in=$1
# folders
fdir=$2
# FWHM
fwhm=${3:-5}
# mask
mask=$4
# Temp folder
tmp=${5:-.}
# out name
func_out=$6

### print input
printline=$( basename -- $0 )
echo "${printline} " "$@"
######################################
######### Script starts here #########
######################################

cwd=$(pwd)

cd ${fdir} || exit

## 01. Smooth
echo "Smoothing ${func_in}"
# 3dBlurInMask -input ${tmp}/${func_in}.nii.gz -prefix ${tmp}/${func_out}.nii.gz \
#     -mask ${mask}.nii.gz -preserve -FWHM ${fwhm} -overwrite
3dBlurInMask -input ${fdir}/${func_in}.nii.gz -prefix ${tmp}/${func_out}.nii.gz \
    -mask ${mask}.nii.gz -preserve -FWHM ${fwhm} -overwrite


cd ${cwd}