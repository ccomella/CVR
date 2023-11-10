#Peakdet Langconn

import numpy as np
import peakdet as pk
import matplotlib.pyplot as plt

#312
sampling_rate=125
data_312= np.genfromtxt('/bcbl/home/public/CVR/LANGCONN_BIDS/PHYSIO_BIDS/sub-312/ses-01/func/sub-312_ses-01_task-breathhold_recording-125Hz_physio.tsv.gz') 
phys_312= pk.Physio(data_312[:, 4], fs=125, suppdata=data_312[:, 3])
phys_312= pk.operations.interpolate_physio(phys_312, 40, kind='linear')
phys_312= pk.operations.peakfind_physio(phys_312, thresh=0.5, dist=110)
phys_312= pk.operations.edit_physio(phys_312)
pk.plot_physio (phys_312)
plt.show()

pk.save_physio(f'sub-312_ses-ses+1_task-breathhold_recording-125Hz_physio_peak_ch-co2', phys_312)

#449
sampling_rate=125
data_449= np.genfromtxt('/bcbl/home/public/CVR/LANGCONN_BIDS/PHYSIO_BIDS/sub-449/ses-ses+1/func/sub-449_ses-ses+1_task-breathhold_recording-125Hz_physio.tsv.gz') 
phys_449= pk.Physio(data_449[:, 4], fs=125, suppdata=data_449[:, 3])
phys_449= pk.operations.interpolate_physio(phys_449, 40, kind='linear')
phys_449= pk.operations.peakfind_physio(phys_449, thresh=0.5, dist=110)
phys_449= pk.operations.edit_physio(phys_449)
pk.plot_physio (phys_449)
plt.show()

pk.save_physio(f'sub-449_ses-ses+1_task-breathhold_recording-125Hz_physio_peak_ch-co2', phys_449)

#8420
sampling_rate=125
data_8420= np.genfromtxt('/bcbl/home/public/CVR/LANGCONN_BIDS/PHYSIO_BIDS/sub-8420/ses-01/func/sub-8420_ses-01_task-breathhold_recording-125Hz_physio.tsv.gz') 
phys_8420= pk.Physio(data_8420[:, 4], fs=125, suppdata=data_8420[:, 3])
phys_8420= pk.operations.interpolate_physio(phys_8420, 40, kind='linear')
phys_8420= pk.operations.peakfind_physio(phys_8420, thresh=0.5, dist=110)
phys_8420= pk.operations.edit_physio(phys_8420)
pk.plot_physio (phys_8420)
plt.show()
pk.save_physio(f'sub-8420_ses-01_task-breathhold_recording-125Hz_physio_peak_ch-co2', phys_8420)

data_8420=pk.load_physio('sub-8420_ses-01_task-breathhold_recording-125Hz_physio_peak_ch-co2.phys', allow_pickle=True)
data_8420= pk.operations.edit_physio(data_8420)
pk.plot_physio (data_8420)
plt.show()
pk.save_physio(f'sub-8420_ses-01_task-breathhold_recording-125Hz_physio_peak_ch-co2', data_8420)

#6720
sampling_rate=125
data_6720= np.genfromtxt('/bcbl/home/public/CVR/LANGCONN_BIDS/PHYSIO_BIDS/sub-6729/ses-01/func/sub-6729_ses-01_task-breathhold_recording-125Hz_physio.tsv.gz') 
phys_6720= pk.Physio(data_6720[:, 4], fs=125, suppdata=data_6720[:, 3])
phys_6720= pk.operations.interpolate_physio(phys_6720, 40, kind='linear')
phys_6720= pk.operations.peakfind_physio(phys_6720, thresh=0.5, dist=110)
phys_6720= pk.operations.edit_physio(phys_6720) 
pk.plot_physio (phys_6720) 
plt.show() 

pk.save_physio(f'sub-6729_ses-01_task-breathhold_recording-125Hz_physio_peak_ch-co2', phys_6720)

#9378
sampling_rate=125
data_9378= np.genfromtxt('/bcbl/home/public/CVR/LANGCONN_BIDS/PHYSIO_BIDS/sub-9378/ses-01/func/sub-9378_ses-01_task-breathhold_recording-125Hz_physio.tsv.gz') 
phys_9378= pk.Physio(data_9378[:, 4], fs=125, suppdata=data_9378[:, 3])
phys_9378= pk.operations.interpolate_physio(phys_9378, 40, kind='linear')
phys_9378= pk.operations.peakfind_physio(phys_9378, thresh=0.5, dist=110)
phys_9378= pk.operations.edit_physio(phys_9378) 
pk.plot_physio (phys_9378) 
plt.show() 


pk.save_physio(f'sub-9378_ses-01_task-breathhold_recording-125Hz_physio_peak_ch-co2', phys_9378)

#5127
sampling_rate=125
data_5127= np.genfromtxt('/bcbl/home/public/CVR/LANGCONN_BIDS/PHYSIO_BIDS/sub-5127/ses-01/func/sub-5127_ses-01_task-breathhold_recording-125Hz_physio.tsv.gz') 
phys_5127= pk.Physio(data_5127[:, 4], fs=125, suppdata=data_5127[:, 3])
phys_5127= pk.operations.interpolate_physio(phys_5127, 40, kind='linear')
phys_5127= pk.operations.peakfind_physio(phys_5127, thresh=0.5, dist=110)
phys_5127= pk.operations.edit_physio(phys_5127) 
pk.plot_physio (phys_5127) 
plt.show() 

pk.save_physio(f'sub-5127_ses-01_task-breathhold_recording-125Hz_physio_peak_ch-co2', phys_5127)

#8252
sampling_rate=125
data_8252= np.genfromtxt('/bcbl/home/public/CVR/LANGCONN_BIDS/PHYSIO_BIDS/sub-8252/ses-01/func/sub-8252_ses-01_task-breathhold_recording-125Hz_physio.tsv.gz') 
data_8252= pk.Physio(data_8252[:, 4], fs=125, suppdata=data_8252[:, 3])
data_8252= pk.operations.interpolate_physio(data_8252, 40, kind='linear')
data_8252= pk.operations.peakfind_physio(data_8252, thresh=0.5, dist=110)
data_8252= pk.operations.edit_physio(data_8252) 
pk.plot_physio (data_8252) 
plt.show() 

pk.save_physio(f'sub-8252_ses-01_task-breathhold_recording-125Hz_physio_peak_ch-co2', data_8252)

#9474
sampling_rate=125
data_9474= np.genfromtxt('/bcbl/home/public/CVR/LANGCONN_BIDS/PHYSIO_BIDS/sub-9474/ses-01/func/sub-9474_ses-01_task-breathhold_recording-125Hz_physio.tsv.gz') 
phys_9474= pk.Physio(data_9474[:, 4], fs=125, suppdata=data_9474[:, 3])
phys_9474= pk.operations.interpolate_physio(phys_9474, 40, kind='linear')
phys_9474= pk.operations.peakfind_physio(phys_9474, thresh=0.5, dist=110)
phys_9474= pk.operations.edit_physio(phys_9474) 
pk.plot_physio (phys_9474) 
plt.show() 


pk.save_physio(f'sub-9474_ses-01_task-breathhold_recording-125Hz_physio_peak_ch-co2', phys_9474)

#6226
sampling_rate=125
data_6226= np.genfromtxt('/bcbl/home/public/CVR/LANGCONN_BIDS/PHYSIO_BIDS/sub-6226/ses-01/func/sub-6226_ses-01_task-breathhold_recording-125Hz_physio.tsv.gz') 
phys_6226= pk.Physio(data_6226[:, 4], fs=125, suppdata=data_6226[:, 3])
phys_6226= pk.operations.interpolate_physio(phys_6226, 40, kind='linear')
phys_6226= pk.operations.peakfind_physio(phys_6226, thresh=0.75, dist=110)
phys_6226= pk.operations.edit_physio(phys_6226) 
pk.plot_physio (phys_6226) 
plt.show() 

pk.save_physio(f'sub-6226_ses-01_task-breathhold_recording-125Hz_physio_peak_ch-co2', phys_6226)

#496
sampling_rate=125
data_496= np.genfromtxt('/bcbl/home/public/CVR/LANGCONN_BIDS/PHYSIO_BIDS/sub-496/ses-01/func/sub-496_ses-01_task-breathhold_recording-125Hz_physio.tsv.gz') 
phys_496= pk.Physio(data_496[:, 4], fs=125, suppdata=data_496[:, 3])
phys_496= pk.operations.interpolate_physio(phys_496, 40, kind='linear')
phys_496= pk.operations.peakfind_physio(phys_496, thresh=0.75, dist=110)
phys_496= pk.operations.edit_physio(phys_496) 
pk.plot_physio (phys_496) 
plt.show() 

pk.save_physio(f'sub-496_ses-01_task-breathhold_recording-125Hz_physio_peak_ch-co2', phys_496)

data_496=pk.load_physio('sub-496_ses-01_task-breathhold_recording-125Hz_physio_peak_ch-co2.phys', allow_pickle=True)
data_496= pk.operations.edit_physio(data_496)
pk.plot_physio (data_496)
plt.show()
pk.save_physio(f'sub-496_ses-01_task-breathhold_recording-125Hz_physio_peak_ch-co2', data_496)

#9330
sampling_rate=125
data_9330= np.genfromtxt('/bcbl/home/public/CVR/LANGCONN_BIDS/PHYSIO_BIDS/sub-9330/ses-01/func/sub-9330_ses-01_task-breathhold_recording-125Hz_physio.tsv.gz') 
phys_9330= pk.Physio(data_9330[:, 4], fs=125, suppdata=data_9330[:, 3])
phys_9330= pk.operations.interpolate_physio(phys_9330, 40, kind='linear')
phys_9330= pk.operations.peakfind_physio(phys_9330, thresh=0.75, dist=110)
phys_9330= pk.operations.edit_physio(phys_9330) 
pk.plot_physio (phys_9330) 
plt.show() 

