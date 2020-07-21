require 'date'

def valid_date?(string)
  return true if string == 'never'

  !!(string.match(/\d{2}-\d{2}-\d{4}/) && Date.strptime(string, '%d-%m-%Y'))
rescue ArgumentError
  false
end


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

		# admitted_on
		if fs.downcase.include? 'admitted on '
			begin
		admitted_on = fs.split("admitted on ")[1].split(" ")[0]
		admitted_on = admitted_on.gsub(/\.$/, '').gsub('.','-')
		puts "##error## admitted_on: " + admitted_on unless valid_date?(admitted_on)
			rescue StandardError => e 
			puts e.message 

		end

		end


		# died_on
		if fs.downcase.include? 'died on '
			begin
		died_on = fs.split("died on ")[1].split(" ")[0]
		died_on = died_on.gsub(/\.$/, '').gsub('.','-')
		puts "##error## died_on: " + died_on unless valid_date?(died_on)
		rescue StandardError => e 
			puts e.message 

		end
		end

		# sample_taken_on
		sample_taken_on = ''
		if fs.downcase.include? ' sample taken on '
		#	print "#### 742}"
		begin  
		sample_taken_on = fs.split(" sample taken on ")[1].split(" ")[0]
		sample_taken_on = sample_taken_on.gsub(/\.$/, '').gsub(/,$/, '').gsub('.','-')
		puts "##error## sample_taken_on: " + sample_taken_on unless valid_date?(sample_taken_on)

		rescue StandardError => e 
			puts e.message 

		end

		end

		# result_on
		result_on = ''
		if fs.downcase.include? ' result on '
			begin  
		result_on = fs.split(" result on ")[1].split(" ")[0]
		result_on = result_on.gsub(/\.$/, '').gsub(/,$/, '').gsub('.','-')
		puts "##error## result_on: " + result_on unless valid_date?(result_on)
		puts "result_on: " + result_on
			rescue StandardError => e 
				puts e.message 

			end

		end




		#death_cause = cause[1] if cause.length ==2

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
		death_case["admitted_on"]  = admitted_on.to_s
		death_case["died_on"]  = died_on.to_s
		death_case["sample_taken_on"]  = sample_taken_on.to_s
		death_case["result_on"]  = result_on.to_s
		death_case["death_cause"]  = death_cause.to_s


		return death_case
		# return as hash and use it in the sql insert statement appropriately

end