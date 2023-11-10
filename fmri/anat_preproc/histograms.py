## Create histograms

import nibabel as nib
import numpy as np
import matplotlib.pyplot as plt

#Load the nifti volumes
data_img = nib.load('/bcbl/home/public/CVR/PRESURGICAL_BIDS/sub-064/ses-1/func_preproc/phys2cvr_cons_nontumor_mask/verwrite/sub-064_ses-1_task-BH_run-1_optcom_bold_sm_cvr_scaled.nii.gz')
mask_img = nib.load('/bcbl/home/public/CVR/PRESURGICAL_BIDS/sub-064/ses-1/anat_preproc/GM_mask.nii')

#Extract the data and mask array
data = data_img.get_fdata()
mask = mask_img.get_fdata()

# Create a list of unique values in the mask array
unique_values = np.unique(mask)

#For each unique values in the mask array
for value in unique_values:
    data_masked = data[mask == value]
    hist, bins = np.histogram(data_masked, bins = 50)

    # Plot the histogram using matplotlib
    plt.hist(data_masked, bins=bins, alpha=0.5, label="Mask value: {}".format(value))

#show plot
plt.legend()
plt.show ()