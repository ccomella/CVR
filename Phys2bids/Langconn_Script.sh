#Enter the Cluster (GIT is install in it)
ssh -X ips-0-3
 qlogin
module load python/venv #To activate python
source activate /bcbl/home/public/CVR/py_3.9 #my environment
cd public/CVR 

# #Install Phys2bids
# git clone https://github.com/ccomella/phys2bids.git #Install has origin
# cd phys2bids #enter to phys2bids
# git remote add smoia https://github.com/smoia/phys2bids.git #Install smoia phys2bids
# git remote add upstream https://github.com/physiopy/phys2bids.git #Install as upstream physiopy
# git fetch --all #
# #Add and change to the branch 

# #GIT
# git remote -v #List all currently configured remote repositories 
# git status # List the files you've changed and those you still need to add or commit
# git checkout -B cristina smoia/cristina


#To obtain the .png from the acq files to see the plots 
lan="/bcbl/home/public/CVR/Scripts/Langconn_Physio.txt"
lines_2=($(cat $lan))
for variable_2 in ${lines_2[*]}
do
  phys2bids -in $variable_2 -indir "/bcbl/home/public/CVR/LANGCONN2_BIDS/PHYSIO" -outdir "/bcbl/home/public/CVR/LANGCONN2_BIDS/channel_images"   
done

#Splits files just to stay with BH
lan="/bcbl/home/public/CVR/Scripts/Langconn_Physio.txt"
subject_lan=($(cat $lan))
for l in ${subject_lan[*]}
do
  phys2bids -in $l -indir "/bcbl/home/public/CVR/LANGCONN_BIDS/PHYSIO" -chtrig 1 -ntp 340 -tr 1.5 -outdir "/bcbl/home/public/CVR/LANGCONN_BIDS/Split_Files"
done


# #1 LANGCONN subject (worked)
# NTP_BH=340
# for f in 032_LangConn_8808.acq
# do fne=${f%.acq}
#   dat=(${fne//_/ })ses ${dat[0]} 
#   NTP_END=$(echo $n | tr -dc '0-9')
#   NTP_DISCARD=$(echo "${NTP_END} - ${NTP_BH}" | bc)
#   phys2bids -in $f -indir "/bcbl/home/public/CVR/LANGCONN_BIDS/PHYSIO" -chtrig 1 -ntp $NTP_BH $NTP_DISCARD -tr 1.5 1.5 -pad 15 -outdir "/bcbl/home/public/CVR/LANGCONN_BIDS/PHYSIO_BIDS" -heur /bcbl/home/public/CVR/Scripts/heur_langconn.py -sub ${dat[2]} -ses ${dat[0]} 
# done

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