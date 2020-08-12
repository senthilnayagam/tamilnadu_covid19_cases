
echo "download file: $1";

cd august
echo "wget $1"
wget $1
IN=$(echo $1 | cut -d'/' -f8)
pdftotext -layout $IN $IN.txt
cd ..
python pdftotext_output_parser.py > ignored/temp.txt