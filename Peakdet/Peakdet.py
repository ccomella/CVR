
#Python Peakdet

import numpy as np
import peakdet as pk
import matplotlib.pyplot as plt

#Sampling Frequency
sampling_rate=125

#my data is in Physio_Bids Folder, use everything in a different folder
sampling_rate=125
data= np.genfromtxt('/bcbl/home/public/CVR/BIPLAS_BIDS/Physio_Bids/sub-9535/ses-01/func/sub-9535_ses-01_task-breathhold_recording-125Hz_physio.tsv.gz') 
phys=pk.Physio(data[:,4], fs=sampling_rate)

#Interpolation

#Filter
#phys = pk.operations.filter_physio(phys, 0.999, 'lowpass', order=1) #Optional
phys = pk.operations.interpolate_physio(phys, 40, kind='linear')
phys = pk.operations.peakfind_physio(phys, thresh=0.5, dist=110)
phys = pk.operations.edit_physio(phys)
pk.plot_physio (phys)
plt.show()


pk.save_physio(f'sub-9535_ses-01_task-breathhold_recording-125Hz_physio_peaks_ch-co2', phys)
sampling_rate=125
data_9474= np.genfromtxt('/bcbl/home/public/CVR/LANGCONN_BIDS/PHYSIO_BIDS/sub-8252/ses-01/func/sub-8252_ses-01_task-breathhold_recording-125Hz_physio.tsv.gz') 
phys_9474= pk.Physio(data_9474[:, 4], fs=125, suppdata=data_9474[:, 3])
phys_9474= pk.operations.interpolate_physio(phys_9474, 40, kind='linear')
phys_9474= pk.operations.peakfind_physio(phys_9474, thresh=0.5, dist=110)
phys_9474= pk.operations.edit_physio(phys_9474) 
pk.plot_physio (phys_9474) 
plt.show() IDS/Physio_Bids/sub-6560/ses-03/func/sub-6560_ses-03_task-breathhold_recording-125Hz_physio.tsv.gz') 
phys_6560= pk.Physio(data_6560[:, 4], fs=125, suppdata=data_6560[:, 3])
phys_6560= pk.operations.interpolate_physio(phys_6560, 40, kind='linear')
phys_6560= pk.operations.peakfind_physio(phys_6560, thresh=0.5, dist=110)
phys_6560= pk.operations.edit_physio(phys_6560)
pk.plot_physio (phys_6560)
plt.show()

pk.save_physio(f'sub-6560_ses-03_task-breathhold_recording-125Hz_physio_peak_ch-co2', phys_6560)

#7939
sampling_rate=125
data_7939= np.genfromtxt('/bcbl/home/public/CVR/BIPLAS_BIDS/Physio_Bids/sub-7939/ses-05/func/sub-7939_ses-05_task-breathhold_recording-125Hz_physio.tsv.gz') 
phys_7939=pk.Physio(data_7939[:,4], fs=sampling_rate)
phys_7939= pk.operations.interpolate_physio(phys_7939, 40, kind='linear')
phys_7939= pk.operations.peakfind_physio(phys_7939, thresh=0.5, dist=110)
phys_7939= pk.operations.edit_physio(phys_7939)
pk.plot_physio (phys_7939)
plt.show()

pk.save_physio(f'sub-7939_ses-05_task-breathhold_recording-125Hz_physio_peaks_ch-co2', phys_7939)

#8838 (CO2 in Channel 5)
sampling_rate=125
data_8838= np.genfromtxt('/bcbl/home/public/CVR/BIPLAS_BIDS/Physio_Bids/sub-8838/ses-04/func/sub-8838_ses-04_task-breathhold_recording-125Hz_physio.tsv.gz') 
phys_8838=pk.Physio(data_8838[:,5], fs=sampling_rate, suppdata=data_8838[:, 3])
phys_8838= pk.operations.interpolate_physio(phys_8838, 40, kind='linear')
phys_8838= pk.operations.peakfind_physio(phys_8838, thresh=0.5, dist=110)
phys_8838= pk.operations.edit_physio(phys_8838)
pk.plot_physio (phys_8838)
plt.show()

pk.save_physio(f'sub-8838_ses-04_task-breathhold_recording-125Hz_physio_peaks_ch-co2', phys_8838)


#9535
sampling_rate=125
data_9535= np.genfromtxt('/bcbl/home/public/CVR/BIPLAS_BIDS/Physio_Bids/sub-9535/ses-01/func/sub-9535_ses-01_task-breathhold_recording-125Hz_physio.tsv.gz') 
phys_9535=pk.Physio(data_9535[:,4], fs=sampling_rate)
phys_9535= pk.operations.interpolate_physio(phys_9535, 40, kind='linear')
phys_9535= pk.operations.peakfind_physio(phys_9535, thresh=0.5, dist=110)
phys_9535= pk.operations.edit_physio(phys_9535)
pk.plot_physio (phys_9535)
plt.show()

