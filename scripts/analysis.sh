echo "report taken on"
date +%d-%m-%Y
echo "total deaths in TN  "
tail -n1 ../cases/cases.csv | cut -d',' -f1

echo ""
echo "## symptoms during admission ## "

echo "cough"
cat ../cases/cases.csv | grep -i 'cough'| wc -l

echo 'breathlessness or difficulty in breathing'
cat ../cases/cases.csv | grep -i 'breathlessness\|difficulty in breathing'| wc -l

echo "loosing smell taste"
cat ../cases/cases.csv | grep -i 'smell\|taste'| wc -l

echo "loose stool"
cat ../cases/cases.csv | grep -i 'loose stools'| wc -l

echo "headache"
cat ../cases/cases.csv | grep -i 'headache'| wc -l

echo "fever"
cat ../cases/cases.csv | grep -i 'fever'| wc -l

echo "ache or pain"
cat ../cases/cases.csv | grep -i 'ache\|pain'| wc -l

echo ""
echo "## co-morbidities ##"
echo "people who had diabetes "
cat ../cases/cases.csv | grep -i  'diabetic\|diabetes\|t2dm\|mellitus' | wc -l

echo "people who had hypertension"
cat ../cases/cases.csv | grep -i 'shtn\|hypertension'| wc -l

echo "people who had diabetes and hypertension"
cat ../cases/cases.csv | grep -i  'diabetic\|diabetes\|t2dm\|mellitus' | grep -i 'shtn\|hypertension' | wc -l

echo "people who had heart diseases"
cat ../cases/cases.csv | grep -i 'heart\|Cardiopulmonary\|coronary\|CAD\|Mitral\|Rheumatic'| wc -l

echo "people who had kidney diseases"
cat ../cases/cases.csv | grep -i 'kidney\|ckd'| wc -l

echo "Hypothyroidism"
cat ../cases/cases.csv | grep -i "Hypothyroidism" | wc -l

echo "Cancer"
cat ../cases/cases.csv | grep -i 'Carcinoma\|cancer' | wc -l

echo "Asthma"
cat ../cases/cases.csv | grep -i 'Asthma' | wc -l


echo "Tuberculosis"
cat ../cases/cases.csv | grep -i 'Tuberculosis\|ptb' | wc -l

echo "COPD"
cat ../cases/cases.csv | grep -i 'COPD' | wc -l




echo ""
echo "## cause of death ##"

echo 'pneumonia'
cat ../cases/cases.csv | grep -i 'pneumonia'| wc -l

echo "lung diseases respiratory ILI SARI ARDS"
cat ../cases/cases.csv | grep -i 'respiratory\|lung\|ILI\|SARI\|ARDS'| wc -l

echo 'Septic Shock'
cat ../cases/cases.csv | grep -i 'Septic Shock'| wc -l


echo 'Brain Damage'
cat ../cases/cases.csv | grep -i 'Encephalopathy'| wc -l



echo ""
echo "## miscellaneous ##"
echo 'brought dead' 
cat ../cases/cases.csv | grep -i  'brought dead' | wc -l
echo 'mental illness'
cat ../cases/cases.csv | grep -i  'mental' | wc -l
echo 'schizophrenia'
cat ../cases/cases.csv | grep -i  'schizophrenia' | wc -l

echo 'fracture'
cat ../cases/cases.csv | grep -i  'fracture' | wc -l


echo 'urinary'
cat ../cases/cases.csv | grep -i  'urosepsis\|bladder' | wc -l






#cat ../cases/cases.csv | grep -i 'liver'| wc -l







# cat ../cases/cases.csv | grep -i 'cough\|breathlessness\|smell\|taste'| wc -l


# cat ../cases/cases.csv | grep -i 'throat'| wc -l
 

# cat ../cases/cases.csv | grep -i 'nasal'| wc -l


echo "" 
echo "patients who were admitted to Private hospital"
echo "p.s. : some were later shifted to government hospitals"
cat ../cases/cases.csv | grep -i 'private hospital'| wc -l
