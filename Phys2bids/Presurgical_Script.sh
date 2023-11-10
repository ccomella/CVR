#PRESURGICAL PHYS2BIDS SCRIPTS
#Autor: Cristina Comella


#Enter the Cluster (GIT is install in it)
ssh -X ips-0-3
  qlogin
module load python/venv #To activate python
source activate /bcbl/home/public/CVR/py_3.9 #my environment
cd public/CVR 

# #Install Phys2bids, just onces
# git clone  #Install has origin
# cd phys2bids #enter to phys2bids
# git remote add smoia https://github.com/smoia/phys2bids.git #Install smoia phys2bids
# git remote add upstream https://github.com/physiopy/phys2bids.git #Install as upstream physiopy
# git fetch --all #
# #Add and change to the branch 
# #GIT
# git remote -v #List all currently configured remote repositories 
# git status # List the files you've changed and those you still need to add or commit
# git checkout -B cristina smoia/cristina

#To obtain files names in .txt name
ls /bcbl/home/public/CVR/PRESURGICAL_BIDS/PHYSIO > Presurgical.txt 

#First Step: Out of the Cluster
#Activate the environment
source activate /bcbl/home/public/CVR/py_3.9 #my environment
cd public/CVR 
cd phys2bids #enter to phys2bids


#To obtain the .png from the acq files to see the plots 
pre="/bcbl/home/public/CVR/Scripts/PhysioText/Presurgical.txt"
pacient=($(cat $pre))
for var in ${pacient[*]}
do 
   phys2bids -in $var -indir "/bcbl/home/public/CVR/PRESURGICAL_BIDS/PHYSIO" -outdir "/bcbl/home/public/CVR/PRESURGICAL_BIDS/channel_images"   
done

#Obtain .png of Sub 065
phys2bids -in 065_Presurgical_HAS.acq -indir "/bcbl/home/public/CVR/PRESURGICAL_BIDS/PHYSIO" -outdir "/bcbl/home/public/CVR/PRESURGICAL_BIDS/channel_images"   

#Obtain .png to Sub 066
phys2bids -in 066_PRESURGICAL_JLOMG.acq -indir "/bcbl/home/public/CVR/PRESURGICAL_BIDS/PHYSIO" -outdir "/bcbl/home/public/CVR/PRESURGICAL_BIDS/channel_images" 

#Obtain .png to Sub 067
phys2bids -in 067_Presurgical_SLD.acq -indir "/bcbl/home/public/CVR/PRESURGICAL_BIDS/PHYSIO" -outdir "/bcbl/home/public/CVR/PRESURGICAL_BIDS/channel_images" 

#Split the .acq files to obtain just BH 

for p in ${pacient[*]}
do
  phys2bids -in $p -indir "/bcbl/home/public/CVR/PRESURGICAL_BIDS/PHYSIO" -chtrig 1 -ntp 340 -tr 1.5 -outdir "/bcbl/home/public/CVR/PRESURGICAL_BIDS/Split_Files"  
done

#Split files to Sub 065
phys2bids -in 065_Presurgical_HAS.acq -indir "/bcbl/home/public/CVR/PRESURGICAL_BIDS/PHYSIO" -chtrig 1 -ntp 340 -tr 1.5 -outdir "/bcbl/home/public/CVR/PRESURGICAL_BIDS/Split_Files"    

#Split files to Sub 066
phys2bids -in 066_PRESURGICAL_JLOMG.acq -indir "/bcbl/home/public/CVR/PRESURGICAL_BIDS/PHYSIO" -chtrig 1 -ntp 340 -tr 1.5 -outdir "/bcbl/home/public/CVR/PRESURGICAL_BIDS/Split_Files"  

#Split files to Sub 067
phys2bids -in 067_Presurgical_SLD.acq -indir "/bcbl/home/public/CVR/PRESURGICAL_BIDS/PHYSIO" -chtrig 1 -ntp 340 -tr 1.5 -outdir "/bcbl/home/public/CVR/PRESURGICAL_BIDS/Split_Files" 

#CUT .acq names in Presurgical 
filename="/bcbl/home/public/CVR/Scripts/Phys2bids/PhysioText/Presurgical_new.txt"
n=1
while IFS= read -r line; 
do
    (echo "$line" | cut -f 1 -d '.') >> /bcbl/home/public/CVR/Scripts/Phys2bids/PhysioText/Presurgical_Bids_new.txt
    n=$((n+1))
done < $filename



