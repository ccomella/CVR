
#Peakdet Presurgical SCRIPTS
#Autor: Cristina Comella


#Peakdet
import numpy as np
import peakdet as pk
import matplotlib.pyplot as plt

#01
sampling_rate=125
data_01= np.genfromtxt('/bcbl/home/public/CVR/PRESURGICAL_BIDS/Physio_BIDS/sub-01/func/sub-01_task-breathhold_recording-125Hz_physio.tsv.gz') 
phys_01= pk.Physio(data_01[:, 4], fs=125, suppdata=data_01[:, 3])
phys_01= pk.operations.interpolate_physio(phys_01, 40, kind='linear')
phys_01= pk.operations.peakfind_physio(phys_01, thresh=0.5, dist=110)
phys_01= pk.operations.edit_physio(phys_01)
pk.plot_physio (phys_01)
plt.show()

pk.save_physio(f'sub-01_task-breathhold_recording-125Hz_physio_peak_ch-co2', phys_01)

data=pk.load_physio('sub-01_task-breathhold_recording-125Hz_physio_peak_ch-co2.phys', allow_pickle=True)
data= pk.operations.edit_physio(data)
pk.plot_physio (data)
plt.show()


#046
sampling_rate=125
data_046= np.genfromtxt('/bcbl/home/public/CVR/PRESURGICAL_BIDS/Physio_BIDS/sub-046/func/sub-046_task-breathhold_recording-125Hz_physio.tsv.gz') 
phys_046= pk.Physio(data_046[:, 4], fs=125, suppdata=data_046[:, 3])
phys_046= pk.operations.interpolate_physio(phys_046, 40, kind='linear')
phys_046= pk.operations.peakfind_physio(phys_046, thresh=0.5, dist=110)
phys_046= pk.operations.edit_physio(phys_046)
pk.plot_physio (phys_046)
plt.show()

pk.save_physio(f'sub-046_task-breathhold_recording-125Hz_physio_peak_ch-co2', phys_046)

data=pk.load_physio('sub-046_task-breathhold_recording-125Hz_physio_peak_ch-co2.phys', allow_pickle=True)
data= pk.operations.edit_physio(data)
pk.plot_physio (data)
plt.show()

pk.save_physio(f'sub-046_task-breathhold_recording-125Hz_physio_peak_ch-co2', data)


#048 (see it with Stefano and Cesar, didn't save it)
sampling_rate=125
data_048= np.genfromtxt('/bcbl/home/public/CVR/PRESURGICAL_BIDS/Physio_BIDS/sub-048/func/sub-048_task-breathhold_recording-125Hz_physio.tsv.gz') 
phys_048= pk.Physio(data_048[:, 5], fs=125, suppdata=data_048[:, 4])
phys_048= pk.operations.interpolate_physio(phys_048, 40, kind='linear')
phys_048= pk.operations.peakfind_physio(phys_048, thresh=0.5, dist=110)
phys_048= pk.operations.edit_physio(phys_048)
pk.plot_physio (phys_048)
plt.show()

pk.save_physio(f'sub-048_task-breathhold_recording-125Hz_physio_peak_ch-co2', phys_048)

data=pk.load_physio('sub-048_task-breathhold_recording-125Hz_physio_peak_ch-co2.phys', allow_pickle=True)
data pk.operations.edit_physio(data)
pk.plot_physio (data)
plt.show()


#050
sampling_rate=125
data_050= np.genfromtxt('/bcbl/home/public/CVR/PRESURGICAL_BIDS/Physio_BIDS/sub-050/func/sub-050_task-breathhold_recording-125Hz_physio.tsv.gz') 
phys_050= pk.Physio(data_050[:, 4], fs=125, suppdata=data_050[:, 3])
phys_050= pk.operations.interpolate_physio(phys_050, 40, kind='linear')
phys_050= pk.operations.peakfind_physio(phys_050, thresh=0.5, dist=110)
phys_050= pk.operations.edit_physio(phys_050)
pk.plot_physio (phys_050)
plt.show()

pk.save_physio(f'sub-050_task-breathhold_recording-125Hz_physio_peak_ch-co2', phys_050)

