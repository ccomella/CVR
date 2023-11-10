#

#Finding ICA 
import  csv
import os 

accepted_subjects=[]
rejected_subjects=[]
ignored_subjects=[]

tsv_file= "/bcbl/home/public/CVR/PRESURGICAL_BIDS/sub_01/ses-1/tmp/task-BH/sub-01_ses-1_task-BH_run-1_meica/manual_classification.tsv"

with open (tsv_file, 'r') as file: 

    reader= cvs.DictReader(file, delimited="\t")
    for row in reader:

        if row['classification'] == 'accepted'
            accepted_subjects.append(row['Component'])

        elif row['classification'] == 'rejected'
            rejected_subjects.append(row['Component'])

        elif row ['classification'] == 'ignored'
            ignored_subjects.append(row('Componet'))

print(accepted_subjects)

print(rejected_subjects)

print(ignored_subjects)