pk.save_physio(f'sub-9330_ses-01_task-breathhold_recording-125Hz_physio_peak_ch-co2', phys_9330)


data_9330=pk.load_physio('sub-9330_ses-01_task-breathhold_recording-125Hz_physio_peak_ch-co2.phys', allow_pickle=True)
data_9330= pk.operations.edit_physio(data_9330)
pk.plot_physio (data_9330)
plt.show()
pk.save_physio(f'sub-9330_ses-01_task-breathhold_recording-125Hz_physio_peak_ch-co2', data_9330)

#3061
sampling_rate=125
data_3061= np.genfromtxt('/bcbl/home/public/CVR/LANGCONN_BIDS/PHYSIO_BIDS/sub-3061/ses-01/func/sub-3061_ses-01_task-breathhold_recording-125Hz_physio.tsv.gz') 
phys_3061= pk.Physio(data_3061[:, 4], fs=125, suppdata=data_3061[:, 3])
phys_3061= pk.operations.interpolate_physio(phys_3061, 40, kind='linear')
phys_3061= pk.operations.peakfind_physio(phys_3061, thresh=0.75, dist=110)
phys_3061= pk.operations.edit_physio(phys_3061) 
pk.plot_physio (phys_3061) 
plt.show() 

pk.save_physio(f'sub-3061_ses-01_task-breathhold_recording-125Hz_physio_peak_ch-co2', phys_3061)

#7636
sampling_rate=125
data_7636= np.genfromtxt('/bcbl/home/public/CVR/LANGCONN_BIDS/PHYSIO_BIDS/sub-7636/ses-01/func/sub-7636_ses-01_task-breathhold_recording-125Hz_physio.tsv.gz') 
phys_7636= pk.Physio(data_7636[:, 4], fs=125, suppdata=data_7636[:, 3])
phys_7636= pk.operations.interpolate_physio(phys_7636, 40, kind='linear')
phys_7636= pk.operations.peakfind_physio(phys_7636, thresh=0.75, dist=110)
phys_7636= pk.operations.edit_physio(phys_7636) 
pk.plot_physio (phys_7636) 
plt.show() 


pk.save_physio(f'sub-7636_ses-01_task-breathhold_recording-125Hz_physio_peak_ch-co2', phys_7636)

#449
sampling_rate=125
data_449= np.genfromtxt('/bcbl/home/public/CVR/LANGCONN_BIDS/PHYSIO_BIDS/sub-449/ses-01/func/sub-449_ses-01_task-breathhold_recording-125Hz_physio.tsv.gz') 
phys_449= pk.Physio(data_449[:, 4], fs=125, suppdata=data_449[:, 3])
phys_449= pk.operations.interpolate_physio(phys_449, 40, kind='linear')
phys_449= pk.operations.peakfind_physio(phys_449, thresh=0.75, dist=110)
phys_449= pk.operations.edit_physio(phys_449) 
pk.plot_physio (phys_449) 
plt.show() 

pk.save_physio(f'sub-449_ses-01_task-breathhold_recording-125Hz_physio_peak_ch-co2', phys_449)

#9696
sampling_rate=125
data_9696= np.genfromtxt('/bcbl/home/public/CVR/LANGCONN_BIDS/PHYSIO_BIDS/sub-9696/ses-01/func/sub-9696_ses-01_task-breathhold_recording-125Hz_physio.tsv.gz') 
phys_9696= pk.Physio(data_9696[:, 4], fs=125, suppdata=data_9696[:, 3])
phys_9696= pk.operations.interpolate_physio(phys_9696, 40, kind='linear')
phys_9696= pk.operations.peakfind_physio(phys_9696, thresh=0.75, dist=110)
phys_9696= pk.operations.edit_physio(phys_9696) 
pk.plot_physio (phys_9696) 
plt.show() 

pk.save_physio(f'sub-9696_ses-01_task-breathhold_recording-125Hz_physio_peak_ch-co2', phys_9696)

#238
sampling_rate=125
data_238= np.genfromtxt('/bcbl/home/public/CVR/LANGCONN_BIDS/PHYSIO_BIDS/sub-238/ses-01/func/sub-238_ses-01_task-breathhold_recording-125Hz_physio.tsv.gz') 
phys_238= pk.Physio(data_238[:, 4], fs=125, suppdata=data_238[:, 3])
phys_238= pk.operations.interpolate_physio(phys_238, 40, kind='linear')
phys_238= pk.operations.peakfind_physio(phys_238, thresh=0.75, dist=110)
phys_238= pk.operations.edit_physio(phys_238) 
pk.plot_physio (phys_238) 
plt.show() 

pk.save_physio(f'sub-238_ses-01_task-breathhold_recording-125Hz_physio_peak_ch-co2', phys_238)

#2037
sampling_rate=125
data_2037= np.genfromtxt('/bcbl/home/public/CVR/LANGCONN_BIDS/PHYSIO_BIDS/sub-2037/ses-01/func/sub-2037_ses-01_task-breathhold_recording-125Hz_physio.tsv.gz') 
phys_2037= pk.Physio(data_2037[:, 4], fs=125, suppdata=data_2037[:, 3])
phys_2037= pk.operations.interpolate_physio(phys_2037, 40, kind='linear')
phys_2037= pk.operations.peakfind_physio(phys_2037, thresh=0.75, dist=110)
phys_2037= pk.operations.edit_physio(phys_2037) 
pk.plot_physio (phys_2037) 
plt.show() 

pk.save_physio(f'sub-2037_ses-01_task-breathhold_recording-125Hz_physio_peak_ch-co2', phys_2037)

#8812
sampling_rate=125
data_8812= np.genfromtxt('/bcbl/home/public/CVR/LANGCONN_BIDS/PHYSIO_BIDS/sub-8812/ses-01/func/sub-8812_ses-01_task-breathhold_recording-125Hz_physio.tsv.gz') 
phys_8812= pk.Physio(data_8812[:, 4], fs=125, suppdata=data_8812[:, 3])
phys_8812= pk.operations.interpolate_physio(phys_8812, 40, kind='linear')
phys_8812= pk.operations.peakfind_physio(phys_8812, thresh=0.75, dist=110)
phys_8812= pk.operations.edit_physio(phys_8812) 
pk.plot_physio (phys_8812) 
plt.show() 

pk.save_physio(f'sub-8812_ses-01_task-breathhold_recording-125Hz_physio_peak_ch_co2', phys_8812)

data_8812=pk.load_physio('sub-8812_ses-01_task-breathhold_recording-125Hz_physio_peak_ch_co2.phys', allow_pickle=True)
data_8812= pk.operations.edit_physio(data_8812)
pk.plot_physio (data_8812)
plt.show()
pk.save_physio(f'sub-8812_ses-01_task-breathhold_recording-125Hz_physio_peak_ch_co2', data_8812)

#3181
sampling_rate=125
data_3181= np.genfromtxt('/bcbl/home/public/CVR/LANGCONN_BIDS/PHYSIO_BIDS/sub-3181/ses-01/func/sub-3181_ses-01_task-breathhold_recording-125Hz_physio.tsv.gz') 
phys_3181= pk.Physio(data_3181[:, 4], fs=125, suppdata=data_3181[:, 3])
phys_3181= pk.operations.interpolate_physio(phys_3181, 40, kind='linear')
phys_3181= pk.operations.peakfind_physio(phys_3181, thresh=0.75, dist=110)
phys_3181= pk.operations.edit_physio(phys_3181) 
pk.plot_physio (phys_3181) 
plt.show() 

pk.save_physio(f'sub-3181_ses-01_task-breathhold_recording-125Hz_physio_peak_ch_co2', phys_3181)

#Irene
sampling_rate=125
data_IRENE= np.genfromtxt('/bcbl/home/public/CVR/LANGCONN_BIDS/PHYSIO_BIDS/sub-IRENE/ses-01/func/sub-IRENE_ses-01_task-breathhold_recording-125Hz_physio.tsv.gz') 
phys_IRENE= pk.Physio(data_IRENE[:, 4], fs=125, suppdata=data_IRENE[:, 3])
phys_IRENE= pk.operations.interpolate_physio(phys_IRENE, 40, kind='linear')
phys_IRENE= pk.operations.peakfind_physio(phys_IRENE, thresh=0.75, dist=110)
phys_IRENE= pk.operations.edit_physio(phys_IRENE) 
pk.plot_physio (phys_IRENE) 
plt.show() 

pk.save_physio(f'sub-IRENE_ses-01_task-breathhold_recording-125Hz_physio_peak_ch_co2', phys_IRENE)

#9322
sampling_rate=125
data_9322= np.genfromtxt('/bcbl/home/public/CVR/LANGCONN_BIDS/PHYSIO_BIDS/sub-9322/ses-01/func/sub-9322_ses-01_task-breathhold_recording-125Hz_physio.tsv.gz') 
phys_9322= pk.Physio(data_9322[:, 4], fs=125, suppdata=data_9322[:, 3])
phys_9322= pk.operations.interpolate_physio(phys_9322, 40, kind='linear')
phys_9322= pk.operations.peakfind_physio(phys_9322, thresh=0.75, dist=110)
phys_9322= pk.operations.edit_physio(phys_9322) 
pk.plot_physio (phys_9322) 
plt.show() 

pk.save_physio(f'sub-9322_ses-01_task-breathhold_recording-125Hz_physio_peak_ch_co2', phys_9322)

#4209
sampling_rate=125
data_4209= np.genfromtxt('/bcbl/home/public/CVR/LANGCONN_BIDS/PHYSIO_BIDS/sub-4209/ses-01/func/sub-4209_ses-01_task-breathhold_recording-125Hz_physio.tsv.gz') 
phys_4209= pk.Physio(data_4209[:, 4], fs=125, suppdata=data_4209[:, 3])
phys_4209= pk.operations.interpolate_physio(phys_4209, 40, kind='linear')
phys_4209= pk.operations.peakfind_physio(phys_4209, thresh=0.75, dist=110)
phys_4209= pk.operations.edit_physio(phys_4209) 
pk.plot_physio (phys_4209) 
plt.show() 

