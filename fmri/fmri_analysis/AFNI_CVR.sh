#!/usr/bin/env bash
#$ -cwd
#$ -m be
#$ -M c.comella@bcbl.eu
#$ -N TA
#$ -S /bin/bash
#$ -q long.q

######### AFNI CVR MAPS for Presurgical Patients
# Author:  Cristina Comella
# Version: 1.0
# Date:    22.03.2023
#########

module load python/venv
source activate /bcbl/home/public/CVR/setup/conda_phys2cvr
module load afni/latest
module load fsl/6.0.2

#Working Directory
sub=$1
ses=$2
task=$3
run=$4

echo "script working on sub-${sub}_ses-${ses}_task-${task}_run-${run}"

#Project Directory
PRJDIR=$5

#Indicate the Fun_preproc directory
func_preproc=$6
echo "Func preproc is $func_preproc"



# type of model. ftype is optcom, echo-2, or any denoising of meica, vessels, and networks
ftype=$7 # type of model (mpr, meica-aggr, meica-mode, meica-cons)

case ${ftype} in
	meica* | vessels* | networks* | optcom* | echo-2 ) echo "Good ftype ${ftype}" ;;
	* ) echo "Wrong ftype: ${ftype}"; exit ;;
esac


# Create new working folder for the current model
wdr_new=${PRJDIR}/sub-${sub}/ses-${ses}/func_preproc/AFNI_${ftype}
if [[ ! -d "${wdr_new}" ]]; then
    echo "Creating folder ${wdr_new}"
    mkdir -p "${wdr_new}"
fi