data=pk.load_physio('sub-048_task-breaexthhold_recording-125Hz_physio_peak_ch-co2.phys', allow_pickle=True)
data pk.operations.edit_physio(data)
pk.plot_physio (data)
plt.show()
data=pk.load_physio('sub-050_task-breathhold_recording-125Hz_physio_peak_ch-co2.phys', allow_pickle=True)
data= pk.operations.edit_physio(data)
pk.plot_physio (data)
plt.show()

pk.save_physio(f'sub-050_task-breathhold_recording-125Hz_physio_peak_ch-co2', data)


#051
sampling_rate=125
data_051= np.genfromtxt('/bcbl/home/public/CVR/PRESURGICAL_BIDS/Physio_BIDS/sub-051/func/sub-051_task-breathhold_recording-125Hz_physio.tsv.gz') 
phys_051= pk.Physio(data_051[:, 4], fs=125, suppdata=data_051[:, 3])
phys_051= pk.operations.interpolate_physio(phys_051, 40, kind='linear')
phys_051= pk.operations.peakfind_physio(phys_051, thresh=0.5, dist=110)
phys_051= pk.operations.edit_physio(phys_051)
pk.plot_physio (phys_051)
plt.show()

pk.save_physio(f'sub-051_task-breathhold_recording-125Hz_physio_peak_ch-co2', phys_051)

data=pk.load_physio('sub-051_task-breathhold_recording-125Hz_physio_peak_ch-co2.phys', allow_pickle=True)
data= pk.operations.edit_physio(data)
pk.plot_physio (data)
plt.show()

pk.save_physio(f'sub-051_task-breathhold_recording-125Hz_physio_peak_ch-co2', data)

#052
sampling_rate=125
data_052= np.genfromtxt('/bcbl/home/public/CVR/PRESURGICAL_BIDS/Physio_BIDS/sub-052/func/sub-052_task-breathhold_recording-125Hz_physio.tsv.gz') 
phys_052= pk.Physio(data_052[:, 4], fs=125, suppdata=data_052[:, 3])
phys_052= pk.operations.interpolate_physio(phys_052, 40, kind='linear')
phys_052= pk.operations.peakfind_physio(phys_052, thresh=0.5, dist=110)
phys_052= pk.operations.edit_physio(phys_052)
pk.plot_physio (phys_052)
plt.show()

pk.save_physio(f'sub-052_task-breathhold_recording-125Hz_physio_peak_ch-co2', phys_052)

data=pk.load_physio('sub-052_task-breathhold_recording-125Hz_physio_peak_ch-co2.phys', allow_pickle=True)
data= pk.operations.edit_physio(data)
pk.plot_physio (data)
plt.show()

pk.save_physio(f'sub-052_task-breathhold_recording-125Hz_physio_peak_ch-co2', data)

#054
sampling_rate=125
data_054= np.genfromtxt('/bcbl/home/public/CVR/PRESURGICAL_BIDS/Physio_BIDS/sub-054/func/sub-054_task-breathhold_recording-125Hz_physio.tsv.gz') 
phys_054= pk.Physio(data_054[:, 4], fs=125, suppdata=data_054[:, 3])
phys_054= pk.operations.interpolate_physio(phys_054, 40, kind='linear')
phys_054= pk.operations.peakfind_physio(phys_054, thresh=0.5, dist=110)
phys_054= pk.operations.edit_physio(phys_054)
pk.plot_physio (phys_054)
plt.show()

pk.save_physio(f'sub-054_task-breathhold_recording-125Hz_physio_peak_ch-co2', phys_054)


data=pk.load_physio('sub-054_task-breathhold_recording-125Hz_physio_peak_ch-co2.phys', allow_pickle=True)
data= pk.operations.edit_physio(data)
pk.plot_physio (data)
plt.show()

pk.save_physio(f'sub-054_task-breathhold_recording-125Hz_physio_peak_ch-co2', data)