pk.save_physio(f'sub-4209_ses-01_task-breathhold_recording-125Hz_physio_peak_ch_co2', phys_4209)

#Vicente
sampling_rate=125
data_VICENTE= np.genfromtxt('/bcbl/home/public/CVR/LANGCONN_BIDS/PHYSIO_BIDS/sub-Vicente/ses-01/func/sub-Vicente_ses-01_task-breathhold_recording-125Hz_physio.tsv.gz') 
phys_VICENTE= pk.Physio(data_VICENTE[:, 4], fs=125, suppdata=data_VICENTE[:, 3])
phys_VICENTE= pk.operations.interpolate_physio(phys_VICENTE, 40, kind='linear')
phys_VICENTE= pk.operations.peakfind_physio(phys_VICENTE, thresh=0.75, dist=110)
phys_VICENTE= pk.operations.edit_physio(phys_VICENTE) 
pk.plot_physio (phys_VICENTE) 
plt.show() 

pk.save_physio(f'sub-Vicente_ses-01_task-breathhold_recording-125Hz_physio_peak_ch_co2', phys_VICENTE)

#312
sampling_rate=125
data_312= np.genfromtxt('/bcbl/home/public/CVR/LANGCONN_BIDS/PHYSIO_BIDS/sub-312/ses-01/func/sub-312_ses-01_task-breathhold_recording-125Hz_physio.tsv.gz') 
phys_312= pk.Physio(data_312[:, 4], fs=125, suppdata=data_312[:, 3])
phys_312= pk.operations.interpolate_physio(phys_312, 40, kind='linear')
phys_312= pk.operations.peakfind_physio(phys_312, thresh=0.75, dist=110)
phys_312= pk.operations.edit_physio(phys_312) 
pk.plot_physio (phys_312) 
plt.show() 

pk.save_physio(f'sub-312_ses-01_task-breathhold_recording-125Hz_physio_peak_ch_co2', phys_312)

#7591
sampling_rate=125
data_7591= np.genfromtxt('/bcbl/home/public/CVR/LANGCONN_BIDS/PHYSIO_BIDS/sub-7591/ses-01/func/sub-7591_ses-01_task-breathhold_recording-125Hz_physio.tsv.gz') 
phys_7591= pk.Physio(data_7591[:, 4], fs=125, suppdata=data_7591[:, 3])
phys_7591= pk.operations.interpolate_physio(phys_7591, 40, kind='linear')
phys_7591= pk.operations.peakfind_physio(phys_7591, thresh=0.75, dist=110)
phys_7591= pk.operations.edit_physio(phys_7591) 
pk.plot_physio (phys_7591) 
plt.show() 

pk.save_physio(f'sub-7591_ses-01_task-breathhold_recording-125Hz_physio_peak_ch_co2', phys_7591)

#8592
sampling_rate=125
data_8592= np.genfromtxt('/bcbl/home/public/CVR/LANGCONN_BIDS/PHYSIO_BIDS/sub-7591/ses-01/func/sub-7591_ses-01_task-breathhold_recording-125Hz_physio.tsv.gz') 
phys_8592= pk.Physio(data_8592[:, 4], fs=125, suppdata=data_8592[:, 3])
phys_8592= pk.operations.interpolate_physio(phys_8592, 40, kind='linear')
phys_8592= pk.operations.peakfind_physio(phys_8592, thresh=0.75, dist=110)
phys_8592= pk.operations.edit_physio(phys_8592) 
pk.plot_physio (phys_8592) 
plt.show() 

pk.save_physio(f'sub-7591_ses-01_task-breathhold_recording-125Hz_physio_peak_ch_co2', phys_8592)

#9491
sampling_rate=125
data_9491= np.genfromtxt('/bcbl/home/public/CVR/LANGCONN_BIDS/PHYSIO_BIDS/sub-9491/ses-01/func/sub-9491_ses-01_task-breathhold_recording-125Hz_physio.tsv.gz') 
phys_9491= pk.Physio(data_9491[:, 4], fs=125, suppdata=data_8516[:, 3])
phys_9491= pk.operations.interpolate_physio(phys_9491, 40, kind='linear')
phys_9491= pk.operations.peakfind_physio(phys_9491, thresh=0.75, dist=110)
phys_9491= pk.operations.edit_physio(phys_9491) 
pk.plot_physio (phys_9491) 
plt.show() 

pk.save_physio(f'sub-9491_ses-01_task-breathhold_recording-125Hz_physio_peak_ch_co2', phys_9491)

#8516
sampling_rate=125
data_8516= np.genfromtxt('/bcbl/home/public/CVR/LANGCONN_BIDS/PHYSIO_BIDS/sub-8516/ses-01/func/sub-8516_ses-01_task-breathhold_recording-125Hz_physio.tsv.gz') 
phys_8516= pk.Physio(data_8516[:, 4], fs=125, suppdata=data_8516[:, 3])
phys_8516= pk.operations.interpolate_physio(phys_8516, 40, kind='linear')
phys_8516= pk.operations.peakfind_physio(phys_8516, thresh=0.75, dist=110)
phys_8516= pk.operations.edit_physio(phys_8516) 
pk.plot_physio (phys_8516) 
plt.show() 

pk.save_physio(f'sub-8516_ses-01_task-breathhold_recording-125Hz_physio_peak_ch_co2', phys_8516)

#9796
sampling_rate=125
data_9796= np.genfromtxt('/bcbl/home/public/CVR/LANGCONN_BIDS/PHYSIO_BIDS/sub-9796/ses-01/func/sub-9796_ses-01_task-breathhold_recording-125Hz_physio.tsv.gz') 
phys_9796= pk.Physio(data_9796[:, 4], fs=125, suppdata=data_9796[:, 3])
phys_9796= pk.operations.interpolate_physio(phys_9796, 40, kind='linear')
phys_9796= pk.operations.peakfind_physio(phys_9796, thresh=0.75, dist=110)
phys_9796= pk.operations.edit_physio(phys_9796) 
pk.plot_physio (phys_9796) 
plt.show() 

pk.save_physio(f'sub-9796_ses-01_task-breathhold_recording-125Hz_physio_peak_ch_co2', phys_9796)

#6521
sampling_rate=125
data_6521= np.genfromtxt('/bcbl/home/public/CVR/LANGCONN_BIDS/PHYSIO_BIDS/sub-6521/ses-01/func/sub-6521_ses-01_task-breathhold_recording-125Hz_physio.tsv.gz') 
phys_6521= pk.Physio(data_6521[:, 4], fs=125, suppdata=data_6521[:, 3])
phys_6521= pk.operations.interpolate_physio(phys_6521, 40, kind='linear')
phys_6521= pk.operations.peakfind_physio(phys_6521, thresh=0.75, dist=110)
phys_6521= pk.operations.edit_physio(phys_6521) 
pk.plot_physio (phys_6521) 
plt.show() 

pk.save_physio(f'sub-6521_ses-01_task-breathhold_recording-125Hz_physio_peak_ch_co2', phys_6521)

data_6521=pk.load_physio('sub-6521_ses-01_task-breathhold_recording-125Hz_physio_peak_ch_co2.phys', allow_pickle=True)
data_6524= pk.operations.edit_physio(data_7721)
pk.plot_physio (data_6521)
plt.show()
pk.save_physio(f'sub-6521_ses-01_task-breathhold_recording-125Hz_physio_peak_ch_co2', data_6521)

#6027
sampling_rate=125
data_6027= np.genfromtxt('/bcbl/home/public/CVR/LANGCONN_BIDS/PHYSIO_BIDS/sub-6027/ses-01/func/sub-6027_ses-01_task-breathhold_recording-125Hz_physio.tsv.gz') 
phys_6027= pk.Physio(data_6027[:, 4], fs=125, suppdata=data_6027[:, 3])
phys_6027= pk.operations.interpolate_physio(phys_6027, 40, kind='linear')
phys_6027= pk.operations.peakfind_physio(phys_6027, thresh=0.75, dist=110)
phys_6027= pk.operations.edit_physio(phys_6027) 
pk.plot_physio (phys_6027) 
plt.show() 

pk.save_physio(f'sub-6027_ses-01_task-breathhold_recording-125Hz_physio_peak_ch_co2', phys_6027)

#600
sampling_rate=125
data_600= np.genfromtxt('/bcbl/home/public/CVR/LANGCONN_BIDS/PHYSIO_BIDS/sub-600/ses-01/func/sub-600_ses-01_task-breathhold_recording-125Hz_physio.tsv.gz') 
phys_600= pk.Physio(data_600[:, 4], fs=125, suppdata=data_600[:, 3])
phys_600= pk.operations.interpolate_physio(phys_600, 40, kind='linear')
phys_600= pk.operations.peakfind_physio(phys_600, thresh=0.75, dist=110)
phys_600= pk.operations.edit_physio(phys_600) 
pk.plot_physio (phys_600) 
plt.show() 

pk.save_physio(f'sub-600_ses-01_task-breathhold_recording-125Hz_physio_peak_ch_co2', phys_600)

data_600=pk.load_physio('sub-600_ses-01_task-breathhold_recording-125Hz_physio_peak_ch_co2.phys', allow_pickle=True)
data_600= pk.operations.edit_physio(data_600)
pk.plot_physio (data_600)
plt.show()
pk.save_physio(f'sub-600_ses-01_task-breathhold_recording-125Hz_physio_peak_ch_co2', data_600)

#8727
sampling_rate=125
data_8727= np.genfromtxt('/bcbl/home/public/CVR/LANGCONN_BIDS/PHYSIO_BIDS/sub-8727/ses-01/func/sub-8727_ses-01_task-breathhold_recording-125Hz_physio.tsv.gz') 
phys_8727= pk.Physio(data_8727[:, 4], fs=125, suppdata=data_8727[:, 3])
phys_8727= pk.operations.interpolate_physio(phys_8727, 40, kind='linear')
phys_8727= pk.operations.peakfind_physio(phys_8727, thresh=0.75, dist=110)
phys_8727= pk.operations.edit_physio(phys_8727) 
pk.plot_physio (phys_8727) 
plt.show() 

