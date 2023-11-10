#!/bin/bash
######### PHYS2BIDS in BIPLAS Folder
# Author:  Cristina Comella
# Version: 1.0
# Date:    22.12.2022

#Enter the Cluster (GIT is install in it)
ssh -X ips-0-3
 qlogin
module load python/venv #To activate python
source activate /bcbl/home/public/CVR/py_3.9 #my environment
cd public/CVR 

#Install Phys2bids
git clone https://github.com/ccomella/phys2bids.git #Install has origin
cd phys2bids #enter to phys2bids
git remote add smoia https://github.com/smoia/phys2bids.git #Install smoia phys2bids
git remote add upstream https://github.com/physiopy/phys2bids.git #Install as upstream physiopy
git fetch --all #
#Add and change to the branch 

#GIT
git remote -v #List all currently configured remote repositories 
git status # List the files you've changed and those you still need to add or commit
git checkout -B cristina smoia/cristina

#To obtain the .png from the acq files to see the plots 
biplas = "/bcbl/home/public/CVR/Scripts/BIPLAS.txt"
lines=($(cat $biplas)) 
for variable in ${lines[*]}
do
  phys2bids -in $variable -indir "/bcbl/home/public/CVR/BIPLAS_BIDS/BIPLAS_PHYSIO_FOLDER" -outdir "/bcbl/home/public/CVR/BIPLAS_BIDS/channel_images"  
done

lan="/bcbl/home/public/CVR/Scripts/Langconn_Physio.txt"
lines_2=($(cat $lan))
for variable_2 in ${lines_2[*]}
do
  phys2bids -in $variable_2 -indir "/bcbl/home/public/CVR/LANGCONN2_BIDS/PHYSIO" -outdir "/bcbl/home/public/CVR/LANGCONN2_BIDS/channel_images"   
done


pre="/bcbl/home/public/CVR/Scripts/Presurgical.txt"
lines_3=($(cat $pre))
for variable_3 in ${lines_3[*]}
do 
   phys2bids -in $variable_3 -indir "/bcbl/home/public/CVR/PRESURGICAL_BH_FOLDERS/PHYSIO" -outdir "/bcbl/home/public/CVR/PRESURGICAL_BH_FOLDERS/channel_images"   
done

#Split the .acq files to obtain just BH 
#Take into account that it has to be in the master in the physiopy
biplas ="/bcbl/home/public/CVR/BIPLAS_BIDS/BIPLAS_PHYSIO_BIDS.txt" #Not al of them because it is another txt
lines=($(cat $biplas)) 
for variable in ${lines[*]}
do
  phys2bids -in $variable -indir "/bcbl/home/public/CVR/BIPLAS_BIDS/BIPLAS_PHYSIO_FOLDER" -chtrig 1 -ntp 340 -tr 1.5 -outdir "/bcbl/home/public/CVR/BIPLAS_BIDS/Split_Files"
done

lan="/bcbl/home/public/CVR/Scripts/Langconn_Physio.txt"
subject_lan=($(cat $lan))
for l in ${subject_lan[*]}
do
  phys2bids -in $l -indir "/bcbl/home/public/CVR/LANGCONN_BIDS/PHYSIO" -chtrig 1 -ntp 340 -tr 1.5 -outdir "/bcbl/home/public/CVR/LANGCONN_BIDS/Split_Files"
done


pre="/bcbl/home/public/CVR/Scripts/Presurgical.txt"
subject_pre=($(cat $pre))
for p in ${subject_pre[*]}
do
  phys2bids -in $p -indir "/bcbl/home/public/CVR/PRESURGICAL_BH_FOLDERS/PHYSIO" -chtrig 1 -ntp 340 -tr 1.5 -outdir "/bcbl/home/public/CVR/PRESURGICAL_BH_FOLDERS/Split_Files"  
done