matrix_mod() {
mat=$1
newmat=${mat%.1D}_mod.1D
echo "Name of modified design matrix is ${newmat}"

# Get data from original matrix
ni_type=$( cat ${mat} | grep ni_type )
ni_dimen=$( cat ${mat} | grep ni_dimen )
ColumnLabels=$( cat ${mat} | grep ColumnLabels )
# RowTR=$( cat ${mat} | grep RowTR )
GoodList=$( cat ${mat} | grep GoodList )
NRowFull=$( cat ${mat} | grep NRowFull )
RunStart=$( cat ${mat} | grep RunStart )

# Get updated data based on original matrix
Nstim=${ni_type#*\"}
Nstim=${Nstim%\**}
StimLabels=\"${ColumnLabels#*\"}
let StimBotsTops=Nstim-1
# let Nstim=Nstim-5

# Print matrix to file
echo "\# <matrix" > ${newmat}
echo "${ni_type}" >> ${newmat}
echo "${ni_dimen}" >> ${newmat}
echo "${ColumnLabels}" >> ${newmat}
echo "${RowTR}" >> ${newmat}
echo "${GoodList}" >> ${newmat}
echo "${NRowFull}" >> ${newmat}
echo "${RunStart}" >> ${newmat}
echo "\#  Nstim = \"${Nstim}\"" >> ${newmat}
# All the columns will contain SIGNAL, except for the baseline.
echo "\#  StimBots = \"0..${StimBotsTops}\"" >> ${newmat} 
echo "\#  StimTops = \"0..${StimBotsTops}\"" >> ${newmat}
echo "\#  StimLabels = ${StimLabels}" >> ${newmat}
echo "\# >" >> ${newmat}

# Print data to file
csvtool drop 15 ${mat} >> ${newmat}
}

# # THE FOLLOWING FUNCTION IS NOT REQUIRED IF WE KEEP THE RESULTS IN ${wdr_new}
# # if_missing_do() {
# # if [ $1 == 'mkdir' ]
# # then
# # 	if [ ! -d $2 ]
# # 	then
# # 		mkdir "${@:2}"
# # 	fi
# # elif [ ! -e $3 ]
# # then
# # 	printf "%s is missing, " "$3"
# # 	case $1 in
# # 		copy ) echo "copying $2"; cp $2 $3 ;;
# # 		mask ) echo "binarising $2"; fslmaths $2 -bin $3 ;;
# # 		* ) echo "and you shouldn't see this"; exit ;;
# # 	esac
# # fi
# # }

# replace_and() {
# case $1 in
# 	mkdir) if [ -d $2 ]; then rm -rf $2; fi; mkdir $2 ;;
# 	touch) if [ -e $2 ]; then rm -rf $2; fi; touch $2 ;;
# esac
# }

### MAIN script #####

#Parameters of choice 

lag=${8:-9} # maximum range of lag (seconds)
step=${9:-0.3} # lag shift (seconds)
freq=${10:-40} # sampling frequency of petco2 signal

tr=1.5 # TR of dataset
echo "The TR of this dataset is ${tr}"

let poslag=lag*freq
let miter=poslag*2
step_default=$(echo '$freq * $step' | bc)
step_idx=${11:-${step_default}} #step*freq
echo "step_idx=${step_idx}, poslag=${poslag}, miter=${miter}"

#let nmodels=cei(lag*2/step)+1
nmodels=$(echo "$lag*2/$step" | bc)
rounded_nmodels=$(printf "%.0f" "$nmodels")
let nmodels=rounded_nmodels+1
echo "nmodels=${nmodels}"

# p-value for statistical thresholding
pval=${12:-0.05}
lag_pcorr=${13:-yes}
if [[ lag_pcorr = "yes" ]]; then
	pval=$(echo "$pval/$nmodels" | bc -l)
	pval=$(printf "%.5f\n" "$default_p")
fi
echo "pval=${pval}, lag_pcorr=${lag_pcorr}"

### Main ###
cwd=$( pwd )

set -e
#set -x

#In AFNI the data used is the data after signal percentage change 

#Functional Data of interest 
if [ -z "${14}" ]; then
    func="${func_preproc}/sub_${sub}_ses_${ses}_task_${task}_run_${run}_optcom_bold_spc"
else
    func="${14}"
fi
echo "func=${func}"

#Mask of Interest
if [ -z "${15}" ]; then
    mask="${func_preproc}/sub_${sub}_ses_${ses}_task_${task}_optcom_mask"
else
    mask="${15}"
fi
echo "mask=${mask}"

#Mat Directory (duda: donde queremos esto?)
matdir="${wdr_new}/mat"
# check if folder for the design matrices already exits. If not create it
if [[ ! -d "${matdir}" ]]; then
    echo "Creating folder ${matdir}"
    mkdir -p "${matdir}"
fi

# creating 
#replace_and mkdir ${wdr_new}/tmp.${ftype}_02cms_res
mkdir ${wdr_new}/tmp.${ftype}_02cms_res


#Indicate matrix of interest

#Meica Folder
meica_folder="${PRJDIR}/sub-${sub}/ses-${ses}/tmp/task-${task}/sub-${sub}_ses-${ses}_task-${task}_run-${run}_meica"
echo ${meica_folder}

#Omat is matrix of bad componets named the same in each subject
omat="${meica_folder}/ICA_components_rejected"

#Emat is matrix of good components named the same in each subjedct
emat="${meica_folder}/ICA_components_accepted"

#Motion Parameters: 

#Derivatives and Demean
if [ -z "${16}" ]; then
    demean="${func_preproc}/sub-${sub}_ses-${ses}_task-${task}_run-${run}_echo-1_bold_cr_mcf_demean"
else
	demean="${16}"
fi

#Derivatives and Demean
if [ -z "${17}" ]; then
    deriv="${func_preproc}/sub-${sub}_ses-${ses}_task-${task}_run-${run}_echo-1_bold_cr_mcf_deriv1"
else
	deriv="${17}"
fi

# petco2hrf_folder: this is the folder where the regressor of interest is available at multiple shifts
#Lo ideal es que se llamen phys2cvr_optcom_mpr, tengo que cambiarlo pero mientras lo llamaremos: CVR_mpr CVR_aggr CVR_mode CVR_cons
if [ "${7}" == "optcom_mpr" ]; then 
    petco2hrf_folder="${func_preproc}/phy2cvr_optcom_mpr/regr"
	echo "***We are in ${petco2hrf_folder} folder*******"
fi


if [ "${7}" == "meica_aggr" ]; then 
    petco2hrf_folder="${func_preproc}/phys2cvr_meica_aggr/regr"
	echo "***We are in ${petco2hrf_folder} folder*******"
fi


if [ "${7}" == "meica_mode" ]; then 
    petco2hrf_folder="${func_preproc}/phy2cvr_meica_mode/regr"
	echo "***We are in ${petco2hrf_folder} folder*******"
fi


if [ "${7}" == "meica_cons" ]; then 
    petco2hrf_folder="${func_preproc}/CVR_cons/regr"
	echo "***We are in ${petco2hrf_folder} folder*******"
fi

# Demean omat ICAs
case ${ftype} in
	meica_aggr | meica_cons | meica_mode )
		1d_tool.py -infile ${omat}.1D -demean \
				   -write ${wdr_new}/tmp.${ftype}_02cms_res/omat.1D -overwrite
		# 1dtranspose tmp.${ftype}_02cms_res/omat.1D > tmp.${ftype}_02cms_res/omat.1D
	;;
