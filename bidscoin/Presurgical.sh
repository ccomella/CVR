# Cajal01
ssh -X cajal01
module load python/python3.6
source activate bidscoin


#Call Bidsmapper Presurgical Pre
bidsmapper -n "*_Presurgical" -m "CRANEO_FUNCIONAL" /bcbl/data/MRI/PRESURGICAL2_MRI/DATA/images/Pacientes/pre  /bcbl/home/public/CVR/PRESURGICAL
bidscoiner /bcbl/data/MRI/PRESURGICAL2_MRI/DATA/images/Pacientes/pre  /bcbl/home/public/CVR/PRESURGICAL #Tres Digitos minuscula
bidscoiner -b bidsmap2.yaml /bcbl/data/MRI/PRESURGICAL2_MRI/DATA/images/Pacientes/pre  /bcbl/home/public/CVR/PRESURGICAL  #Dos Digitos minuscula

bidsmapper -n "*_PRESURGICAL" -m "CRANEO_FUNCIONAL" /bcbl/data/MRI/PRESURGICAL2_MRI/DATA/images/Pacientes/pre  /bcbl/home/public/CVR/PRESURGICAL_BIDS2
bidscoiner /bcbl/data/MRI/PRESURGICAL2_MRI/DATA/images/Pacientes/pre  /bcbl/home/public/CVR/PRESURGICAL_BIDS2 #3 Digitos
bidscoiner -b bidsmap2.yaml /bcbl/data/MRI/PRESURGICAL2_MRI/DATA/images/Pacientes/pre  /bcbl/home/public/CVR/PRESURGICAL_BIDS2 #2digits