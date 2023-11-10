#PRESURGICAL PHYS2BIDS SCRIPTS REST PATIENTS
#Autor: Cristina Comella

module load python/python3.6
source activate /bcbl/home/public/CVR/py_3.9

cd public/CVR/PRESURGICAL_BIDS
#To obtain files names in .txt name
ls /bcbl/home/public/CVR/PRESURGICAL_BIDS/PHYSIO > /bcbl/home/public/CVR/Scripts/Phys2bids/PhysioText/Presurgical_new.txt


#To obtain the .png from the acq files to see the plots 
pre="/bcbl/home/public/CVR/Scripts/PhysioText/Presurgical_new.txt"
pacient=($(cat $pre))
for var in ${pacient[*]}
do 
   phys2bids -in $var -indir "/bcbl/home/public/CVR/PRESURGICAL_BIDS/PHYSIO" -outdir "/bcbl/home/public/CVR/PRESURGICAL_BIDS/channel_images"   
done

#Split the .acq files to obtain just BH 

for p in ${pacient[*]}
do
  phys2bids -in $p -indir "/bcbl/home/public/CVR/PRESURGICAL_BIDS/PHYSIO" -chtrig 1 -ntp 340 -tr 1.5 -outdir "/bcbl/home/public/CVR/PRESURGICAL_BIDS/Split_Files"  
done

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

pre=/bcbl/home/public/CVR/Scripts/Phys2bids/PhysioText/Presurgical_Bids_new.txt
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