esac

#RUNNING ITERATION
for i in $( seq -f %04g 0 ${step_idx} ${miter} )
do

	echo "*************************************************************"
	echo "*****   Running iteration ${i} out of ${miter} with a step of ${step_idx}**************"
	echo "*************************************************************"

	if [ -e ${petco2hrf_folder}/sub-${sub}_task-breathhold_recording-125Hz_physio_peak_ch-co2_${i}.1D ]
	then
		case ${ftype} in
			optcom* | echo-2 )
				#Simply add motparams and polorts ( = N )
				#Prepare matrix
				3dDeconvolve -overwrite -input ${func}.nii.gz -jobs 6 \
							 -float -num_stimts 1 \
							 -mask ${mask}.nii.gz \
							 -polort 4 \
							 -ortvec ${demean}.1D motdemean \
							 -ortvec ${deriv}.1D motderiv1 \
							 -stim_file 1 ${petco2hrf_folder}/sub-${sub}_task-breathhold_recording-125Hz_physio_peak_ch-co2_${i}.1D -stim_label 1 PetCO2 \
							 -x1D ${matdir}/mat.1D \
							 -xjpeg ${matdir}/mat.jpg \
							 -x1D_stop

				#Modify matrix and call 3dREMLfit
				matrix_mod ${matdir}/mat.1D
				3dREMLfit -overwrite -input ${func}.nii.gz -matrix ${matdir}/mat_mod.1D \
						  -mask ${mask}.nii.gz \
						  -rout -tout \
						  -Obuck ${wdr_new}/tmp.${ftype}_02cms_res/stats_${i}.nii.gz \
						  -Obeta ${wdr_new}/tmp.${ftype}_02cms_res/c_stats_${i}.nii.gz \
						  -Ofitts ${wdr_new}/tmp.${ftype}_02cms_res/fitts_${i}.nii.gz
			;;
			meica_aggr )
				#Simply add omat and N
				echo "Orthogonalizing rejected ICs wrt motion parameters (demean and derivative)"
				1dtranspose ${wdr_new}/tmp.${ftype}_02cms_res/omat.1D > ${wdr_new}/tmp.${ftype}_02cms_res/omat_tr.1D
				3dTproject -input ${wdr_new}/tmp.${ftype}_02cms_res/omat_tr.1D \
						   -ort ${demean}.1D \
						   -ort ${deriv}.1D \
						   -polort 4 -prefix ${wdr_new}/tmp.${ftype}_02cms_tr.1D -overwrite
				rm ${wdr_new}/tmp.${ftype}_02cms_res/omat_tr.1D

				echo "Demeaning orthogonalized rejected ICs"
				1dtranspose ${wdr_new}/tmp.${ftype}_02cms_tr.1D > ${wdr_new}/tmp.${ftype}_02cms_omat_ort.1D
				1d_tool.py -infile ${wdr_new}/tmp.${ftype}_02cms_omat_ort.1D -demean \
						   -write ${wdr_new}/tmp.${ftype}_02cms_omat_ort.1D -overwrite

				echo "Creating GLM model with 3dDeconvolve, but it will stop"
				3dDeconvolve -overwrite -input ${func}.nii.gz -jobs 6 \
							 -float -num_stimts 1 \
							 -mask ${mask}.nii.gz \
							 -polort 4 \
							 -ortvec ${demean}.1D motdemean \
							 -ortvec ${deriv}.1D motderiv1 \
							 -ortvec ${wdr_new}/tmp.${ftype}_02cms_res/omat.1D omat \
							 -stim_file 1 ${petco2hrf_folder}/sub-${sub}_task-breathhold_recording-125Hz_physio_peak_ch-co2_${i}.1D -stim_label 1 PetCO2 \
							 -x1D ${matdir}/mat_${i}.1D \
							 -xjpeg ${matdir}/mat.jpg \
							 -x1D_stop
				
				#Modify matrix and call 3dREMLfit
				echo "Modifying GLM matrix for 3dREMLfit purposes"
				matrix_mod ${matdir}/mat_${i}.1D
				echo "Running 3dREMLfit"				
				3dREMLfit -overwrite -input ${func}.nii.gz -matrix ${matdir}/mat_${i}_mod.1D \
						  -mask ${mask}.nii.gz \
						  -rout -tout \
						  -Obuck ${wdr_new}/tmp.${ftype}_02cms_res/stats_${i}.nii.gz \
						  -Obeta ${wdr_new}/tmp.${ftype}_02cms_res/c_stats_${i}.nii.gz \
						  -Ofitts ${wdr_new}/tmp.${ftype}_02cms_res/fitts_${i}.nii.gz
			;;
			meica_mode )
				#Add omat, orthogonalised by the PetCO2, and N.
				1dtranspose ${wdr_new}/tmp.${ftype}_02cms_res/omat.1D > ${wdr_new}/tmp.${ftype}_02cms_res/omat_tr.1D

				echo "Orthogonalizing rejected ICs wrt motion parameters (demean and derivative) and PETCO2hrf"

				3dTproject -input ${wdr_new}/tmp.${ftype}_02cms_res/omat_tr.1D \
						   -ort ${petco2hrf_folder}/sub-${sub}_task-breathhold_recording-125Hz_physio_peak_ch-co2_${i}.1D \
						   -ort ${demean}.1D \
						   -ort ${deriv}.1D \
						   -polort 4 -prefix ${wdr_new}/tmp.${ftype}_02cms_tr.1D -overwrite
				rm ${wdr_new}/tmp.${ftype}_02cms_res/omat_tr.1D

				echo "Demeaning orthogonalized rejected ICs"
				1dtranspose ${wdr_new}/tmp.${ftype}_02cms_tr.1D > ${wdr_new}/tmp.${ftype}_02cms_omat_ort.1D
				1d_tool.py -infile ${wdr_new}/tmp.${ftype}_02cms_omat_ort.1D -demean \
						   -write ${wdr_new}/tmp.${ftype}_02cms_omat_ort.1D -overwrite

				echo "Creating GLM model with 3dDeconvolve, but it will stop"
				3dDeconvolve -overwrite -input ${func}.nii.gz -jobs 6 \
							 -float -num_stimts 1 \
							 -mask ${mask}.nii.gz \
							 -polort 4 \
							 -ortvec ${demean}.1D motdemean \
					    	 -ortvec ${deriv}.1D motderiv1 \
							 -ortvec ${wdr_new}/tmp.${ftype}_02cms_omat_ort.1D omat \
							 -stim_file 1 ${petco2hrf_folder}/sub-${sub}_task-breathhold_recording-125Hz_physio_peak_ch-co2_${i}.1D -stim_label 1 PetCO2 \
							 -x1D ${matdir}/mat_${i}.1D \
							 -xjpeg ${matdir}/mat.jpg \
							 -x1D_stop

				#Modify matrix and call 3dREMLfit
				echo "Modifying GLM matrix for 3dREMLfit purposes"
				matrix_mod ${matdir}/mat_${i}.1D
				3dREMLfit -overwrite -input ${func}.nii.gz -matrix ${matdir}/mat_${i}_mod.1D \
						  -mask ${mask}.nii.gz \
						  -rout -tout \
						  -Obuck ${wdr_new}/tmp.${ftype}_02cms_res/stats_${i}.nii.gz \
						  -Obeta ${wdr_new}/tmp.${ftype}_02cms_res/c_stats_${i}.nii.gz \
						  -Ofitts ${wdr_new}/tmp.${ftype}_02cms_res/fitts_${i}.nii.gz
			;;
			meica_cons )
				#Add omat, orthogonalised by the (all the) good components and the PetCO2, and N.
			
				1d_tool.py -infile ${emat}.1D -demean \
						   -write ${wdr_new}/tmp.${ftype}_02cms_res/emat.1D -overwrite

				1dtranspose ${wdr_new}/tmp.${ftype}_02cms_res/omat.1D > ${wdr_new}/tmp.${ftype}_02cms_res/omat_tr.1D

				echo "Orthogonalizing rejected ICs wrt motion parameters (demean and derivative), accepted ICs components and PETCO2hrf"
				3dTproject -input ${wdr_new}/tmp.${ftype}_02cms_res/omat_tr.1D \
						   -ort ${petco2hrf_folder}/sub-${sub}_task-breathhold_recording-125Hz_physio_peak_ch-co2_${i}.1D \
						   -ort ${wdr_new}/tmp.${ftype}_02cms_res/emat.1D \
						   -ort ${demean}.1D \
						   -ort ${deriv}.1D \
						   -polort 4 -prefix ${wdr_new}/tmp.${ftype}_02cms_tr.1D -overwrite
				rm ${wdr_new}/tmp.${ftype}_02cms_res/omat_tr.1D

				1dtranspose ${wdr_new}/tmp.${ftype}_02cms_tr.1D > ${wdr_new}/tmp.${ftype}_02cms_omat_ort.1D
				1d_tool.py -infile ${wdr_new}/tmp.${ftype}_02cms_omat_ort.1D -demean \
						   -write ${wdr_new}/tmp.${ftype}_02cms_omat_ort.1D -overwrite

				echo "Creating GLM model with 3dDeconvolve, but it will stop"
				3dDeconvolve -overwrite -input ${func}.nii.gz -jobs 6 \
							 -float -num_stimts 1 \
							 -mask ${mask}.nii.gz \
							 -polort 4 \
							 -ortvec ${demean}.1D motdemean \
							 -ortvec ${deriv}.1D  motderiv1 \
							 -ortvec ${wdr_new}/tmp.${ftype}_02cms_omat_ort.1D omat \
							 -stim_file 1 ${petco2hrf_folder}/sub-${sub}_task-breathhold_recording-125Hz_physio_peak_ch-co2_${i}.1D -stim_label 1 PetCO2 \
							 -x1D ${matdir}/mat_${i}.1D \
							 -xjpeg ${matdir}/mat.jpg \
							 -x1D_stop

				#Modify matrix and call 3dREMLfit
				echo "Modifying GLM matrix for 3dREMLfit purposes"
				matrix_mod ${matdir}/mat_${i}.1D #Duda: porque en aggr solo es mat.1D y aca se agrega cada componente igual en el mode
				3dREMLfit -overwrite -input ${func}.nii.gz -matrix ${matdir}/mat_${i}_mod.1D \
						  -mask ${mask}.nii.gz \
						  -rout -tout \
						  -Obuck ${wdr_new}/tmp.${ftype}_02cms_res/stats_${i}.nii.gz \
						  -Obeta ${wdr_new}/tmp.${ftype}_02cms_res/c_stats_${i}.nii.gz \
						  -Ofitts ${wdr_new}/tmp.${ftype}_02cms_res/fitts_${i}.nii.gz
			;;
			* ) echo "    !!! Warning !!! Invalid ftype: ${ftype}"; exit ;;
		esac
        #append R2 stat to bucket with all the R2 statistical maps with all lags
		3dbucket -prefix ${wdr_new}/tmp.${ftype}_02cms_res/${ftype}_r2_${i}.nii.gz -abuc ${wdr_new}/tmp.${ftype}_02cms_res/stats_${i}.nii.gz'[0]' -overwrite
	fi