#055
sampling_rate=125
data_055= np.genfromtxt('/bcbl/home/public/CVR/PRESURGICAL_BIDS/Physio_BIDS/sub-055/func/sub-055_task-breathhold_recording-125Hz_physio.tsv.gz') 
phys_055= pk.Physio(data_055[:, 5], fs=125, suppdata=data_055[:, 3])
phys_055= pk.operations.interpolate_physio(phys_055, 40, kind='linear')
phys_055= pk.operations.peakfind_physio(phys_055, thresh=0.5, dist=110)
phys_055= pk.operations.edit_physio(phys_055)
pk.plot_physio (phys_055)
plt.show()

pk.save_physio(f'sub-055_task-breathhold_recording-125Hz_physio_peak_ch-co2', phys_055)

data=pk.load_physio('sub-055_task-breathhold_recording-125Hz_physio_peak_ch-co2.phys', allow_pickle=True)
data= pk.operations.edit_physio(data)
pk.plot_physio (data)
plt.show()

pk.save_physio(f'sub-055_task-breathhold_recording-125Hz_physio_peak_ch-co2', data)

#056
sampling_rate=125
data_056= np.genfromtxt('/bcbl/home/public/CVR/PRESURGICAL_BIDS/Physio_BIDS/sub-056/func/sub-056_task-breathhold_recording-125Hz_physio.tsv.gz') 
phys_056= pk.Physio(data_056[:, 4], fs=125, suppdata=data_056[:, 3])
phys_056= pk.operations.interpolate_physio(phys_056, 40, kind='linear')
phys_056= pk.operations.peakfind_physio(phys_056, thresh=0.5, dist=110)
phys_056= pk.operations.edit_physio(phys_056)
pk.plot_physio (phys_056)
plt.show()

pk.save_physio(f'sub-056_task-breathhold_recording-125Hz_physio_peak_ch-co2', phys_056)

data=pk.load_physio('sub-056_task-breathhold_recording-125Hz_physio_peak_ch-co2.phys', allow_pickle=True)
data= pk.operations.edit_physio(data)
pk.plot_physio (data)
plt.show()

pk.save_physio(f'sub-056_task-breathhold_recording-125Hz_physio_peak_ch-co2', data)

#057
sampling_rate=125
data_057= np.genfromtxt('/bcbl/home/public/CVR/PRESURGICAL_BIDS/Physio_BIDS/sub-057/func/sub-057_task-breathhold_recording-125Hz_physio.tsv.gz') 
phys_057= pk.Physio(data_057[:, 4], fs=125, suppdata=data_057[:, 3])
phys_057= pk.operations.interpolate_physio(phys_057, 40, kind='linear')
phys_057= pk.operations.peakfind_physio(phys_057, thresh=0.5, dist=110)
phys_057= pk.operations.edit_physio(phys_057)
pk.plot_physio (phys_057)
plt.show()

pk.save_physio(f'sub-057_task-breathhold_recording-125Hz_physio_peak_ch-co2', phys_057)

data=pk.load_physio('sub-057_task-breathhold_recording-125Hz_physio_peak_ch-co2.phys', allow_pickle=True)
data= pk.operations.edit_physio(data)
pk.plot_physio (data)
plt.show()

pk.save_physio(f'sub-057_task-breathhold_recording-125Hz_physio_peak_ch-co2', data)

#058
sampling_rate=125
data_058= np.genfromtxt('/bcbl/home/public/CVR/PRESURGICAL_BIDS/Physio_BIDS/sub-058/func/sub-058_task-breathhold_recording-125Hz_physio.tsv.gz') 
phys_058= pk.Physio(data_058[:, 4], fs=125, suppdata=data_058[:, 3])
phys_058= pk.operations.interpolate_physio(phys_058, 40, kind='linear')
phys_058= pk.operations.peakfind_physio(phys_058, thresh=0.5, dist=110)
phys_058= pk.operations.edit_physio(phys_058)
pk.plot_physio (phys_058)
plt.show()

pk.save_physio(f'sub-058_task-breathhold_recording-125Hz_physio_peak_ch-co2', phys_058)

data=pk.load_physio('sub-058_task-breathhold_recording-125Hz_physio_peak_ch-co2.phys', allow_pickle=True)
data_7721= pk.operations.edit_physio(data)
pk.plot_physio (data)
plt.show()

