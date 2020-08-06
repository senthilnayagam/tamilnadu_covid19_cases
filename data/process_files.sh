cat april_deaths.txt may_deaths.txt june_deaths.txt july_deaths.txt	august_deaths.txt > dump/all_deaths.txt
cd dump
rm case_* 
gcsplit -k -f case_ -b"%04d.txt"  all_deaths.txt '/^Death Case No/' '{*}'
cp  case_*.txt ../../cases
cd ..
ls dump