#1 Presurgical Subject 056
# NTP_BH=340
# for f in "056_PresurgicaL_JH"
#  do fne=${f%.acq}
#   dat=(${fne//_/ })
#   echo "Processing $f"
#   subject=$(find /bcbl/home/public/CVR/PRESURGICAL_BIDS/Split_Files/code/conversion -type f -name $f"_125Hz.log")
#   n=$(grep "Timepoints found" $subject)
#   NTP_END=$(echo $n | tr -dc '0-9')
#   NTP_DISCARD=$(echo "${NTP_END} - ${NTP_BH}" | bc)
#   phys2bids -in $f-indir "/bcbl/home/public/CVR/PRESURGICAL_BIDS/PHYSIO" -chtrig 1 -ntp 340 -tr 1.5 -outdir "/bcbl/home/public/CVR/PRESURGICAL_BIDS/Split_Files" -heur /bcbl/home/public/CVR/Scripts/Phys2bids/Heuristic/heur_presurgical.py -sub ${dat[2]} 
# done



#Script for all heuristic Presurgical

pre="/bcbl/home/public/CVR/Scripts/Phys2bids/PhysioText/Presurgical_Bids_new.txt"
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
  phys2bids -in $f.acq -indir "/bcbl/home/public/CVR/PRESURGICAL_BIDS/PHYSIO" -chtrig 1 -ntp 340 $NTP_DISCARD -tr 1.5 1.5 -pad 15 -outdir "/bcbl/home/public/CVR/PRESURGICAL_BIDS/Physio_BIDS" -heur /bcbl/home/public/CVR/Scripts/Phys2bids/Heuristic/heur_presurgical2.py -sub ${dat[0]} 
done


#1 Presurgical Subject 065
NTP_BH=340
for f in "065_Presurgical_HAS"
 do fne=${f%.acq}
  dat=(${fne//_/ })
  echo "Processing $f"
  subject=$(find /bcbl/home/public/CVR/PRESURGICAL_BIDS/Split_Files/code/conversion -type f -name $f"_125Hz.log")
  n=$(grep "Timepoints found" $subject)
  NTP_END=$(echo $n | tr -dc '0-9')
  NTP_DISCARD=$(echo "${NTP_END} - ${NTP_BH}" | bc)
  phys2bids -in $f.acq -indir "/bcbl/home/public/CVR/PRESURGICAL_BIDS/PHYSIO" -chtrig 1 -ntp 340 $NTP_DISCARD -tr 1.5 1.5 -pad 15 -outdir "/bcbl/home/public/CVR/PRESURGICAL_BIDS/Physio_BIDS" -heur /bcbl/home/public/CVR/Scripts/Phys2bids/Heuristic/heur_presurgical.py -sub ${dat[0]}  
done

#PRESURGICAL 066, tiene todo mayuscula por lo que el heuristico es heur_presurgical2.py
NTP_BH=340
for f in "066_PRESURGICAL_JLOMG"
 do fne=${f%.acq}
   dat=(${fne//_/ })
  echo "Processing $f"
  subject=$(find /bcbl/home/public/CVR/PRESURGICAL_BIDS/Split_Files/code/conversion -type f -name $f"_125Hz.log")
  n=$(grep "Timepoints found" $subject)
  NTP_END=$(echo $n | tr -dc '0-9')
  NTP_DISCARD=$(echo "${NTP_END} - ${NTP_BH}" | bc)
  phys2bids -in $f.acq -indir "/bcbl/home/public/CVR/PRESURGICAL_BIDS/PHYSIO" -chtrig 1 -ntp 340 $NTP_DISCARD -tr 1.5 1.5 -pad 15 -outdir "/bcbl/home/public/CVR/PRESURGICAL_BIDS/Physio_BIDS" -heur /bcbl/home/public/CVR/Scripts/Phys2bids/Heuristic/heur_presurgical2.py -sub ${dat[0]}  
done

#1 Presurgical Subject 065
NTP_BH=340
for f in "067_Presurgical_SLD"
 do fne=${f%.acq}
  dat=(${fne//_/ })
  echo "Processing $f"
  subject=$(find /bcbl/home/public/CVR/PRESURGICAL_BIDS/Split_Files/code/conversion -type f -name $f"_125Hz.log")
  n=$(grep "Timepoints found" $subject)
  NTP_END=$(echo $n | tr -dc '0-9')
  NTP_DISCARD=$(echo "${NTP_END} - ${NTP_BH}" | bc)
  phys2bids -in $f.acq -indir "/bcbl/home/public/CVR/PRESURGICAL_BIDS/PHYSIO" -chtrig 1 -ntp 340 $NTP_DISCARD -tr 1.5 1.5 -pad 15 -outdir "/bcbl/home/public/CVR/PRESURGICAL_BIDS/Physio_BIDS" -heur /bcbl/home/public/CVR/Scripts/Phys2bids/Heuristic/heur_presurgical.py -sub ${dat[0]}  
done