done

# Concatenate in time all R2 statistical maps and force TR
3dTcat -prefix ${wdr_new}/${ftype}_r2_time.nii.gz -tr ${tr} ${wdr_new}/tmp.${ftype}_02cms_res/${ftype}_r2_*.nii.gz -overwrite
# find out which index (i.e. lag) has the maximum R2 statistic
3dTstat -argmax -prefix ${wdr_new}/${ftype}_cvr_idx.nii.gz ${wdr_new}/${ftype}_r2_time.nii.gz -overwrite
# compute lag in seconds based on this index
3dcalc -a ${wdr_new}/${ftype}_cvr_idx.nii.gz -m ${mask}.nii.gz -expr "bool(m)*(a*${step} - ${lag})" -prefix ${wdr_new}/${ftype}_cvr_lag.nii.gz -overwrite

# prepare empty volumes
3dcalc -a ${wdr_new}/${ftype}_cvr_idx.nii.gz -expr '0*a' -prefix ${wdr_new}/${ftype}_statsbuck.nii.gz -overwrite
3dcalc -a ${wdr_new}/${ftype}_cvr_idx.nii.gz -expr '0*a' -prefix ${wdr_new}/${ftype}_cbuck.nii.gz -overwrite
3dcalc -a ${func}.nii.gz -expr '0*a' -prefix ${wdr_new}/${ftype}_fitts.nii.gz -overwrite
3dcalc -a ${func}.nii.gz -expr '0*a' -prefix ${wdr_new}/${ftype}_fitts_PetCO2.nii.gz -overwrite

