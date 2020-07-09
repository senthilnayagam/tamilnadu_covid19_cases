
def parse_data(file_string)
		fs = file_string

		# join string as single line , replace new line with space
		fs =  fs.gsub("\n", " ")

		# replace multiple spaces with single space
		fs =  fs.gsub(/\s+/, ' ')

		# find gender
		if fs.downcase.include? 'female'
		gender = 'female'
		else
		gender = 'male'
		end

		#puts gender
		# find age


		numbers = fs.scan(/\d+/)
		#fs =  fs.gsub("years", "year")
		#m = fs.match /\w+ (\d+)/
		#pp numbers
		case_number = numbers[0]
		age = numbers[1]


		# find district


		words = fs.scan(/\w+/)

		#pp words
		from_index = words.index('from')
		district = words[from_index + 1] unless from_index.nil?
			

		# find cause of death

		cause = fs.split("due to")

		death_cause = cause[1] if cause.length ==2

		puts "raw_content:" + fs
		puts "case_number:" + case_number
		puts "age:" + age.to_s
		puts "gender:" + gender.to_s
		puts "district:" + district.to_s
		puts "death_cause:" + death_cause.to_s

		death_case = Hash.new


		death_case["raw_content"] = fs
		death_case["case_number"]  = case_number
		death_case["age"]  = age.to_s
		death_case["gender"]  = gender.to_s
		death_case["district"]  = district.to_s
		death_case["death_cause"]  = death_cause.to_s

		return death_case
		# return as hash and use it in the sql insert statement appropriately

end