#47
sampling_rate=125
data_47= np.genfromtxt('/bcbl/home/public/CVR/PRESURGICAL_BIDS/Physio_BIDS/sub-47/func/sub-47_task-breathhold_recording-125Hz_physio.tsv.gz') 
phys_47= pk.Physio(data_47[:, 5], fs=125, suppdata=data_47[:, 3])
phys_47= pk.operations.interpolate_physio(phys_47, 40, kind='linear')
phys_47= pk.operations.peakfind_physio(phys_47, thresh=0.5, dist=110)
phys_47= pk.operations.edit_physio(phys_47)
pk.plot_physio (phys_47)
plt.show()

pk.save_physio(f'sub-47_task-breathhold_recording-125Hz_physio_peak_ch-co2', phys_47)

data=pk.load_physio('sub-47_task-breathhold_recording-125Hz_physio_peak_ch-co2.phys', allow_pickle=True)
data= pk.operations.edit_physio(data)
pk.plot_physio (data)
plt.show()

pk.save_physio(f'sub-47_task-breathhold_recording-125Hz_physio_peak_ch-co2', data)

#49
sampling_rate=125
data_49= np.genfromtxt('/bcbl/home/public/CVR/PRESURGICAL_BIDS/Physio_BIDS/sub-49/func/sub-49_task-breathhold_recording-125Hz_physio.tsv.gz') 
phys_49= pk.Physio(data_49[:, 5], fs=125, suppdata=data_49[:, 3])
phys_49= pk.operations.interpolate_physio(phys_49, 40, kind='linear')
phys_49= pk.operations.peakfind_physio(phys_49, thresh=0.5, dist=110)
phys_49= pk.operations.edit_physio(phys_49)
pk.plot_physio (phys_49)
plt.show()

pk.save_physio(f'sub-49_task-breathhold_recording-125Hz_physio_peak_ch-co2', phys_49)

data=pk.load_physio('sub-49_task-breathhold_recording-125Hz_physio_peak_ch-co2.phys', allow_pickle=True)
data= pk.operations.edit_physio(data)
pk.plot_physio (data)
plt.show()

pk.save_physio(f'sub-49_task-breathhold_recording-125Hz_physio_peak_ch-co2', data)

#53
sampling_rate=125
data_53= np.genfromtxt('/bcbl/home/public/CVR/PRESURGICAL_BIDS/Physio_BIDS/sub-53/func/sub-53_task-breathhold_recording-125Hz_physio.tsv.gz') 
phys_53= pk.Physio(data_53[:, 4], fs=125, suppdata=data_53[:, 3])
phys_53= pk.operations.interpolate_physio(phys_53, 40, kind='linear')
phys_53= pk.operations.peakfind_physio(phys_53, thresh=0.5, dist=110)
phys_53= pk.operations.edit_physio(phys_53)
pk.plot_physio (phys_53)
plt.show()

pk.save_physio(f'sub-53_task-breathhold_recording-125Hz_physio_peak_ch-co2', phys_53)

data=pk.load_physio('sub-53_task-breathhold_recording-125Hz_physio_peak_ch-co2.phys', allow_pickle=True)
data= pk.operations.edit_physio(data)
pk.plot_physio (data)
plt.show()

pk.save_physio(f'sub-53_task-breathhold_recording-125Hz_physio_peak_ch-co2', data)


#059
sampling_rate=125
data_059= np.genfromtxt('/bcbl/home/public/CVR/PRESURGICAL_BIDS/Physio_BIDS/sub-059/func/sub-059_task-breathhold_recording-125Hz_physio.tsv.gz') 
phys_059= pk.Physio(data_059[:, 4], fs=125, suppdata=data_059[:, 3])
phys_059= pk.operations.interpolate_physio(phys_059, 40, kind='linear')
phys_059= pk.operations.peakfind_physio(phys_059, thresh=0.5, dist=110)
phys_059= pk.operations.edit_physio(phys_059)
pk.plot_physio (phys_059)
plt.show()

pk.save_physio(f'sub-059_task-breathhold_recording-125Hz_physio_peak_ch-co2', phys_059)

data=pk.load_physio('sub-059_task-breathhold_recording-125Hz_physio_peak_ch-co2.phys', allow_pickle=True)
data= pk.operations.edit_physio(data)
pk.plot_physio (data)
plt.show()