pk.save_physio(f'sub-9535_ses-01_task-breathhold_recording-125Hz_physio_peaks_ch-co2', phys_9535)

#10027 (error)
sampling_rate=125
data_10027= np.genfromtxt('/bcbl/home/public/CVR/BIPLAS_BIDS/Physio_Bids/sub-10027/ses-07/func/sub-10027_ses-07_task-breathhold_recording-125Hz_physio.tsv.gz') 
phys_10027=pk.Physio(data_10027[:,4], fs=sampling_rate, suppdata=data_10027[:, 3])
phys_10027= pk.operations.interpolate_physio(phys_10027, 30, kind='linear')
phys_10027= pk.operations.peakfind_physio(phys_10027, thresh=0.5, dist=110)
phys_10027= pk.operations.edit_physio(phys_10027)
pk.plot_physio (phys_10027)
plt.show()

pk.save_physio(f'sub-10506_ses-03_task-breathhold_recording-125Hz_physio_peaks_ch-co2', phys_10027)


#10046
sampling_rate=125
data_10046= np.genfromtxt('/bcbl/home/public/CVR/BIPLAS_BIDS/Physio_Bids/sub-10046/ses-04/func/sub-10046_ses-04_task-breathhold_recording-125Hz_physio.tsv.gz') 
phys_10046=pk.Physio(data_10046[:,4], fs=sampling_rate)
phys_10046= pk.operations.interpolate_physio(phys_10046, 40, kind='linear')
phys_10046= pk.operations.peakfind_physio(phys_10046, thresh=0.5, dist=110)
phys_10046= pk.operations.edit_physio(phys_10046)
pk.plot_physio (phys_10046)
plt.show()
pk.save_physio(f'sub-10046_ses-04_task-breathhold_recording-125Hz_physio_peaks_ch-co2', phys_10046)

#10124 (
sampling_rate=125
data_10124= np.genfromtxt('/bcbl/home/public/CVR/BIPLAS_BIDS/Physio_Bids/sub-10124/ses-06/func/sub-10124_ses-06_task-breathhold_recording-125Hz_physio.tsv.gz') 
phys_10124=pk.Physio(data_10124[:,4], fs=sampling_rate, suppdata=data_10124[:, 3])
phys_10124= pk.operations.interpolate_physio(phys_10124, 30, kind='linear')
phys_10124= pk.operations.peakfind_physio(phys_10124, thresh=0.5, dist=110)
phys_10124= pk.operations.edit_physio(phys_10124)
pk.plot_physio (phys_10124)
plt.show()

pk.save_physio(f'sub-10124_ses-06_task-breathhold_recording-125Hz_physio_peaks_ch-co2', phys_10124)
#10324
sampling_rate=125
data_10324= np.genfromtxt('/bcbl/home/public/CVR/BIPLAS_BIDS/Physio_Bids/sub-10324/ses-07/func/sub-10324_ses-07_task-breathhold_recording-125Hz_physio.tsv.gz') 
phys_10324=pk.Physio(data_10324[:,4], fs=sampling_rate)
phys_10324= pk.operations.interpolate_physio(phys_10324, 40, kind='linear')
phys_10324= pk.operations.peakfind_physio(phys_10324, thresh=0.5, dist=110)
phys_10324= pk.operations.edit_physio(phys_10324)
pk.plot_physio (phys_10324)
plt.show()
pk.save_physio(f'sub-10324_ses-07_task-breathhold_recording-125Hz_physio_peaks_ch-co2', phys_10324)

#10487
sampling_rate=125
data_10487= np.genfromtxt('/bcbl/home/public/CVR/BIPLAS_BIDS/Physio_Bids/sub-10487/ses-010/func/sub-10487_ses-010_task-breathhold_recording-125Hz_physio.tsv.gz') 
phys_10487= pk.Physio(data_10487[:, 4], fs=125, suppdata=data_10487[:, 3])
phys_10487= pk.operations.interpolate_physio(phys_10487, 40, kind='linear')
phys_10487= pk.operations.peakfind_physio(phys_10487, thresh=0.5, dist=110)
phys_10487= pk.operations.edit_physio(phys_10487)
pk.plot_physio (phys_10487)
plt.show()

k.save_physio(f'sub-10487_ses-010_task-breathhold_recording-125Hz_physio_peaks_ch-co2', phys_10487)