pk.save_physio(f'sub-8727_ses-01_task-breathhold_recording-125Hz_physio_peak_ch_co2', phys_8727)

#7540
sampling_rate=125
data_7540= np.genfromtxt('/bcbl/home/public/CVR/LANGCONN_BIDS/PHYSIO_BIDS/sub-7540/ses-01/func/sub-7540_ses-01_task-breathhold_recording-125Hz_physio.tsv.gz') 
phys_7540= pk.Physio(data_7540[:, 4], fs=125, suppdata=data_3437[:, 3])
phys_7540= pk.operations.interpolate_physio(phys_7540, 40, kind='linear')
phys_7540= pk.operations.peakfind_physio(phys_7540, thresh=0.75, dist=110)
phys_7540= pk.operations.edit_physio(phys_7540) 
pk.plot_physio (phys_7540) 
plt.show() 

pk.save_physio(f'sub-7540_ses-01_task-breathhold_recording-125Hz_physio_peak_ch_co2', phys_7540)

#3437
sampling_rate=125
data_3437= np.genfromtxt('/bcbl/home/public/CVR/LANGCONN_BIDS/PHYSIO_BIDS/sub-3437/ses-01/func/sub-3437_ses-01_task-breathhold_recording-125Hz_physio.tsv.gz') 
phys_3437= pk.Physio(data_3437[:, 4], fs=125, suppdata=data_3437[:, 3])
phys_3437= pk.operations.interpolate_physio(phys_3437, 40, kind='linear')
phys_3437= pk.operations.peakfind_physio(phys_3437, thresh=0.75, dist=110)
phys_3437= pk.operations.edit_physio(phys_3437) 
pk.plot_physio (phys_3437) 
plt.show() 

pk.save_physio(f'sub-3437_ses-01_task-breathhold_recording-125Hz_physio_peak_ch_co2', phys_3437)

#9931
sampling_rate=125
data_9931= np.genfromtxt('/bcbl/home/public/CVR/LANGCONN_BIDS/PHYSIO_BIDS/sub-9931/ses-01/func/sub-9931_ses-01_task-breathhold_recording-125Hz_physio.tsv.gz') 
phys_9931= pk.Physio(data_9931[:, 4], fs=125, suppdata=data_9931[:, 3])
phys_9931= pk.operations.interpolate_physio(phys_9931, 40, kind='linear')
phys_9931= pk.operations.peakfind_physio(phys_9931, thresh=0.75, dist=110)
phys_9931= pk.operations.edit_physio(phys_9931) 
pk.plot_physio (phys_9931) 
plt.show() 

pk.save_physio(f'sub-9931_ses-01_task-breathhold_recording-125Hz_physio_peak_ch_co2', phys_9931)

#9679
sampling_rate=125
data_9679= np.genfromtxt('/bcbl/home/public/CVR/LANGCONN_BIDS/PHYSIO_BIDS/sub-9679/ses-01/func/sub-9679_ses-01_task-breathhold_recording-125Hz_physio.tsv.gz') 
phys_5274= pk.Physio(data_9679[:, 4], fs=125, suppdata=data_9679[:, 3])
phys_9679= pk.operations.interpolate_physio(phys_9679, 40, kind='linear')
phys_9679= pk.operations.peakfind_physio(phys_9679, thresh=0.75, dist=110)
phys_9679= pk.operations.edit_physio(phys_9679) 
pk.plot_physio (phys_9679) 
plt.show() 

pk.save_physio(f'sub-9679_ses-01_task-breathhold_recording-125Hz_physio_peak_ch_co2', phys_9679)



#5274
sampling_rate=125
data_5274= np.genfromtxt('/bcbl/home/public/CVR/LANGCONN_BIDS/PHYSIO_BIDS/sub-5487/ses-01/func/sub-5487_ses-01_task-breathhold_recording-125Hz_physio.tsv.gz') 
phys_5274= pk.Physio(data_5274[:, 4], fs=125, suppdata=data_5274[:, 3])
phys_5274= pk.operations.interpolate_physio(phys_5274, 40, kind='linear')
phys_5274= pk.operations.peakfind_physio(phys_5274, thresh=0.75, dist=110)
phys_5274= pk.operations.edit_physio(phys_5274) 
pk.plot_physio (phys_5274) 
plt.show() 

pk.save_physio(f'sub-5274_ses-01_task-breathhold_recording-125Hz_physio_peak_ch_co2', phys_5274)

data_5274=pk.load_physio('sub-5274_ses-01_task-breathhold_recording-125Hz_physio_peak_ch_co2.phys', allow_pickle=True)
data_5274= pk.operations.edit_physio(data_5274)
pk.plot_physio (data_5274)
plt.show()
pk.save_physio(f'sub-5274_ses-01_task-breathhold_recording-125Hz_physio_peak_ch_co2', data_5274)

#9494
sampling_rate=125
data_9494= np.genfromtxt('/bcbl/home/public/CVR/LANGCONN_BIDS/PHYSIO_BIDS/sub-9494/ses-01/func/sub-9494_ses-01_task-breathhold_recording-125Hz_physio.tsv.gz') 
phys_9494= pk.Physio(data_9494[:, 4], fs=125, suppdata=data_9494[:, 3])
phys_9494= pk.operations.interpolate_physio(phys_9494, 40, kind='linear')
phys_9494= pk.operations.peakfind_physio(phys_9494, thresh=0.75, dist=110)
phys_9494= pk.operations.edit_physio(phys_9494) 
pk.plot_physio (phys_9494) 
plt.show() 

pk.save_physio(f'sub-9494_ses-01_task-breathhold_recording-125Hz_physio_peak_ch_co2', phys_9494)

#4800
sampling_rate=125
data_4800= np.genfromtxt('/bcbl/home/public/CVR/LANGCONN_BIDS/PHYSIO_BIDS/sub-4800/ses-01/func/sub-4800_ses-01_task-breathhold_recording-125Hz_physio.tsv.gz') 
phys_4800= pk.Physio(data_4800[:, 4], fs=125, suppdata=data_4800[:, 3])
phys_4800= pk.operations.interpolate_physio(phys_4800, 40, kind='linear')
phys_4800= pk.operations.peakfind_physio(phys_4800, thresh=0.75, dist=110)
phys_4800= pk.operations.edit_physio(phys_4800) 
pk.plot_physio (phys_4800) 
plt.show() 

pk.save_physio(f'sub-4800_ses-01_task-breathhold_recording-125Hz_physio_peak_ch_co2', phys_4800)

#9973
sampling_rate=125
data_9973= np.genfromtxt('/bcbl/home/public/CVR/LANGCONN_BIDS/PHYSIO_BIDS/sub-9973/ses-01/func/sub-9973_ses-01_task-breathhold_recording-125Hz_physio.tsv.gz') 
phys_9973= pk.Physio(data_9973[:, 4], fs=125, suppdata=data_9973[:, 3])
phys_9973= pk.operations.interpolate_physio(phys_9973, 40, kind='linear')
phys_9973= pk.operations.peakfind_physio(phys_9973, thresh=0.75, dist=110)
phys_9973= pk.operations.edit_physio(phys_9973) 
pk.plot_physio (phys_9973) 
plt.show() 

pk.save_physio(f'sub-9973_ses-01_task-breathhold_recording-125Hz_physio_peak_ch_co2', phys_9973)

#6635
sampling_rate=125
data_6635= np.genfromtxt('/bcbl/home/public/CVR/LANGCONN_BIDS/PHYSIO_BIDS/sub-6635/ses-01/func/sub-6635_ses-01_task-breathhold_recording-125Hz_physio.tsv.gz') 
phys_6635= pk.Physio(data_6635[:, 4], fs=125, suppdata=data_6635[:, 3])
phys_6635= pk.operations.interpolate_physio(phys_6635, 40, kind='linear')
phys_6635= pk.operations.peakfind_physio(phys_6635, thresh=0.75, dist=110)
phys_6635= pk.operations.edit_physio(phys_6635) 
pk.plot_physio (phys_6635) 
plt.show() 

pk.save_physio(f'sub-6635_ses-01_task-breathhold_recording-125Hz_physio_peak_ch_co2', phys_6635)

#9993
sampling_rate=125
data_9993= np.genfromtxt('/bcbl/home/public/CVR/LANGCONN_BIDS/PHYSIO_BIDS/sub-9993/ses-01/func/sub-9993_ses-01_task-breathhold_recording-125Hz_physio.tsv.gz') 
phys_9993= pk.Physio(data_9993[:, 4], fs=125, suppdata=data_9993[:, 3])
phys_9993= pk.operations.interpolate_physio(phys_9993, 40, kind='linear')
phys_9993= pk.operations.peakfind_physio(phys_9993, thresh=0.75, dist=110)
phys_9993= pk.operations.edit_physio(phys_9993) 
pk.plot_physio (phys_9993) 
plt.show() 

pk.save_physio(f'sub-9993_ses-01_task-breathhold_recording-125Hz_physio', phys_9993)

#5325
sampling_rate=125
data_5325= np.genfromtxt('/bcbl/home/public/CVR/LANGCONN_BIDS/PHYSIO_BIDS/sub-5325/ses-01/func/sub-5325_ses-01_task-breathhold_recording-125Hz_physio.tsv.gz') 
phys_5325= pk.Physio(data_5325[:, 4], fs=125, suppdata=data_5325[:, 3])
phys_5325= pk.operations.interpolate_physio(phys_5325, 40, kind='linear')
phys_5325= pk.operations.peakfind_physio(phys_5325, thresh=0.75, dist=110)
phys_5325= pk.operations.edit_physio(phys_5325) 
pk.plot_physio (phys_5325) 
plt.show() 