#060
sampling_rate=125
data_060= np.genfromtxt('/bcbl/home/public/CVR/PRESURGICAL_BIDS/Physio_BIDS/sub-060/func/sub-060_task-breathhold_recording-125Hz_physio.tsv.gz') 
phys_060= pk.Physio(data_060[:, 4], fs=125, suppdata=data_060[:, 3])
phys_060= pk.operations.interpolate_physio(phys_060, 40, kind='linear')
phys_060= pk.operations.peakfind_physio(phys_060, thresh=0.5, dist=110)
phys_060= pk.operations.edit_physio(phys_060)
pk.plot_physio (phys_060)
plt.show()

pk.save_physio(f'sub-060_task-breathhold_recording-125Hz_physio_peak_ch-co2', phys_060)

data=pk.load_physio('sub-060_task-breathhold_recording-125Hz_physio_peak_ch-co2.phys', allow_pickle=True)
data= pk.operations.edit_physio(data)
pk.plot_physio (data)
plt.show()


#061
sampling_rate=125
data_061= np.genfromtxt('/bcbl/home/public/CVR/PRESURGICAL_BIDS/Physio_BIDS/sub-061/func/sub-061_task-breathhold_recording-125Hz_physio.tsv.gz') 
phys_061= pk.Physio(data_061[:, 4], fs=125, suppdata=data_061[:, 3])
phys_061= pk.operations.interpolate_physio(phys_061, 40, kind='linear')
phys_061= pk.operations.peakfind_physio(phys_061, thresh=0.5, dist=110)
phys_061= pk.operations.edit_physio(phys_061)
pk.plot_physio (phys_061)
plt.show()

pk.save_physio(f'sub-061_task-breathhold_recording-125Hz_physio_peak_ch-co2', phys_061)

data=pk.load_physio('sub-061_task-breathhold_recording-125Hz_physio_peak_ch-co2.phys', allow_pickle=True)
data= pk.operations.edit_physio(data)
pk.plot_physio (data)
plt.show()


#062
sampling_rate=125
data_062= np.genfromtxt('/bcbl/home/public/CVR/PRESURGICAL_BIDS/Physio_BIDS/sub-062/func/sub-062_task-breathhold_recording-125Hz_physio.tsv.gz') 
phys_062= pk.Physio(data_062[:, 4], fs=125, suppdata=data_062[:, 3])
phys_062= pk.operations.interpolate_physio(phys_062, 40, kind='linear')
phys_062= pk.operations.peakfind_physio(phys_062, thresh=0.5, dist=110)
phys_062= pk.operations.edit_physio(phys_062)
pk.plot_physio (phys_062)
plt.show()

pk.save_physio(f'sub-062_task-breathhold_recording-125Hz_physio_peak_ch-co2', phys_062)

data=pk.load_physio('sub-062_task-breathhold_recording-125Hz_physio_peak_ch-co2.phys', allow_pickle=True)
data= pk.operations.edit_physio(data)
pk.plot_physio (data)
plt.show()


#063, didnt save it
sampling_rate=125
data_063= np.genfromtxt('/bcbl/home/public/CVR/PRESURGICAL_BIDS/Physio_BIDS/sub-063/func/sub-063_task-breathhold_recording-125Hz_physio.tsv.gz') 
phys_063= pk.Physio(data_063[:, 4], fs=125, suppdata=data_063[:, 3])
phys_063= pk.operations.interpolate_physio(phys_063, 40, kind='linear')
phys_063= pk.operations.peakfind_physio(phys_063, thresh=0.5, dist=110)
phys_063= pk.operations.edit_physio(phys_063)
pk.plot_physio (phys_063)
plt.show()

pk.save_physio(f'sub-063_task-breathhold_recording-125Hz_physio_peak_ch-co2', phys_063)

data=pk.load_physio('sub-063_task-breathhold_recording-125Hz_physio_peak_ch-co2.phys', allow_pickle=True)
data= pk.operations.edit_physio(data)
pk.plot_physio (data)
plt.show()