maxidx=$( fslstats ${wdr_new}/${ftype}_cvr_idx.nii.gz -R ) # this could be converted to AFNI 3dROIstats -minmax
echo "Maximum index of lags: ${maxidx}"
#3dROIstats -minmax -nomeanout -quiet -mask ${mask}.nii.gz ${wdr_new}/${ftype}_cvr_idx.nii.gz

maxidx=(`echo $maxidx | awk '{print $1}'` `echo $maxidx | awk '{print $2}'`) #normalmente esto no se debería de necesitar
echo ${maxidx[1]}

# #Despues dia 12 julio para 050 y 054 no me queria funcionar 
for i in $( seq -f %g 0 ${maxidx[1]} )
do
	echo "iteration $i out of ${maxidx[1]}"
	v=$( echo "$i*${step_idx}" | bc )
	echo "v=${v}"
	v=$( printf %04d ${v} )
	echo "v=${v}"
	3dcalc -a ${wdr_new}/${ftype}_statsbuck.nii.gz -b ${wdr_new}/tmp.${ftype}_02cms_res/stats_${v}.nii.gz -c ${wdr_new}/${ftype}_cvr_idx.nii.gz \
		-expr "a+b*equals(c,${i})" -prefix ${wdr_new}/${ftype}_statsbuck.nii.gz -overwrite
	3dcalc -a ${wdr_new}/${ftype}_cbuck.nii.gz -b ${wdr_new}/tmp.${ftype}_02cms_res/c_stats_${v}.nii.gz -c ${wdr_new}/${ftype}_cvr_idx.nii.gz \
		-expr "a+b*equals(c,${i})" -prefix ${wdr_new}/${ftype}_cbuck.nii.gz -overwrite
	3dcalc -a ${wdr_new}/${ftype}_fitts.nii.gz -b ${wdr_new}/tmp.${ftype}_02cms_res/fitts_${v}.nii.gz -c ${wdr_new}/${ftype}_cvr_idx.nii.gz \
		-expr "a+b*equals(c,${i})" -prefix ${wdr_new}/${ftype}_fitts.nii.gz -overwrite
	# create fitted PetCO2 signal 
	3dcalc -a ${wdr_new}/${ftype}_fitts_PetCO2.nii.gz -b ${wdr_new}/tmp.${ftype}_02cms_res/stats_${v}.nii.gz[17] -t ${matdir}/mat_${v}.1D[5] \
	   -c ${wdr_new}/${ftype}_cvr_idx.nii.gz -expr "a+(b*t)*equals(c,${i})" -prefix ${wdr_new}/${ftype}_fitts_PetCO2.nii.gz -overwrite