#10499
sampling_rate=125
data_10499= np.genfromtxt('/bcbl/home/public/CVR/BIPLAS_BIDS/Physio_Bids/sub-10499/ses-09/func/sub-10499_ses-09_task-breathhold_recording-125Hz_physio.tsv.gz') 
phys_10499= pk.Physio(data_10499[:, 4], fs=125, suppdata=data_10499[:, 3])
phys_10499= pk.operations.interpolate_physio(phys_10499, 40, kind='linear')
phys_10499= pk.operations.peakfind_physio(phys_10499, thresh=0.5, dist=110)
phys_10499= pk.operations.edit_physio(phys_10499)
pk.plot_physio (phys_10499)
plt.show()
pk.save_physio(f'sub-10499_ses-09_task-breathhold_recording-125Hz_physio_peaks_ch-co2', phys_10499)


#10501
sampling_rate=125
data_10501= np.genfromtxt('/bcbl/home/public/CVR/BIPLAS_BIDS/Physio_Bids/sub-10501/ses-06/func/sub-10501_ses-06_task-breathhold_recording-125Hz_physio.tsv.gz') 
phys_10501= pk.Physio(data_10501[:, 4], fs=125, suppdata=data_10501[:, 3])
phys_10501= pk.operations.interpolate_physio(phys_10501, 40, kind='linear')
phys_10501= pk.operations.peakfind_physio(phys_10501, thresh=0.5, dist=110)
phys_10501= pk.operations.edit_physio(phys_10501)
pk.plot_physio (phys_10501)
plt.show()
pk.save_physio(f'sub-10501_ses-06_task-breathhold_recording-125Hz_physio_peaks_ch-co2', phys_10501)


#10506
sampling_rate=125
data_10506= np.genfromtxt('/bcbl/home/public/CVR/BIPLAS_BIDS/Physio_Bids/sub-10506/ses-03/func/sub-10506_ses-03_task-breathhold_recording-125Hz_physio.tsv.gz') 
phys_10506=pk.Physio(data_10506[:,4], fs=sampling_rate)
phys_10506= pk.operations.interpolate_physio(phys_10506, 40, kind='linear')
phys_10506= pk.operations.peakfind_physio(phys_10506, thresh=0.5, dist=110)
phys_10506= pk.operations.edit_physio(phys_10506)
pk.plot_physio (phys_10506)
plt.show()
pk.save_physio(f'sub-10506_ses-03_task-breathhold_recording-125Hz_physio_peaks_ch-co2', phys_10506)

#10512
sampling_rate=125
data_10512= np.genfromtxt('/bcbl/home/public/CVR/BIPLAS_BIDS/Physio_Bids/sub-10512/ses-012/func/sub-10512_ses-012_task-breathhold_recording-125Hz_physio.tsv.gz') 
phys_10512=pk.Physio(data_10512[:,4], fs=sampling_rate, suppdata=data_10512[:, 3])
phys_10512= pk.operations.interpolate_physio(phys_10512, 40, kind='linear')
phys_10512= pk.operations.peakfind_physio(phys_10512, thresh=0.5, dist=110)
phys_10512= pk.operations.edit_physio(phys_10512)
pk.plot_physio (phys_10512)
plt.show()
pk.save_physio(f'sub-10512_ses-012_task-breathhold_recording-125Hz_physio_peaks_ch-co2', phys_10512)

#10517
sampling_rate=125
data_10517= np.genfromtxt('/bcbl/home/public/CVR/BIPLAS_BIDS/Physio_Bids/sub-10517/ses-013/func/sub-10517_ses-013_task-breathhold_recording-125Hz_physio.tsv.gz') 
phys_10517=pk.Physio(data_10517[:,4], fs=sampling_rate, suppdata=data_10517[:, 3])
phys_10517= pk.operations.interpolate_physio(phys_10517, 40, kind='linear')
phys_10517= pk.operations.peakfind_physio(phys_10517, thresh=0.5, dist=110)
phys_10517= pk.operations.edit_physio(phys_10517)
pk.plot_physio (phys_10517)
plt.show()
pk.save_physio(f'sub-10517_ses-013_task-breathhold_recording-125Hz_physio_peaks_ch-co2', phys_10517)

#10522
sampling_rate=125
data_10522= np.genfromtxt('/bcbl/home/public/CVR/BIPLAS_BIDS/Physio_Bids/sub-10522/ses-08/func/sub-10522_ses-08_task-breathhold_recording-125Hz_physio.tsv.gz') 
phys_10522=pk.Physio(data_10522[:,4], fs=sampling_rate, suppdata=data_10522[:, 3])
phys_10522= pk.operations.interpolate_physio(phys_10522, 40, kind='linear')
phys_10522= pk.operations.peakfind_physio(phys_10522, thresh=0.5, dist=110)
phys_10522= pk.operations.edit_physio(phys_10522)
pk.plot_physio (phys_10522)
plt.show()
pk.save_physio(f'sub-10522_ses-08_task-breathhold_recording-125Hz_physio_peaks_ch-co2', phys_10522)