#064, verlo otravez
sampling_rate=125
data_064= np.genfromtxt('/bcbl/home/public/CVR/PRESURGICAL_BIDS/Physio_BIDS/sub-064/func/sub-064_task-breathhold_recording-125Hz_physio.tsv.gz') 
phys_064= pk.Physio(data_064[:, 4], fs=125, suppdata=data_064[:, 3])
phys_064= pk.operations.interpolate_physio(phys_064, 40, kind='linear')
phys_064= pk.operations.peakfind_physio(phys_064, thresh=0.5, dist=110)
phys_064= pk.operations.edit_physio(phys_064)
pk.plot_physio (phys_064)
plt.show()

pk.save_physio(f'sub-064_task-breathhold_recording-125Hz_physio_peak_ch-co2', phys_064)

data=pk.load_physio('sub-064_task-breathhold_recording-125Hz_physio_peak_ch-co2.phys', allow_pickle=True)
data= pk.operations.edit_physio(data)
pk.plot_physio (data)
plt.show()

#Sub 065
sampling_rate=125
data_065= np.genfromtxt('/bcbl/home/public/CVR/PRESURGICAL_BIDS/Physio_BIDS/sub-065/func/sub-065_task-breathhold_recording-125Hz_physio.tsv.gz') 
phys_065= pk.Physio(data_065[:, 4], fs=125, suppdata=data_065[:, 3])
phys_065= pk.operations.interpolate_physio(phys_065, 40, kind='linear')
phys_065= pk.operations.peakfind_physio(phys_065, thresh=0.5, dist=110)
phys_065= pk.operations.edit_physio(phys_065)
pk.plot_physio (phys_065)
plt.show()

pk.save_physio(f'sub-065_task-breathhold_recording-125Hz_physio_peak_ch-co2', phys_065)

data=pk.load_physio('sub-065_task-breathhold_recording-125Hz_physio_peak_ch-co2.phys', allow_pickle=True)
data= pk.operations.edit_physio(data)
pk.plot_physio (data)
plt.show()

#Sub 066, bad BH not save it
sampling_rate=125
data_066= np.genfromtxt('/bcbl/home/public/CVR/PRESURGICAL_BIDS/Physio_BIDS/sub-066/func/sub-066_task-breathhold_recording-125Hz_physio.tsv.gz') 
phys_066= pk.Physio(data_066[:, 5], fs=125, suppdata=data_066[:, 4])
phys_066= pk.operations.interpolate_physio(phys_066, 40, kind='linear')
phys_066= pk.operations.peakfind_physio(phys_066, thresh=0.5, dist=110)
phys_066= pk.operations.edit_physio(phys_066)
pk.plot_physio (phys_066)
plt.show()

pk.save_physio(f'sub-066_task-breathhold_recording-125Hz_physio_peak_ch-co2', phys_066)

data=pk.load_physio('sub-066_task-breathhold_recording-125Hz_physio_peak_ch-co2.phys', allow_pickle=True)
data= pk.operations.edit_physio(data)
pk.plot_physio (data)
plt.show()


#Sub 067, bad BH not save it
sampling_rate=125
data_067= np.genfromtxt('/bcbl/home/public/CVR/PRESURGICAL_BIDS/Physio_BIDS/sub-067/func/sub-067_task-breathhold_recording-125Hz_physio.tsv.gz') 
phys_067= pk.Physio(data_067[:, 4], fs=125, suppdata=data_067[:, 3])
phys_067= pk.operations.interpolate_physio(phys_067, 40, kind='linear')
phys_067= pk.operations.peakfind_physio(phys_067, thresh=0.5, dist=110)
phys_067= pk.operations.edit_physio(phys_067)
pk.plot_physio (phys_067)
plt.show()

pk.save_physio(f'sub-067_task-breathhold_recording-125Hz_physio_peak_ch-co2', phys_067)

data=pk.load_physio('sub-067_task-breathhold_recording-125Hz_physio_peak_ch-co2.phys', allow_pickle=True)
data= pk.operations.edit_physio(data)
pk.plot_physio (data)
plt.show()


pk.save_physio(f'sub-067_task-breathhold_recording-125Hz_physio_peak_ch-co2', data)