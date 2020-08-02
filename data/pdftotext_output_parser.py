import re
import glob
from collections import Counter
import datetime

filelist = glob.glob("august/*.txt")

print(filelist)




for filename in filelist:
	#print(filename)
	with open(filename, 'r') as file:
		useful_lines = []
		final_lines = []
		lines = file.read().split("\n")
		for i,line in enumerate(lines):
			nl = line.lower().replace("\x0c",'').replace("\n",'').replace("\r",'')
			if nl.find('death case') != -1:
				useful_lines.append(i)
				#print("#  ",i,nl)
				#print("## ",line.replace("\x0c",''))

		#print(useful_lines[0],useful_lines[-1])
		useful_line_content = lines[useful_lines[0]:useful_lines[-1]+10]
		#print("\n".join(useful_line_content))
		#print(list_duplicates(useful_line_content))

		for line in useful_line_content:
			# replace multiple whitespace with one, remove page break, remove leading and trailing spaces
			line = re.sub(' +', ' ', line.replace("\x0c",'') ).lstrip()
			final_lines.append(line)
			#print(line )

		#print(list_duplicates(final_lines))
		remove = list(Counter(final_lines).most_common(4))
		#print(remove)
		for x in remove:
			print(x[0])
			if x[0] != '':
				while x[0] in final_lines: final_lines.remove(x[0])

		#print("######")
		#for line in final_lines:
		#	print(line)

		output = "\n".join(final_lines)
		# replace multiple newlines with 5 newlines
		output = re.sub(r'\n{2,}', '\n\n\n\n\n\n\n\n\n\n', output) 

		print(output)

		print('#### corrections #### ')
		print("")





		print("# missing leading 0 in day or month #")
		for line in final_lines:
			all = re.findall(r" [\d]{1,2}.[\d]{1}.[\d]{4}", line)
			#print(line)
			for s in all:
				s
				print(s)

		for line in final_lines:
			all = re.findall(r" [\d]{1}.[\d]{1,2}.[\d]{4}", line)
			#print(line)
			for s in all:
				s
				print(s)

		print("")
		print("# AM/PM #")
		for line in final_lines:
			#AM/PM joining parsing
			all = re.findall(r"[\d]{1,2}\.[\d]{2}AM", line)
			#print(line)
			for s in all:
				s
				print(s)

			all = re.findall(r"[\d]{1,2}\.[\d]{2}PM", line)
			#print(line)
			for s in all:
				s
				print(s)

		print("")
		print("# leading zero in time #")
		for line in final_lines:
			# no leading zero in minute
			all = re.findall(r" [\d]{1}\.[\d]{2} ", line)
			#print(line)
			for s in all:
				s
				print(s)
			
			



		

    

#24*7 Control Room: 044-29510400, 044-29510500, 9444340496, 8754448477
#District Control Room – 1077. Toll Free Number – 1800 1205 55550
#www.stopcorona.tn.gov.in