done

# #LO HICE APARTE SOLO PARA EL SUB 052
# #Despues dia 12 julio para 050 y 054
# for i in $( seq -f %g 0 ${maxidx[1]} )
# do
# 	(( v=i*step_idx ))
# 	v=$( printf %04d $v )
# 	echo "iteration $i out of ${maxidx[1]}"
# 	# create fitted PetCO2 signal 
# 	3dcalc -a ${wdr_new}/${ftype}_fitts_PetCO2.nii.gz -b ${wdr_new}/tmp.${ftype}_02cms_res/stats_${v}.nii.gz[17] -t ${matdir}/mat_${v}.1D[5] \
# 	   -c ${wdr_new}/${ftype}_cvr_idx.nii.gz -expr "a+(b*t)*equals(c,${i})" -prefix ${wdr_new}/${ftype}_fitts_PetCO2.nii.gz -overwrite
# done

# Extract volumes of CVR amplitude and its corresponding t-statistic. The indexes 17 and 18 are
# because these volumes are saved after polynomial regressors and full stats
3dbucket -prefix ${wdr_new}/${ftype}_spc_over_Volts.nii.gz -abuc ${wdr_new}/${ftype}_statsbuck.nii.gz'[17]' -overwrite
3dbucket -prefix ${wdr_new}/${ftype}_tstat.nii.gz -abuc ${wdr_new}/${ftype}_statsbuck.nii.gz'[18]' -overwrite