#10523
sampling_rate=125
data_10523= np.genfromtxt('/bcbl/home/public/CVR/BIPLAS_BIDS/Physio_Bids/sub-10523/ses-01/func/sub-10523_ses-01_task-breathhold_recording-125Hz_physio.tsv.gz') 
phys_10523=pk.Physio(data_10523[:,4], fs=sampling_rate, suppdata=data_10523[:, 3])
phys_10523= pk.operations.interpolate_physio(phys_10523, 40, kind='linear')
phys_10523= pk.operations.peakfind_physio(phys_10523, thresh=0.5, dist=110)
phys_10523= pk.operations.edit_physio(phys_10523)
pk.plot_physio (phys_10523)
plt.show()
pk.save_physio(f'sub-10523_ses-01_task-breathhold_recording-125Hz_physio_peaks_ch-co2', phys_10523)

#10533
sampling_rate=125
data_10533= np.genfromtxt('/bcbl/home/public/CVR/BIPLAS_BIDS/Physio_Bids/sub-10533/ses-02/func/sub-10533_ses-02_task-breathhold_recording-125Hz_physio.tsv.gz') 
phys_10533=pk.Physio(data_10533[:,4], fs=sampling_rate, suppdata=data_10533[:, 3])
phys_10533= pk.operations.interpolate_physio(phys_10533, 40, kind='linear')
phys_10533= pk.operations.peakfind_physio(phys_10533, thresh=0.5, dist=110)
phys_10533= pk.operations.edit_physio(phys_10533)
pk.plot_physio (phys_10533)
plt.show()
pk.save_physio(f'sub-10533_ses-02_task-breathhold_recording-125Hz_physio_peaks_ch-co2', phys_10533)

#10566
sampling_rate=125
data_10566= np.genfromtxt('/bcbl/home/public/CVR/BIPLAS_BIDS/Physio_Bids/sub-10566/ses-05/func/sub-10566_ses-05_task-breathhold_recording-125Hz_physio.tsv.gz') 
phys_10566=pk.Physio(data_10566[:,4], fs=sampling_rate, suppdata=data_10566[:, 3])
phys_10566= pk.operations.interpolate_physio(phys_10566, 40, kind='linear')
phys_10566= pk.operations.peakfind_physio(phys_10566, thresh=0.5, dist=110)
phys_10566= pk.operations.edit_physio(phys_10566)
pk.plot_physio (phys_10566)
plt.show()
pk.save_physio(f'sub-10566_ses-05_task-breathhold_recording-125Hz_physio_peaks_ch-co2', phys_10566)

#10573 (need to consult)
sampling_rate=125
data_10573= np.genfromtxt('/bcbl/home/public/CVR/BIPLAS_BIDS/Physio_Bids/sub-10573/ses-011/func/sub-10573_ses-011_task-breathhold_recording-125Hz_physio.tsv.gz') 
phys_10573=pk.Physio(data_10573[:,5], fs=sampling_rate, suppdata=data_10573[:, 3])
phys_10573= pk.operations.interpolate_physio(phys_10573, 40, kind='linear')
phys_10573= pk.operations.peakfind_physio(phys_10573, thresh=0.5, dist=110)
phys_10573= pk.operations.edit_physio(phys_10573)
pk.plot_physio (phys_10573)
plt.show()
pk.save_physio(f'sub-10573_ses-011_task-breathhold_recording-125Hz_physio_peaks_ch-co2', phys_10573)

#10609 (CO2 in channel 5)
sampling_rate=125
data_10609= np.genfromtxt('/bcbl/home/public/CVR/BIPLAS_BIDS/Physio_Bids/sub-10609/ses-014/func/sub-10609_ses-014_task-breathhold_recording-125Hz_physio.tsv.gz') 
phys_10609=pk.Physio(data_10609[:,5], fs=sampling_rate, suppdata=data_10609[:, 3])
phys_10609= pk.operations.interpolate_physio(phys_10609, 40, kind='linear')
phys_10609= pk.operations.peakfind_physio(phys_10609, thresh=0.5, dist=110)
phys_10609= pk.operations.edit_physio(phys_10609)
pk.plot_physio (phys_10609)
plt.show()