pk.save_physio(f'sub-5325_ses-01_task-breathhold_recording-125Hz_physio', phys_5325)

#9883
sampling_rate=125
data_9883= np.genfromtxt('/bcbl/home/public/CVR/LANGCONN_BIDS/PHYSIO_BIDS/sub-9883/ses-01/func/sub-9883_ses-01_task-breathhold_recording-125Hz_physio.tsv.gz') 
phys_9883= pk.Physio(data_9883[:, 4], fs=125, suppdata=data_9883[:, 3])
phys_9883= pk.operations.interpolate_physio(phys_9883, 40, kind='linear')
phys_9883= pk.operations.peakfind_physio(phys_9883, thresh=0.75, dist=110)
phys_9883= pk.operations.edit_physio(phys_9883) 
pk.plot_physio (phys_plt.show() 

data_5742= np.genfromtxt('/bcbl/home/public/CVR/LANGCONN_BIDS/PHYSIO_BIDS/sub-5742/ses-01/func/sub-5742_ses-01_task-breathhold_recording-125Hz_physio.tsv.gz') 
phys_5742= pk.Physio(data_5742[:, 4], fs=125, suppdata=data_5742[:, 3])
phys_5742= pk.operations.interpolate_physio(phys_5742, 40, kind='linear')
phys_5742= pk.operations.peakfind_physio(phys_5742, thresh=0.75, dist=110)
phys_5742= pk.operations.edit_physio(phys_5742) 
pk.plot_physio (phys_5742) 
plt.show() 

pk.save_physio(f'sub-5742_ses-01_task-breathhold_recording-125Hz_physio', phys_5742)

#4281
sampling_rate=125
data_4281= np.genfromtxt('/bcbl/home/public/CVR/LANGCONN_BIDS/PHYSIO_BIDS/sub-4281/ses-01/func/sub-4281_ses-01_task-breathhold_recording-125Hz_physio.tsv.gz') 
phys_4281= pk.Physio(data_4281[:, 4], fs=125, suppdata=data_4281[:, 3])
phys_4281= pk.operations.interpolate_physio(phys_4281, 40, kind='linear')
phys_4281= pk.operations.peakfind_physio(phys_4281, thresh=0.75, dist=110)
phys_4281= pk.operations.edit_physio(phys_4281) 
pk.plot_physio (phys_4281) 
plt.show() 

pk.save_physio(f'sub-4281_ses-01_task-breathhold_recording-125Hz_physio', phys_4281)

#5487
sampling_rate=125
data_5487= np.genfromtxt('/bcbl/home/public/CVR/LANGCONN_BIDS/PHYSIO_BIDS/sub-5487/ses-01/func/sub-5487_ses-01_task-breathhold_recording-125Hz_physio.tsv.gz') 
phys_5487= pk.Physio(data_5487[:, 4], fs=125, suppdata=data_5487[:, 3])
phys_5487= pk.operations.interpolate_physio(phys_5487, 40, kind='linear')
phys_5487= pk.operations.peakfind_physio(phys_5487, thresh=0.75, dist=110)
phys_5487= pk.operations.edit_physio(phys_5487) 
pk.plot_physio (phys_5487) 
plt.show() 

pk.save_physio(f'sub-5487_ses-01_task-breathhold_recording-125Hz_physio', phys_5487)

#3893
sampling_rate=125
data_3893= np.genfromtxt('/bcbl/home/public/CVR/LANGCONN_BIDS/PHYSIO_BIDS/sub-3893/ses-01/func/sub-3893_ses-01_task-breathhold_recording-125Hz_physio.tsv.gz') 
phys_3893= pk.Physio(data_3893[:, 4], fs=125, suppdata=data_3893[:, 3])
phys_3893= pk.operations.interpolate_physio(phys_3893, 40, kind='linear')
phys_3893= pk.operations.peakfind_physio(phys_3893, thresh=0.75, dist=110)
phys_3893= pk.operations.edit_physio(phys_3893) 
pk.plot_physio (phys_3893) 
plt.show() 

pk.save_physio(f'sub-3893_ses-01_task-breathhold_recording-125Hz_physio', phys_3893)

#4898
sampling_rate=125
data_4898= np.genfromtxt('/bcbl/home/public/CVR/LANGCONN_BIDS/PHYSIO_BIDS/sub-4898/ses-01/func/sub-4898_ses-01_task-breathhold_recording-125Hz_physio.tsv.gz') 
phys_4898= pk.Physio(data_4898[:, 4], fs=125, suppdata=data_4898[:, 3])
phys_4898= pk.operations.interpolate_physio(phys_4898, 40, kind='linear')
phys_4898= pk.operations.peakfind_physio(phys_4898, thresh=0.75, dist=110)
phys_4898= pk.operations.edit_physio(phys_4898) 
pk.plot_physio (phys_4898) 
plt.show() 

pk.save_physio(f'sub-4898_ses-01_task-breathhold_recording-125Hz_physio', phys_4898)

#10007
sampling_rate=125
data_10007= np.genfromtxt('/bcbl/home/public/CVR/LANGCONN_BIDS/PHYSIO_BIDS/sub-10007/ses-01/func/sub-10007_ses-01_task-breathhold_recording-125Hz_physio.tsv.gz') 
phys_10007= pk.Physio(data_10007[:, 4], fs=125, suppdata=data_10007[:, 3])
phys_10007= pk.operations.interpolate_physio(phys_10007, 40, kind='linear')
phys_10007= pk.operations.peakfind_physio(phys_10007, thresh=0.75, dist=110)
phys_10007= pk.operations.edit_physio(phys_10007) 
pk.plot_physio (phys_10007) 
plt.show() 

pk.save_physio(f'sub-10007_ses-01_task-breathhold_recording-125Hz_physio', phys_10007)

#6509
sampling_rate=125
data_6509= np.genfromtxt('/bcbl/home/public/CVR/LANGCONN_BIDS/PHYSIO_BIDS/sub-6509/ses-01/func/sub-6509_ses-01_task-breathhold_recording-125Hz_physio.tsv.gz') 
phys_6509= pk.Physio(data_6509[:, 4], fs=125, suppdata=data_6509[:, 3])
phys_6509= pk.operations.interpolate_physio(phys_6509, 40, kind='linear')
phys_6509= pk.operations.peakfind_physio(phys_6509, thresh=0.75, dist=110)
phys_6509= pk.operations.edit_physio(phys_6509) 
pk.plot_physio (phys_6509) 
plt.show() 

pk.save_physio(f'sub-6509_ses-01_task-breathhold_recording-125Hz_physio', phys_6509)

#10100
sampling_rate=125
data_10100= np.genfromtxt('/bcbl/home/public/CVR/LANGCONN_BIDS/PHYSIO_BIDS/sub-10100/ses-01/func/sub-10100_ses-01_task-breathhold_recording-125Hz_physio.tsv.gz') 
phys_10100= pk.Physio(data_10100[:, 4], fs=125, suppdata=data_10100[:, 3])
phys_10100= pk.operations.interpolate_physio(phys_10100, 40, kind='linear')
phys_10100= pk.operations.peakfind_physio(phys_10100, thresh=0.75, dist=110)
phys_10100= pk.operations.edit_physio(phys_10100) 
pk.plot_physio (phys_10100) 
plt.show() 

pk.save_physio(f'sub-10100_ses-01_task-breathhold_recording-125Hz_physio', phys_10100)

#3898
sampling_rate=125
data_3898= np.genfromtxt('/bcbl/home/public/CVR/LANGCONN_BIDS/PHYSIO_BIDS/sub-3898/ses-01/func/sub-3898_ses-01_task-breathhold_recording-125Hz_physio.tsv.gz') 
phys_3898= pk.Physio(data_3898[:, 4], fs=125, suppdata=data_3898[:, 3])
phys_3898= pk.operations.interpolate_physio(phys_3898, 40, kind='linear')
phys_3898= pk.operations.peakfind_physio(phys_3898, thresh=0.75, dist=110)
phys_3898= pk.operations.edit_physio(phys_3898) 
pk.plot_physio (phys_3898) 
plt.show() 

pk.save_physio(f'sub-3898_ses-01_task-breathhold_recording-125Hz_physio', phys_3898)

#3037
sampling_rate=125
data_3037= np.genfromtxt('/bcbl/home/public/CVR/LANGCONN_BIDS/PHYSIO_BIDS/sub-3037/ses-01/func/sub-3037_ses-01_task-breathhold_recording-125Hz_physio.tsv.gz') 
phys_3037= pk.Physio(data_3037[:, 4], fs=125, suppdata=data_3037[:, 3])
phys_3037= pk.operations.interpolate_physio(phys_3037, 40, kind='linear')
phys_3037= pk.operations.peakfind_physio(phys_3037, thresh=0.75, dist=110)
phys_3037= pk.operations.edit_physio(phys_3037) 
pk.plot_physio (phys_3037) 
plt.show() 

pk.save_physio(f'sub-3037_ses-01_task-breathhold_recording-125Hz_physio', phys_3037)
 
#2787
sampling_rate=125
data_2787= np.genfromtxt('/bcbl/home/public/CVR/LANGCONN_BIDS/PHYSIO_BIDS/sub-2787/ses-01/func/sub-2787_ses-01_task-breathhold_recording-125Hz_physio.tsv.gz') 
phys_2787= pk.Physio(data_2787[:, 4], fs=125, suppdata=data_2787[:, 3])
phys_2787= pk.operations.interpolate_physio(phys_2787, 40, kind='linear')
phys_2787= pk.operations.peakfind_physio(phys_2787, thresh=0.75, dist=110)
phys_2787= pk.operations.edit_physio(phys_2787) 
pk.plot_physio (phys_2787) 
plt.show() 

pk.save_physio(f'sub-2787_ses-01_task-breathhold_recording-125Hz_physio', phys_2787)

#2762
sampling_rate=125
data_2762= np.genfromtxt('/bcbl/home/public/CVR/LANGCONN_BIDS/PHYSIO_BIDS/sub-2762/ses-01/func/sub-2762_ses-01_task-breathhold_recording-125Hz_physio.tsv.gz') 
phys_2762= pk.Physio(data_2762[:, 4], fs=125, suppdata=data_2762[:, 3])
phys_2762= pk.operations.interpolate_physio(phys_2762, 40, kind='linear')
phys_2762= pk.operations.peakfind_physio(phys_2762, thresh=0.75, dist=110)
phys_2762= pk.operations.edit_physio(phys_2762) 
pk.plot_physio (phys_2762) 
plt.show() 

pk.save_physio(f'sub-2762_ses-01_task-breathhold_recording-125Hz_physio', phys_2762)

#9912
sampling_rate=125
data_9912= np.genfromtxt('/bcbl/home/public/CVR/LANGCONN_BIDS/PHYSIO_BIDS/sub-9912/ses-01/func/sub-9912_ses-01_task-breathhold_recording-125Hz_physio.tsv.gz') 
phys_9912= pk.Physio(data_9912[:, 4], fs=125, suppdata=data_9912[:, 3])
phys_9912= pk.operations.interpolate_physio(phys_9912, 40, kind='linear')
phys_9912= pk.operations.peakfind_physio(phys_9912, thresh=0.75, dist=110)
phys_9912= pk.operations.edit_physio(phys_9912) 
pk.plot_physio (phys_9912) 
plt.show() 

pk.save_physio(f'sub-9912_ses-01_task-breathhold_recording-125Hz_physio', phys_9912)

#10101
sampling_rate=125
data_10101= np.genfromtxt('/bcbl/home/public/CVR/LANGCONN_BIDS/PHYSIO_BIDS/sub-10101/ses-01/func/sub-10101_ses-01_task-breathhold_recording-125Hz_physio.tsv.gz') 
phys_10101= pk.Physio(data_10101[:, 4], fs=125, suppdata=data_10101[:, 3])
phys_10101= pk.operations.interpolate_physio(phys_10101, 40, kind='linear')
phys_10101= pk.operations.peakfind_physio(phys_10101, thresh=0.75, dist=110)
phys_10101= pk.operations.edit_physio(phys_10101) 
pk.plot_physio (phys_10101) 
plt.show() 

pk.save_physio(f'sub-10101_ses-01_task-breathhold_recording-125Hz_physio', phys_10101)

#10061
sampling_rate=125
data_10061= np.genfromtxt('/bcbl/home/public/CVR/LANGCONN_BIDS/PHYSIO_BIDS/sub-10061/ses-01/func/sub-10061_ses-01_task-breathhold_recording-125Hz_physio.tsv.gz') 
phys_10061= pk.Physio(data_10061[:, 4], fs=125, suppdata=data_10061[:, 3])
phys_10061= pk.operations.interpolate_physio(phys_10061, 40, kind='linear')
phys_10061= pk.operations.peakfind_physio(phys_10061, thresh=0.75, dist=110)
phys_10061= pk.operations.edit_physio(phys_10061) 
pk.plot_physio (phys_10061) 
plt.show() 

pk.save_physio(f'sub-10061_ses-01_task-breathhold_recording-125Hz_physio', phys_10061)

#5083
sampling_rate=125
data_5083= np.genfromtxt('/bcbl/home/public/CVR/LANGCONN_BIDS/PHYSIO_BIDS/sub-5083/ses-01/func/sub-5083_ses-01_task-breathhold_recording-125Hz_physio.tsv.gz') 
phys_5083= pk.Physio(data_5083[:, 4], fs=125, suppdata=data_5083[:, 3])
phys_5083= pk.operations.interpolate_physio(phys_5083, 40, kind='linear')
phys_5083= pk.operations.peakfind_physio(phys_5083, thresh=0.75, dist=110)
phys_5083= pk.operations.edit_physio(phys_5083) 
pk.plot_physio (phys_5083) 
plt.show() 

pk.save_physio(f'sub-5083_ses-01_task-breathhold_recording-125Hz_physio', phys_5083)

#1092
sampling_rate=125
data_1092= np.genfromtxt('/bcbl/home/public/CVR/LANGCONN_BIDS/PHYSIO_BIDS/sub-1092/ses-01/func/sub-1092_ses-01_task-breathhold_recording-125Hz_physio.tsv.gz') 
phys_1092= pk.Physio(data_1092[:, 4], fs=125, suppdata=data_1092[:, 3])
phys_1092= pk.operations.interpolate_physio(phys_1092, 40, kind='linear')
phys_1092= pk.operations.peakfind_physio(phys_1092, thresh=0.75, dist=110)
phys_1092= pk.operations.edit_physio(phys_1092) 
pk.plot_physio (phys_1092) 
plt.show() 

pk.save_physio(f'sub-1092_ses-01_task-breathhold_recording-125Hz_physio', phys_1092)

#9351
sampling_rate=125
data_9351= np.genfromtxt('/bcbl/home/public/CVR/LANGCONNdata_1010_BIDS/PHYSIO_BIDS/sub-9351/ses-01/func/sub-9351_ses-01_task-breathhold_recording-125Hz_physio.tsv.gz') 
phys_9351= pk.Physio(data_9351[:, 4], fs=125, suppdata=data_9351[:, 3])
phys_9351= pk.operations.interpolate_physio(phys_9351, 40, kind='linear')
phys_9351= pk.operations.peakfind_physio(phys_9351, thresh=0.75, dist=110)
phys_9351= pk.operations.edit_physio(phys_9351) 
pk.plot_physio (phys_9351) 
plt.show() 

pk.save_physio(f'sub-9351_ses-01_task-breathhold_recording-125Hz_physio_peak_ch_co2', phys_9351)


#3349
sampling_rate=125
data_3349= np.genfromtxt('/bcbl/home/public/CVR/LANGCONN_BIDS/PHYSIO_BIDS/sub-3349/ses-01/func/sub-3349_ses-01_task-breathhold_recording-125Hz_physio.tsv.gz') 
phys_3349= pk.Physio(data_3349[:, 4], fs=125, suppdata=data_3349[:, 3])
phys_3349= pk.operations.interpolate_physio(phys_3349, 40, kind='linear')
phys_3349= pk.operations.peakfind_physio(phys_3349, thresh=0.75, dist=110)
phys_3349= pk.operations.edit_physio(phys_3349) 
pk.plot_physio (phys_3349) 
plt.show() 

pk.save_physio(f'sub-3349_ses-01_task-breathhold_recording-125Hz_physio_peak_ch_co2', phys_3349)

#10082
sampling_rate=125
data_10082= np.genfromtxt('/bcbl/home/public/CVR/LANGCONN_BIDS/PHYSIO_BIDS/sub-10082/ses-01/func/sub-10082_ses-01_task-breathhold_recording-125Hz_physio.tsv.gz') 
phys_10082= pk.Physio(data_10082[:, 4], fs=125, suppdata=data_10082[:, 3])
phys_10082= pk.operations.interpolate_physio(phys_10082, 40, kind='linear')
phys_10082= pk.operations.peakfind_physio(phys_10082, thresh=0.75, dist=110)
phys_10082= pk.operations.edit_physio(phys_10082) 
pk.plot_physio (phys_10082) 
plt.show() 

pk.save_physio(f'sub-10082_ses-01_task-breathhold_recording-125Hz_physio_peak_ch_co2', phys_10082)

#10103
sampling_rate=125
data_10103= np.genfromtxt('/bcbl/home/public/CVR/LANGCONN_BIDS/PHYSIO_BIDS/sub-10103/ses-01/func/sub-10103_ses-01_task-breathhold_recording-125Hz_physio.tsv.gz') 
phys_10103= pk.Physio(data_10103[:, 4], fs=125, suppdata=data_10103[:, 3])
phys_10103= pk.operations.interpolate_physio(phys_10103, 40, kind='linear')
phys_10103= pk.operations.peakfind_physio(phys_10103, thresh=0.75, dist=110)
phys_10103= pk.operations.edit_physio(phys_10103) 
pk.plot_physio (phys_10103) 
plt.show() 

pk.save_physio(f'sub-10103_ses-01_task-breathhold_recording-125Hz_physio_peak_ch_co2', phys_10103)

#8239
sampling_rate=125
data_8239= np.genfromtxt('/bcbl/home/public/CVR/LANGCONN_BIDS/PHYSIO_BIDS/sub-8239/ses-01/func/sub-8239_ses-01_task-breathhold_recording-125Hz_physio.tsv.gz') 
phys_8239= pk.Physio(data_8239[:, 4], fs=125, suppdata=data_8239[:, 3])
phys_8239= pk.operations.interpolate_physio(phys_8239, 40, kind='linear')
phys_8239= pk.operations.peakfind_physio(phys_8239, thresh=0.75, dist=110)
phys_8239= pk.operations.edit_physio(phys_8239) 
pk.plot_physio (phys_8239) 
plt.show() 

pk.save_physio(f'sub-8239_ses-01_task-breathhold_recording-125Hz_physio_peak_ch_co2', phys_8239)

#9944
sampling_rate=125
data_9944= np.genfromtxt('/bcbl/home/public/CVR/LANGCONN_BIDS/PHYSIO_BIDS/sub-9944/ses-01/func/sub-9944_ses-01_task-breathhold_recording-125Hz_physio.tsv.gz') 
phys_9944= pk.Physio(data_9944[:, 4], fs=125, suppdata=data_9944[:, 3])
phys_9944= pk.operations.interpolate_physio(phys_9944, 40, kind='linear')
phys_9944= pk.operations.peakfind_physio(phys_9944, thresh=0.75, dist=110)
phys_9944= pk.operations.edit_physio(phys_9944) 
pk.plot_physio (phys_9944) 
plt.show() 

pk.save_physio(f'sub-9944_ses-01_task-breathhold_recording-125Hz_physio_peak_ch_co2', phys_9944)

#9055
sampling_rate=125
data_9055= np.genfromtxt('/bcbl/home/public/CVR/LANGCONN_BIDS/PHYSIO_BIDS/sub-9055/ses-01/func/sub-9055_ses-01_task-breathhold_recording-125Hz_physio.tsv.gz') 
phys_9055= pk.Physio(data_9055[:, 5], fs=125, suppdata=data_9055[:, 3])
phys_9055= pk.operations.interpolate_physio(phys_9055, 40, kind='linear')
phys_9055= pk.operations.peakfind_physio(phys_9055, thresh=1, dist=100)
phys_9055= pk.operations.edit_physio(phys_9055) 
pk.plot_physio (phys_9055) 
plt.show() 

pk.save_physio(f'sub-9055_ses-01_task-breathhold_recording-125Hz_physio_peak_ch_co2', phys_9055)

#10246
sampling_rate=125
data_10246= np.genfromtxt('/bcbl/home/public/CVR/LANGCONN_BIDS/PHYSIO_BIDS/sub-10246/ses-01/func/sub-10246_ses-01_task-breathhold_recording-125Hz_physio.tsv.gz') 
phys_10246= pk.Physio(data_10246[:, 5], fs=125, suppdata=data_10246[:, 3])
phys_10246= pk.operations.interpolate_physio(phys_10246, 40, kind='linear')
phys_10246= pk.operations.peakfind_physio(phys_10246, thresh=1, dist=100)
phys_10246= pk.operations.edit_physio(phys_10246) 
pk.plot_physio (phys_10246) 
plt.show() 

pk.save_physio(f'sub-10246_ses-01_task-breathhold_recording-125Hz_physio_peak_ch_co2', phys_10246)

#6483
sampling_rate=125
data_6483= np.genfromtxt('/bcbl/home/public/CVR/LANGCONN_BIDS/PHYSIO_BIDS/sub-6483/ses-01/func/sub-6483_ses-01_task-breathhold_recording-125Hz_physio.tsv.gz') 
phys_6483= pk.Physio(data_6483[:, 4], fs=125, suppdata=data_6483[:, 3])
phys_6483= pk.operations.interpolate_physio(phys_6483, 40, kind='linear')
phys_6483= pk.operations.peakfind_physio(phys_6483, thresh=1, dist=100)
phys_6483= pk.operations.edit_physio(phys_6483) 
pk.plot_physio (phys_6483) 
plt.show() 

pk.save_physio(f'sub-6483_ses-01_task-breathhold_recording-125Hz_physio_peak_ch_co2', phys_6483)

#10200
sampling_rate=125
data_10200= np.genfromtxt('/bcbl/home/public/CVR/LANGCONN_BIDS/PHYSIO_BIDS/sub-10200/ses-01/func/sub-10200_ses-01_task-breathhold_recording-125Hz_physio.tsv.gz') 
phys_10200= pk.Physio(data_10200[:, 4], fs=125, suppdata=data_10200[:, 3])
phys_10200= pk.operations.interpolate_physio(phys_10200, 40, kind='linear')
phys_10200= pk.operations.peakfind_physio(phys_10200, thresh=1, dist=100)
phys_10200= pk.operations.edit_physio(phys_10200) 
pk.plot_physio (phys_10200) 
plt.show() 

pk.save_physio(f'sub-10200_ses-01_task-breathhold_recording-125Hz_physio_peak_ch_co2', phys_10200)

#10393
sampling_rate=125
data_10393= np.genfromtxt('/bcbl/home/public/CVR/LANGCONN_BIDS/PHYSIO_BIDS/sub-10393/ses-01/func/sub-10393_ses-01_task-breathhold_recording-125Hz_physio.tsv.gz') 
phys_10393= pk.Physio(data_10393[:, 4], fs=125, suppdata=data_10393[:, 3])
phys_10393= pk.operations.interpolate_physio(phys_10393, 40, kind='linear')
phys_10393= pk.operations.peakfind_physio(phys_10393, thresh=1, dist=100)
phys_10393= pk.operations.edit_physio(phys_10393) 
pk.plot_physio (phys_10393) 
plt.show() 

pk.save_physio(f'sub-10393_ses-01_task-breathhold_recording-125Hz_physio_peak_ch_co2', phys_10393)

#10399
sampling_rate=125
data_10399= np.genfromtxt('/bcbl/home/public/CVR/LANGCONN_BIDS/PHYSIO_BIDS/sub-10399/ses-01/func/sub-10399_ses-01_task-breathhold_recording-125Hz_physio.tsv.gz') 
phys_10399= pk.Physio(data_10399[:, 5], fs=125, suppdata=data_10399[:, 3])
phys_10399= pk.operations.interpolate_physio(phys_10399, 40, kind='linear')
phys_10399= pk.operations.peakfind_physio(phys_10399, thresh=0.75, dist=100)
phys_10399= pk.operations.edit_physio(phys_10399) 
pk.plot_physio (phys_10399) 
plt.show()


pk.save_physio(f'sub-10399_ses-01_task-breathhold_recording-125Hz_physio_peak_ch_co2', phys_10399)

#10397
sampling_rate=125
data_10397= np.genfromtxt('/bcbl/home/public/CVR/LANGCONN_BIDS/PHYSIO_BIDS/sub-10397/ses-01/func/sub-10397_ses-01_task-breathhold_recording-125Hz_physio.tsv.gz') 
phys_10397= pk.Physio(data_10397[:, 4], fs=125, suppdata=data_10397[:, 3])
phys_10397= pk.operations.interpolate_physio(phys_10397, 40, kind='linear')
phys_10397= pk.operations.peakfind_physio(phys_10397, thresh=0.75, dist=100)
phys_10397= pk.operations.edit_physio(phys_10397) 
pk.plot_physio (phys_10397) 
plt.show()


pk.save_physio(f'sub-10397_ses-01_task-breathhold_recording-125Hz_physio_peak_ch_co2', phys_10397)

#10413
sampling_rate=125
data_10413= np.genfromtxt('/bcbl/home/public/CVR/LANGCONN_BIDS/PHYSIO_BIDS/sub-10413/ses-01/func/sub-10413_ses-01_task-breathhold_recording-125Hz_physio.tsv.gz') 
phys_10413= pk.Physio(data_10413[:, 4], fs=125, suppdata=data_10413[:, 3])
phys_10413= pk.operations.interpolate_physio(phys_10413, 40, kind='linear')
phys_10413= pk.operations.peakfind_physio(phys_10413, thresh=0.75, dist=100)
phys_10413= pk.operations.edit_physio(phys_10413) 
pk.plot_physio (phys_10413) 
plt.show()


pk.save_physio(f'sub-10413_ses-01_task-breathhold_recording-125Hz_physio_peak_ch_co2', phys_10413)

#10453
sampling_rate=125
data_10453= np.genfromtxt('/bcbl/home/public/CVR/LANGCONN_BIDS/PHYSIO_BIDS/sub-10453/ses-01/func/sub-10453_ses-01_task-breathhold_recording-125Hz_physio.tsv.gz') 
phys_10453= pk.Physio(data_10453[:, 4], fs=125, suppdata=data_10453[:, 3])
phys_10453= pk.operations.interpolate_physio(phys_10453, 40, kind='linear')
phys_10453= pk.operations.peakfind_physio(phys_10453, thresh=0.75, dist=100)
phys_10453= pk.operations.edit_physio(phys_10453) 
pk.plot_physio (phys_10453) 
plt.show()


pk.save_physio(f'sub-10453_ses-01_task-breathhold_recording-125Hz_physio_peak_ch_co2', phys_10453)

#10473
sampling_rate=125
data_10473= np.genfromtxt('/bcbl/home/public/CVR/LANGCONN_BIDS/PHYSIO_BIDS/sub-10473/ses-01/func/sub-10473_ses-01_task-breathhold_recording-125Hz_physio.tsv.gz') 
phys_10473= pk.Physio(data_10473[:, 5], fs=125, suppdata=data_10473[:, 3])
phys_10473= pk.operations.interpolate_physio(phys_10473, 40, kind='linear')
phys_10473= pk.operations.peakfind_physio(phys_10473, thresh=0.75, dist=100)
phys_10473= pk.operations.edit_physio(phys_10473) 
pk.plot_physio (phys_10473) 
plt.show()

pk.save_physio(f'sub-10473_ses-01_task-breathhold_recording-125Hz_physio_peak_ch_co2', phys_10473)

#10485
sampling_rate=125
data_10485= np.genfromtxt('/bcbl/home/public/CVR/LANGCONN_BIDS/PHYSIO_BIDS/sub-10485/ses-01/func/sub-10485_ses-01_task-breathhold_recording-125Hz_physio.tsv.gz') 
phys_10485= pk.Physio(data_10485[:, 4], fs=125, suppdata=data_10485[:, 3])
phys_10485= pk.operations.interpolate_physio(phys_10485, 40, kind='linear')
phys_10485= pk.operations.peakfind_physio(phys_10485, thresh=0.75, dist=100)
phys_10485= pk.operations.edit_physio(phys_10485) 
pk.plot_physio (phys_10485) 
plt.show()

pk.save_physio(f'sub-10485_ses-01_task-breathhold_recording-125Hz_physio_peak_ch_co2', phys_10485)

#10449
sampling_rate=125
data_10449= np.genfromtxt('/bcbl/home/public/CVR/LANGCONN_BIDS/PHYSIO_BIDS/sub-10449/ses-01/func/sub-10449_ses-01_task-breathhold_recording-125Hz_physio.tsv.gz') 
phys_10449= pk.Physio(data_10449[:, 4], fs=125, suppdata=data_10449[:, 3])
phys_10449= pk.operations.interpolate_physio(phys_10449, 40, kind='linear')
phys_10449= pk.operations.peakfind_physio(phys_10449, thresh=0.75, dist=100)
phys_10449= pk.operations.edit_physio(phys_10449) 
pk.plot_physio (phys_10449) 
plt.show()

pk.save_physio(f'sub-10449_ses-01_task-breathhold_recording-125Hz_physio_peak_ch_co2', phys_10449)

#7033
sampling_rate=125
data_7033= np.genfromtxt('/bcbl/home/public/CVR/LANGCONN_BIDS/PHYSIO_BIDS/sub-7033/ses-01/func/sub-7033_ses-01_task-breathhold_recording-125Hz_physio.tsv.gz') 
phys_7033= pk.Physio(data_7033[:, 4], fs=125, suppdata=data_7033[:, 3])
phys_7033= pk.operations.interpolate_physio(phys_7033, 40, kind='linear')
phys_7033= pk.operations.peakfind_physio(phys_7033, thresh=0.75, dist=100)
phys_7033= pk.operations.edit_physio(phys_7033) 
pk.plot_physio (phys_7033) 
plt.show()

pk.save_physio(f'sub-7033_ses-01_task-breathhold_recording-125Hz_physio_peak_ch_co2', phys_7033)

#8994
sampling_rate=125
data_8994= np.genfromtxt('/bcbl/home/public/CVR/LANGCONN_BIDS/PHYSIO_BIDS/sub-8994/ses-01/func/sub-8994_ses-01_task-breathhold_recording-125Hz_physio.tsv.gz') 
phys_8994= pk.Physio(data_8994[:, 4], fs=125, suppdata=data_8994[:, 3])
phys_8994= pk.operations.interpolate_physio(phys_8994, 40, kind='linear')
phys_8994= pk.operations.peakfind_physio(phys_8994, thresh=0.75, dist=100)
phys_8994= pk.operations.edit_physio(phys_8994) 
pk.plot_physio (phys_8994) 
plt.show()

pk.save_physio(f'sub-8994_ses-01_task-breathhold_recording-125Hz_physio_peak_ch_co2', phys_8994)

#3145
sampling_rate=125
data_3145= np.genfromtxt('/bcbl/home/public/CVR/LANGCONN_BIDS/PHYSIO_BIDS/sub-3145/ses-01/func/sub-3145_ses-01_task-breathhold_recording-125Hz_physio.tsv.gz') 
phys_3145= pk.Physio(data_3145[:, 4], fs=125, suppdata=data_3145[:, 3])
phys_3145= pk.operations.interpolate_physio(phys_3145, 40, kind='linear')
phys_3145= pk.operations.peakfind_physio(phys_3145, thresh=0.75, dist=100)
phys_3145= pk.operations.edit_physio(phys_3145) 
pk.plot_physio (phys_3145) 
plt.show()

pk.save_physio(f'sub-3145_ses-01_task-breathhold_recording-125Hz_physio_peak_ch_co2', phys_3145)

#LUCIA
sampling_rate=125
data_LUCIA= np.genfromtxt('/bcbl/home/public/CVR/LANGCONN_BIDS/PHYSIO_BIDS/sub-LUCIA/ses-01/func/sub-LUCIA_ses-01_task-breathhold_recording-125Hz_physio.tsv.gz') 
phys_LUCIA= pk.Physio(data_LUCIA[:, 4], fs=125, suppdata=data_LUCIA[:, 3])
phys_LUCIA= pk.operations.interpolate_physio(phys_LUCIA, 40, kind='linear')
phys_LUCIA= pk.operations.peakfind_physio(phys_LUCIA, thresh=0.75, dist=100)
phys_LUCIA= pk.operations.edit_physio(phys_LUCIA) 
pk.plot_physio (phys_LUCIA) 
plt.show()

pk.save_physio(f'sub-LUCIA_ses-01_task-breathhold_recording-125Hz_physio_peak_ch_co2', phys_LUCIA)

#5932
sampling_rate=125
data_5932= np.genfromtxt('/bcbl/home/public/CVR/LANGCONN_BIDS/PHYSIO_BIDS/sub-5932/ses-01/func/sub-5932_ses-01_task-breathhold_recording-125Hz_physio.tsv.gz') 
phys_5932= pk.Physio(data_5932[:, 4], fs=125, suppdata=data_5932[:, 3])
phys_5932= pk.operations.interpolate_physio(phys_5932, 40, kind='linear')
phys_5932= pk.operations.peakfind_physio(phys_5932, thresh=0.75, dist=100)
phys_5932= pk.operations.edit_physio(phys_5932) 
pk.plot_physio (phys_5932) 
plt.show()

pk.save_physio(f'sub-5932_ses-01_task-breathhold_recording-125Hz_physio_peak_ch_co2', phys_5932)

#9969
sampling_rate=125
data_9969= np.genfromtxt('/bcbl/home/public/CVR/LANGCONN_BIDS/PHYSIO_BIDS/sub-9969/ses-01/func/sub-9969_ses-01_task-breathhold_recording-125Hz_physio.tsv.gz') 
phys_9969= pk.Physio(data_9969[:, 4], fs=125, suppdata=data_9969[:, 3])
phys_9969= pk.operations.interpolate_physio(phys_9969, 40, kind='linear')
phys_9969= pk.operations.peakfind_physio(phys_9969, thresh=0.75, dist=100)
phys_9969= pk.operations.edit_physio(phys_9969) 
pk.plot_physio (phys_9969) 
plt.show()

pk.save_physio(f'sub-9969_ses-01_task-breathhold_recording-125Hz_physio_peak_ch_co2', phys_9969)

#8808
sampling_rate=125
data_8808= np.genfromtxt('/bcbl/home/public/CVR/LANGCONN_BIDS/PHYSIO_BIDS/sub-8808/ses-032/func/sub-8808_ses-032_task-breathhold_recording-125Hz_physio.tsv.gz') 
phys_8808= pk.Physio(data_8808[:, 4], fs=125, suppdata=data_8808[:, 3])
phys_8808= pk.operations.interpolate_physio(phys_8808, 40, kind='linear')
phys_8808= pk.operations.peakfind_physio(phys_8808, thresh=0.75, dist=100)
phys_8808= pk.operations.edit_physio(phys_8808) 
pk.plot_physio (phys_8808) 
plt.show()

pk.save_physio(f'sub-8808_ses-032_task-breathhold_recording-125Hz_physio_peak_ch_co2', phys_8808)

#6084
sampling_rate=125
data_6084= np.genfromtxt('/bcbl/home/public/CVR/LANGCONN_BIDS/PHYSIO_BIDS/sub-6084/ses-033/func/sub-6084_ses-033_task-breathhold_recording-125Hz_physio.tsv.gz') 
phys_6084= pk.Physio(data_6084[:, 4], fs=125, suppdata=data_6084[:, 3])
phys_6084= pk.operations.interpolate_physio(phys_6084, 40, kind='linear')
phys_6084= pk.operations.peakfind_physio(phys_6084, thresh=0.75, dist=100)
phys_6084= pk.operations.edit_physio(phys_6084) 
pk.plot_physio (phys_6084) 
plt.show()

pk.save_physio(f'sub-6084_ses-033_task-breathhold_recording-125Hz_physio_peak_ch_co2', phys_6084)

#5820
sampling_rate=125
data_5820= np.genfromtxt('/bcbl/home/public/CVR/LANGCONN_BIDS/PHYSIO_BIDS/sub-5820/ses-042/func/sub-5820_ses-042_task-breathhold_recording-125Hz_physio.tsv.gz') 
phys_5820= pk.Physio(data_5820[:, 4], fs=125, suppdata=data_5820[:, 3])
phys_5820= pk.operations.interpolate_physio(phys_5820, 40, kind='linear')
phys_5820= pk.operations.peakfind_physio(phys_5820, thresh=0.75, dist=100)
phys_5820= pk.operations.edit_physio(phys_5820) 
pk.plot_physio (phys_5820) 
plt.show()

pk.save_physio(f'sub-5820_ses-042_task-breathhold_recording-125Hz_physio_peak_ch_co2', phys_5820)

#7721
sampling_rate=125
data_7721= np.genfromtxt('/bcbl/home/public/CVR/LANGCONN_BIDS/PHYSIO_BIDS/sub-7721/ses-043/func/sub-7721_ses-043_task-breathhold_recording-125Hz_physio.tsv.gz') 
phys_7721= pk.Physio(data_7721[:, 4], fs=125, suppdata=data_7721[:, 3])
phys_7721= pk.operations.interpolate_physio(phys_7721, 40, kind='linear')
phys_7721= pk.operations.peakfind_physio(phys_7721, thresh=0.75, dist=100)
phys_7721= pk.operations.edit_physio(phys_7721) 
pk.plot_physio (phys_7721) 
plt.show()

pk.save_physio(f'sub-7721_ses-043_task-breathhold_recording-125Hz_physio_peak_ch_co2', phys_7721)

data_7721=pk.load_physio('sub-7721_ses-043_task-breathhold_recording-125Hz_physio_peak_ch_co2.phys', allow_pickle=True)
data_7721= pk.operations.edit_physio(data_7721)
pk.plot_physio (data_7721)
plt.show()
pk.save_physio(f'sub-7721_ses-043_task-breathhold_recording-125Hz_physio_peak_ch_co2', data_7721)

#522
sampling_rate=125
data_522= np.genfromtxt('/bcbl/home/public/CVR/LANGCONN_BIDS/PHYSIO_BIDS/sub-522/ses-01/func/sub-522_ses-01_task-breathhold_recording-125Hz_physio.tsv.gz') 
phys_522= pk.Physio(data_522[:, 4], fs=125, suppdata=data_522[:, 3])
phys_522= pk.operations.interpolate_physio(phys_522, 40, kind='linear')
phys_522= pk.operations.peakfind_physio(phys_522, thresh=0.75, dist=100)
phys_522= pk.operations.edit_physio(phys_522) 
pk.plot_physio (phys_522) 
plt.show()

pk.save_physio(f'sub-522_ses-01_task-breathhold_recording-125Hz_physio_peak_ch_co2', phys_522)