# Obtain first CVR maps
# the factor 71.2 is to take into account the pressure in mmHg:
# CO2[mmHg] = ([pressure in Donosti]*[Lab altitude] - [Air expiration at body temperature])[mmHg]*(channel_trace[V]*10[V^(-1)]/100)
# CO2[mmHg] = (768*0.988-47)[mmHg]*(channel_trace*10/100) ~ 71.2 mmHg
# multiply by 100 cause it's not BOLD % yet!
3dcalc -a ${wdr_new}/${ftype}_spc_over_Volts.nii.gz -expr '100*(a/71.2)' -prefix ${wdr_new}/${ftype}_cvr.nii.gz -overwrite
3dcalc -a ${wdr_new}/${ftype}_fitts.nii.gz -expr '100*(a/71.2)' -prefix ${wdr_new}/${ftype}_fitts.nii.gz -overwrite
3dcalc -a ${wdr_new}/${ftype}_fitts_PetCO2.nii.gz -expr '100*(a/71.2)' -prefix ${wdr_new}/${ftype}_fitts_PetCO2.nii.gz -overwrite

# Obtain "simple" t-stats and CVR (those for zero lag)
medianvol=$( printf %04d ${poslag} )
3dcalc -a ${wdr_new}/tmp.${ftype}_02cms_res/stats_${medianvol}.nii.gz'[17]' -expr '100*(a/71.2)' \
	   -prefix ${wdr_new}/${ftype}_cvr_simple.nii.gz -overwrite
3dcalc -a ${wdr_new}/tmp.${ftype}_02cms_res/stats_${medianvol}.nii.gz'[18]' -expr 'a' \
	   -prefix ${wdr_new}/${ftype}_tstat_simple.nii.gz -overwrite
3dcalc -a ${wdr_new}/tmp.${ftype}_02cms_res/fitts_${medianvol}.nii.gz'[17]' -expr '100*(a/71.2)' \
	   -prefix ${wdr_new}/${ftype}_fitts_simple.nii.gz -overwrite
3dcalc -b ${wdr_new}/tmp.${ftype}_02cms_res/stats_${medianvol}.nii.gz[17] -t ${matdir}/mat_${medianvol}.1D[5] \
	   -expr "(100*b*t)/71.2" -prefix ${wdr_new}/${ftype}_fitts_PetCO2_simple.nii.gz -overwrite

# THE FOLLOWING LINES WERE CREATED BY STEFANO IN ORDER TO MOVE THE RESULTS TO A NEW FOLDER.
# WE WILL KEEP ALL THE RESULTS IN ${wdr_new}. HENCE, NO NEED TO CREATE IT AND MOVE FILES.
# if_missing_do mkdir ${wdr_new}/${ftype}_map_cvr
# mv ${wdr_new}/${ftype}_cvr* ${wdr_new}/${ftype}_map_cvr/.
# mv ${wdr_new}/${ftype}_spc* ${wdr_new}/${ftype}_map_cvr/.
# mv ${wdr_new}/${ftype}_tstat* ${wdr_new}/${ftype}_map_cvr/.

# ##### -------------------------- #
# ####                            ##
# ###   Getting T and CVR maps   ###
# ##                            ####
# # -------------------------- #####

cd ${matdir}

echo " Get T score to threshold maps " 
# Read and process any mat there is in the "mat" folder
if [[ -e "mat_0000.1D" ]]; then
	mat=mat_0000.1D
elif [[ -e "mat.1D" ]]; then
	mat=mat.1D
else
 	echo "Can't find any matrix. Abort."; exit
fi