pk.save_physio(f'sub-10609_ses-014_task-breathhold_recording-125Hz_physio_peaks_ch-co2', phys_10609)

#10610
sampling_rate=125
data_10610= np.genfromtxt('/bcbl/home/public/CVR/BIPLAS_BIDS/Physio_Bids/sub-10610/ses-016/func/sub-10610_ses-016_task-breathhold_recording-125Hz_physio.tsv.gz') 
phys_10610=pk.Physio(data_10610[:,4], fs=sampling_rate, suppdata=data_10610[:, 3])
phys_10610= pk.operations.interpolate_physio(phys_10610, 40, kind='linear')
phys_10610= pk.operations.peakfind_physio(phys_10610, thresh=0.5, dist=110)
phys_10610= pk.operations.edit_physio(phys_10610)
pk.plot_physio (phys_10610)
plt.show()

pk.save_physio(f'sub-10610_ses-016_task-breathhold_recording-125Hz_physio_peaks_ch-co2', phys_10610)

#10613
sampling_rate=125
data_10613= np.genfromtxt('/bcbl/home/public/CVR/BIPLAS_BIDS/Physio_Bids/sub-10613/ses-015/func/sub-10613_ses-015_task-breathhold_recording-125Hz_physio.tsv.gz') 
phys_10613=pk.Physio(data_10613[:,4], fs=sampling_rate, suppdata=data_10613[:, 3])
phys_10613= pk.operations.interpolate_physio(phys_10613, 40, kind='linear')
phys_10613= pk.operations.peakfind_physio(phys_10613, thresh=0.5, dist=110)
phys_10613= pk.operations.edit_physio(phys_10613)
pk.plot_physio (phys_10613)
plt.show()

pk.save_physio(f'sub-10613_ses-015_task-breathhold_recording-125Hz_physio_peaks_ch-co2', phys_10613)

#Ver Respiratory, in Channel 3
#7939
sampling_rate=125
data_7939= np.genfromtxt('/bcbl/home/public/CVR/BIPLAS_BIDS/Physio_Bids/sub-7939/ses-05/func/sub-7939_ses-05_task-breathhold_recording-125Hz_physio.tsv.gz') 
phys_7939=pk.Physio(data_7939[:,3], fs=sampling_rate)
phys_7939= pk.operations.interpolate_physio(phys_7939, 40, kind='linear')
phys_7939= pk.operations.peakfind_physio(phys_7939, thresh=0.5, dist=110)
phys_7939= pk.operations.edit_physio(phys_7939)
pk.plot_physio (phys_7939)
plt.show()
#10324

sampling_rate=125
data_10324= np.genfromtxt('/bcbl/home/public/CVR/BIPLAS_BIDS/Physio_Bids/sub-10324/ses-07/func/sub-10324_ses-07_task-breathhold_recording-125Hz_physio.tsv.gz') 
phys_10324=pk.Physio(data_10324[:,3], fs=sampling_rate)
phys_10324= pk.operations.interpolate_physio(phys_10324, 40, kind='linear')
phys_10324= pk.operations.peakfind_physio(phys_10324, thresh=0.5, dist=110)
phys_10324= pk.operations.edit_physio(phys_10324)
pk.plot_physio (phys_10324)
plt.show()

#9535
sampling_rate=125
data_9535= np.genfromtxt('/bcbl/home/public/CVR/BIPLAS_BIDS/Physio_Bids/sub-9535/ses-01/func/sub-9535_ses-01_task-breathhold_recording-125Hz_physio.tsv.gz') 
phys_9535=pk.Physio(data_9535[:,3], fs=sampling_rate)
phys_9535= pk.operations.interpolate_physio(phys_9535, 40, kind='linear')
phys_9535= pk.operations.peakfind_physio(phys_9535, thresh=0.5, dist=110)
phys_9535= pk.operations.edit_physio(phys_9535)
pk.plot_physio


#LANGCONN 1
sampling_rate=125
data_L_8808= np.genfromtxt('/bcbl/home/public/CVR/LANGCONN_BIDS/PHYSIO_BIDS/sub-8808/ses-032/func/sub-8808_ses-032_task-breathhold_recording-125Hz_physio.tsv.gz') 
phys_L_8808=pk.Physio(data_L_8808[:,4], fs=sampling_rate, suppdata=data_L_8808[:, 3])
phys_L_8808= pk.operations.interpolate_physio(phys_L_8808, 40, kind='linear')
phys_L_8808= pk.operations.peakfind_physio(phys_L_8808, thresh=0.5, dist=110)
phys_L_8808= pk.operations.edit_physio(phys_L_8808)
pk.plot_physio (phys_L_8808)
plt.show()