#To obtain sub and ses of biplas in 1 subject
for f in 01_BIPLAS_10523.acq
do fne=${f%.acq}
  dat=(${fne//_/ })
  phys2bids -in $f -indir "/bcbl/home/public/CVR/BIPLAS_BIDS/BIPLAS_PHYSIO_FOLDER" -chtrig 1 -ntp 340 3758 -tr 1.5 -pad 15 -outdir "/bcbl/home/public/CVR/BIPLAS_BIDS/Example_1" -heur /bcbl/home/public/CVR/Scripts/heur_biplas.py -sub ${dat[2]} -ses ${dat[0]} 
done


#Encontrar NTP Discard de 1 especifico SIRVE
subject=$(find /bcbl/home/public/CVR/BIPLAS_BIDS/Split_Files/code/conversion -type f -name '*010_BIPLAS_10487_2_125Hz.log')
n=$(grep "Timepoints found" $subject)
NTP_END=$(echo $n | tr -dc '0-9')
NTP_BH=340
NTP_DISCARD=$(echo "${NTP_END} - ${NTP_BH}" | bc)
echo $NTP_DISCARD

#Encontrar todos BIPLAS en carpeta Physio_Bids
biplas="/bcbl/home/public/CVR/BIPLAS_BIDS/BIPLAS_PHYSIO_BIDS.txt"
subject=($(cat $biplas)) 
NTP_BH=340
for f in ${subject[*]} 
do pre="/bcbl/home/public/CVR/Scripts/Presurgical.txt"
subject_pre=($(cat $pre))

presurgical=biplas="/bcbl/home/public/CVR/PRESURGICAL_BIDS/PRESURGICAL_PHYSIO_BIDS.txt"
for p in ${subject_pre[*]}
  do
  phys2bids -in $p -indir "/bcbl/home/public/CVR/PRESURGICAL_BH_FOLDERS/PHYSIO" -chtrig 1 -ntp 340 -tr 1.5 -outdir "/bcbl/home/public/CVR/PRESURGICAL_BH_FOLDERS/Split_Files"  
  fne=${f%.acq}
  dat=(${fne//_/ })
  echo "Processing $f"
  subject_total= $(find /bcbl/home/public/CVR/BIPLAS_BIDS/Split_Files/code/pre="/bcbl/home/public/CVR/Scripts/Presurgical.txt")
done




for f in 056_PresurgicaL_JH.acq
 do 
  fne=${f%.acq}
  dat=(${fne//_/ })
  echo "Processing $f"
  subject=$(find /bcbl/home/public/CVR/PRESURGICAL_BIDS/Split_Files/code/conversion -type f -name "056_PresurgicaL_JH_125Hz.log")
  n=$(grep "Timepoints found" $subject)
  NTP_END=$(echo $n | tr -dc '0-9')
  NTP_DISCARD=$(echo "${NTP_END} - ${NTP_BH}" | bc)
  phys2bids -in $fne -indir "/bcbl/home/public/CVR/PRESURGICAL_BIDS/PHYSIO" -chtrig 1 -ntp 340 -tr 1.5 -outdir "/bcbl/home/public/CVR/PRESURGICAL_BIDS/Split_Files" -heur /bcbl/home/public/CVR/Scripts/Phys2bids/heur_presurgical.py -sub ${dat[2]} 
done
  phys2bids -in $p -indir "/bcbl/home/public/CVR/PRESURGICAL_BH_FOLDERS/PHYSIO" -chtrig 1 -ntp 340 -tr 1.5 -outdir "/bcbl/home/public/CVR/PRESURGICAL_BH_FOLDERS/Split_Files" 
  subject=$(find /bcbl/home/public/CVR/PRESURGICAL_BIDS/Split_Files/code/conversion -type f -name $f"_125Hz.log") 
  n=$(grep "Timepoints found" $subject_total)
  NTP_END=$(echo $n | tr -dc '0-9')
  NTP_DISCARD=$(echo "${NTP_END} - ${NTP_BH}" | bc)
  phys2bids -in $f -indir "/bcbl/home/public/CVR/BIPLAS_BIDS/BIPLAS_PHYSIO_FOLDER" -chtrig 1 -ntp $NTP_BH $NTP_DISCARD -tr 1.5 1.5 -pad 15 -outdir "/bcbl/home/public/CVR/BIPLAS_BIDS/Physio_Bids" -heur /bcbl/home/public/CVR/Scripts/heur_biplas.py -sub ${dat[2]} -ses ${dat[0]} 
done


#Cut .acq in LANGCONN and save in a .txt
ls /bcbl/home/public/CVR/LANGCONN_BIDS/PHYSIO > Langconn_Physio_Bids.txt 
filename="Langconn_Physio_BH1.txt"
n=1NTP_BH=340
for f in "056_PresurgicaL_JH"
 do fne=${f%.acq}
  dat=(${fne//_/ })
  echo "Processing $f"
  subject=$(find /bcbl/home/public/CVR/PRESURGICAL_BIDS/Split_Files/code/conversion -type f -name "056_PresurgicaL_JH_125Hz.log")
  n=$(grep "Timepoints found" $subject)
  NTP_END=$(echo $n | tr -dc '0-9')
  NTP_DISCARD=$(echo "${NTP_END} - ${NTP_BH}" | bc)
  phys2bids -in $fne -indir "/bcbl/home/public/CVR/PRESURGICAL_BIDS/PHYSIO" -chtrig 1 -ntp 340 -tr 1.5 -outdir "/bcbl/home/public/CVR/PRESURGICAL_BIDS/Split_Files" -heur /bcbl/home/public/CVR/Scripts/Phys2bids/heur_presurgical.py -sub ${dat[2]} 
done
while IFS= read -r line; 
do
    (echo "$line" | cut -f 1 -d '.') >> Langconn_Physio.txt
    n=$((n+1))
done < $filename


#1 LANGCONN subject (worked)
NTP_BH=340
for f in 032_LangConn_8808.acq
do fne=${f%.acq}
  dat=(${fne//_/ })ses ${dat[0]} 
  NTP_END=$(echo $n | tr -dc '0-9')
  NTP_DISCARD=$(echo "${NTP_END} - ${NTP_BH}" | bc)
  phys2bids -in $f -indir "/bcbl/home/public/CVR/LANGCONN_BIDS/PHYSIO" -chtrig 1 -ntp $NTP_BH $NTP_DISCARD -tr 1.5 1.5 -pad 15 -outdir "/bcbl/home/public/CVR/LANGCONN_BIDS/PHYSIO_BIDS" -heur /bcbl/home/public/CVR/Scripts/heur_langconn.py -sub ${dat[2]} -ses ${dat[0]} 
done

#Langconn con todos con BH in trigger 1 con Langconn en su nombre 
lan="/bcbl/home/public/CVR/LANGCONN_BIDS/Langconn_Physio.txt"
subject_lan=($(cat $lan))
NTP_BH=340
for f in ${subject_lan[*]} 
do fne=${f%.acq}
  dat=(${fne//_/ })
  echo "Processing $f"
  subject=$(find /bcbl/home/public/CVR/LANGCONN_BIDS/Split_Files/code/conversion -type f -name $f"_125Hz.log")
  n=$(grep "Timepoints found" $subject)
  NTP_END=$(echo $n | tr -dc '0-9')
  NTP_DISCARD=$(echo "${NTP_END} - ${NTP_BH}" | bc)
  phys2bids -in $f -indir "/bcbl/home/public/CVR/LANGCONN_BIDS/PHYSIO" -chtrig 1 -ntp $NTP_BH $NTP_DISCARD -tr 1.5 1.5 -pad 15 -outdir "/bcbl/home/public/CVR/LANGCONN_BIDS/PHYSIO_BIDS" -heur /bcbl/home/public/CVR/Scripts/heur_langconn.py -sub ${dat[2]} -ses ${dat[0]} 
done

#Langconn con todos con BH in trigger 1 con digitos en su nombre 
lan2="/bcbl/home/public/CVR/LANGCONN_BIDS/Langconn_Physio_2.txt"
subject_lan=($(cat $lan2))
NTP_BH=340
ses=01
for f in ${subject_lan[*]} 
do fne=${f%.acq}
  dat=(${fne//_/ })
  echo "Processing $f"
  subject=$(find /bcbl/home/public/CVR/LANGCONN_BIDS/Split_Files/code/conversion -type f -name $f"_125Hz.log")
  n=$(grep "Timepoints found" $subject)
  NTP_END=$(echo $n | tr -dc '0-9')
  NTP_DISCARD=$(echo "${NTP_END} - ${NTP_BH}" | bc)
  phys2bids -in $f -indir "/bcbl/home/public/CVR/LANGCONN_BIDS/PHYSIO" -chtrig 1 -ntp $NTP_BH $NTP_DISCARD -tr 1.5 1.5 -pad 15 -outdir "/bcbl/home/public/CVR/LANGCONN_BIDS/PHYSIO_BIDS_2" -heur /bcbl/home/public/CVR/Scripts/heur_langconn.py -sub ${dat[0]} -ses $ses
done

NTP_BH=340
for f in 022_LANGCONN_449_2.acq
do fne=${f%.acq}
  dat=(${fne//_/ })
  subject=$(find /bcbl/home/public/CVR/LANGCONN_BIDS/Split_Files/code/conversion -type f -name '022_LANGCONN_449_2_125Hz.log')
  phys2bids -in $f -indir "/bcbl/home/public/CVR/LANGCONN_BIDS/PHYSIO" -chtrig 1 -ntp 340 3758 -tr 1.5 -pad 15 -outdir "/bcbl/home/public/CVR/BIPLAS_BIDS/Example_1" -heur /bcbl/home/public/CVR/Scripts/heur_langconn.py -sub ${dat[2]} -ses ${dat[0]} 
done

#Split the .acq files to obtain just BH 
pre="/bcbl/home/public/CVR/Scripts/Presurgical.txt"
subject_pre=($(cat $pre))
for p in ${subject_pre[*]}
do
  phys2bids -in $p -indir "/bcbl/home/public/CVR/PRESURGICAL_BH_FOLDERS/PHYSIO" -chtrig 1 -ntp 340 -tr 1.5 -outdir "/bcbl/home/public/CVR/PRESURGICAL_BH_FOLDERS/Split_Files"  
done

#To obtain the .png from the acq files to see the plots 
pre="/bcbl/home/public/CVR/Scripts/Presurgical.txt"
lines_3=($(cat $pre))
for variable_3 in ${lines_3[*]}
do 
   phys2bids -in $variable_3 -indir "/bcbl/home/public/CVR/PRESURGICAL_BH_FOLDERS/PHYSIO" -outdir "/bcbl/home/public/CVR/PRESURGICAL_BH_FOLDERS/channel_images"   
done



#Cut .acq and save in a .txt
ls /bcbl/home/public/CVR/PRESURGICAL_BH_FOLDERS/PHYSIO > Presurgical_Physio_Bids.txt 
filename="Presurgical_Physio_Bids.txt"
n=1
while IFS= read -r line; 
do
    (echo "$line" | cut -f 1 -d '.') >> Presurgical_Physio.txt
    n=$((n+1))
done < $filename

#1 Presurgical Subject

ls /bcbl/home/public/CVR/PRESURGICAL_BIDS/PHYSIO > Presurgical.txt 
filename="Presurgical.txt"
n=1
while IFS= read -r line; 
do
    (echo "$line" | cut -f 1 -d '.') >> Presurgical_Bids.txt
    n=$((n+1))
done < $filename


pre="/bcbl/home/public/CVR/PRESURGICAL_BIDS/Presurgical.txt"
subject_pre=($(cat $pre))
for p in ${subject_pre[*]}
  do
  phys2bids -in $p -indir "/bcbl/home/public/CVR/PRESURGICAL_BIDS/PHYSIO" -chtrig 1 -ntp 340 -tr 1.5 -outdir "/bcbl/home/public/CVR/PRESURGICAL_BIDS/Split_Files"  
done


pre="/bcbl/home/public/CVR/PRESURGICAL_BIDS/PRESURGICAL_Physio.txt"
subject_pre=($(cat $pre))
NTP_BH=340
for f in ${subject_pre[*]}
do fne=${f%.acq}
  dat=(${fne//_/ })
  echo "Processing $f"
  subject=$(find /bcbl/home/public/CVR/PRESURGICAL_BIDS/Split_Files/code/conversion -type f -name $f"_125Hz.log")
  n=$(grep "Timepoints found" $subject)
  NTP_END=$(echo $n | tr -dc '0-9')
  NTP_DISCARD=$(echo "${NTP_END} - ${NTP_BH}" | bc)
  phys2bids -in $f -indir "/bcbl/home/public/CVR/PRESURGICAL_BIDS/PHYSIO" -chtrig 1 -ntp 340 -tr 1.5 -outdir "/bcbl/home/public/CVR/PRESURGICAL_BIDS/Split_Files" -heur /bcbl/home/public/CVR/Scripts/heur_presurgical.py -sub ${dat[2]} 
done
done