# Extract degrees of freedom (i.e. number of regressors) of design matrix
nreg=$( cat ${mat} | grep ni_type )
nreg=${nreg#*\"}
nreg=${nreg%\**}
ndim=$( cat ${mat} | grep ni_dimen )
ndim=${ndim#*\"}
ndim=${ndim%\"*}
let ndof=ndim-nreg-1

# Get equivalent in t value
tscore=$( cdf -p2t fitt ${pval} ${ndof} )
tscore=${tscore##* }
echo "T-value for p-value ${pval} with df ${ndof} is ${tscore}"

echo "Computing binary mask of statistical significant voxels (positive, negative, and absolute)"
cd ${wdr_new}

# Applying threshold on positive and inverted negative t scores, then adding them together to have absolute tscores.
3dcalc -a ${ftype}_tstat.nii.gz -expr "step(a-${tscore})" -prefix ${ftype}_tstat_pos_mask.nii.gz -overwrite
3dcalc -a ${ftype}_tstat.nii.gz -expr "step(-a-${tscore})" -prefix ${ftype}_tstat_neg_mask.nii.gz -overwrite
3dcalc -a ${ftype}_tstat.nii.gz -expr "astep(a,${tscore})" -prefix ${ftype}_tstat_abs_mask.nii.gz -overwrite

# Apply constriction by physiology (if a voxel didn't peak in range, it might never peak)
# the values of 1 and 59 represent the first and last indexes of the lag range. 
# If the optimal lag occurs in one of them, we assume that the voxel didn't peak in range.
# TODO: make that these values depend on environment variables (e.g. nmodels, poslag, etc).
3dcalc -a ${ftype}_cvr_idx.nii.gz -expr "within(a,1,59)" -prefix ${ftype}_cvr_idx_physio_constrained.nii.gz -overwrite

# Obtaining the mask of good and the mask of bad voxels.
3dcalc -a ${ftype}_cvr_idx_physio_constrained.nii.gz -b ${ftype}_tstat_abs_mask.nii.gz -expr 'a*b' -prefix ${ftype}_cvr_idx_mask.nii.gz -overwrite
3dcalc -a ${mask}.nii.gz -b ${ftype}_cvr_idx_mask.nii.gz -expr 'a-b' -prefix ${ftype}_cvr_idx_bad_vxs_mask.nii.gz -overwrite

# Obtaining corrected lag map where voxels that were identified as bad (${ftype}_cvr_idx_bad_vxs_mask.nii.gz) 
# are given a lag of 0 seconds (i.e. bulk shift is idx = 30) 
3dcalc -a ${ftype}_cvr_idx.nii.gz -b ${ftype}_cvr_idx_mask.nii.gz -m ${mask}.nii.gz \
	-expr 'm*( b*(a-30) + 30)' -prefix ${ftype}_cvr_idx_corrected.nii.gz -overwrite
# now convert to seconds, where the value of 0.025 is because the step of PetCO2 models is 40 Hz
3dcalc -a ${ftype}_cvr_idx_corrected.nii.gz -m ${mask}.nii.gz \
	-expr "(a*${step}-${lag})*m" -prefix ${ftype}_cvr_lag_corrected.nii.gz -overwrite

echo "Getting masked maps"
# Mask Good CVR map, lags and tstats
for map in cvr cvr_lag tstat
do
	echo "Masking ${ftype}_${map} for valid voxels (statistical significant and physiologically valid)"
	3dcalc -a ${ftype}_${map}.nii.gz -m ${ftype}_cvr_idx_mask.nii.gz -expr 'a*m' -prefix ${ftype}_${map}_masked.nii.gz -overwrite
	echo "Masking ${ftype}_${map} for only physiologically valid voxels"
	3dcalc -a ${ftype}_${map}.nii.gz -m ${ftype}_cvr_idx_physio_constrained.nii.gz -expr 'a*m' -prefix ${ftype}_${map}_masked_physio_only.nii.gz -overwrite
done

echo "Getting corrected maps"
# Assign the value of the "simple" CVR and tstat map to the bad voxels to have a complete brain.
3dcalc -a ${ftype}_cvr_masked.nii.gz -b ${ftype}_cvr_simple.nii.gz -m ${ftype}_cvr_idx_bad_vxs_mask.nii.gz \
		-expr 'a + b*m' -prefix ${ftype}_cvr_corrected.nii.gz -overwrite
3dcalc -a ${ftype}_tstat_masked.nii.gz -b ${ftype}_tstat_simple.nii.gz -m ${ftype}_cvr_idx_bad_vxs_mask.nii.gz \
		-expr 'a + b*m' -prefix ${ftype}_tstat_corrected.nii.gz -overwrite

# echo "Deleting all temporary folders for all the models"
# rm -rf tmp.${ftype}_02cms_*

cd ${cwd}

#TODO: We can discuss the following points:
# - Rename the mask of valid voxels as ${ftype}_cvr_idx_good_vxs_mask.nii.gz
# - Assign also the "simple" values (with bulk shift) to the fitts and fits_PetCO2 volumes
