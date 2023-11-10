
module load afni/latest
module load fsl/6.0.3
sub=046
ses=1
ftype=meica_cons
wdr_new="/bcbl/home/public/CVR/PRESURGICAL_BIDS/sub-${sub}/ses-${ses}/func_preproc/AFNI_${ftype}"
matdir="${wdr_new}/mat"

maxidx=($( fslstats ${wdr_new}/${ftype}_cvr_idx.nii.gz -R )) # this could be converted to AFNI 3dROIstats -minmax
# 3dROIstats -minmax -nomeanout -quiet -mask ${mask}.nii.gz ${wdr_new}/${ftype}_cvr_idx.nii.gzecho

maxidx=(`echo $maxidx | awk '{print $1}'` `echo $maxidx | awk '{print $2}'`) #normalmente esto no se debería de necesitar

for i in $(seq -f %g 0 ${maxidx[1]})
do
	(( v=i*step_idx ))
	v=$( printf %04d $v )
	echo "iteration $i out of ${maxidx[1]}"
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
