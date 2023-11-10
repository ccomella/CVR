#!/bin/bash
######### PHYS2BIDS in BIPLAS Folder
# Author:  Cristina Comella
# Version: 1.0
# Date:    22.12.2022
#Script organized but not run 

#Enter the Cluster (GIT is install in it)
ssh -X ips-0-3
 qlogin
module load python/venv #To activate python
source activate /bcbl/home/public/CVR/py_3.9 #my environment
cd public/CVR 

#To obtain the .png from the acq files to see the plots 
biplas = "/bcbl/home/public/CVR/Scripts/BIPLAS.txt"
lines=($(cat $biplas)) 
for variable in ${lines[*]}
do
  phys2bids -in $variable -indir "/bcbl/home/public/CVR/BIPLAS_BIDS/BIPLAS_PHYSIO_FOLDER" -outdir "/bcbl/home/public/CVR/BIPLAS_BIDS/channel_images"  
done


#Split the .acq files to obtain just BH 
#Take into account that it has to be in the master in the physiopy
biplas ="/bcbl/home/public/CVR/BIPLAS_BIDS/BIPLAS_PHYSIO_BIDS.txt" #Not al of them because it is another txt
lines=($(cat $biplas)) 
for variable in ${lines[*]}
do
  phys2bids -in $variable -indir "/bcbl/home/public/CVR/BIPLAS_BIDS/BIPLAS_PHYSIO_FOLDER" -chtrig 1 -ntp 340 -tr 1.5 -outdir "/bcbl/home/public/CVR/BIPLAS_BIDS/Split_Files"
done