require 'date'

if ARGV.length == 1
$debug = 1
else
$debug = 0
end	

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
		admitted_on = admitted_on.gsub(/\.$/, '').gsub(/,$/, '').gsub('.','-')
		puts "##error## admitted_on: " + admitted_on unless valid_date?(admitted_on)
			rescue StandardError => e 
			puts "case:" + case_number.to_s
			puts e.message 

		end

		end


		# died_on
		if fs.downcase.include? 'died on '
			begin
				dd, mm, yyyy =0,0,0
				weekday = ''
				died_on = fs.split("died on ")[1].split(" ")[0]
				died_on = died_on.gsub(/\.$/, '').gsub(/,$/, '').gsub('.','-')
				puts "##error## died_on: " + died_on unless valid_date?(died_on)
				dd, mm, yyyy= died_on.split('-')
				weekday = Time.new(yyyy,mm,dd).strftime('%A')

			rescue StandardError => e 
				puts "case:" + case_number.to_s
				puts e.message 

			end
		end


		# death time
		if fs.downcase.include? 'died on '
			begin
				 date_string = fs.split("died on ")[1].split(" ") #[0]
				 if date_string[1] == 'at'
				 time = date_string[2]
				 ampm = date_string[3]
				 ampm = ampm.upcase.gsub('.','').gsub(',','')
				 puts "###time: "  + time + ' ' + ampm + ' case:' + case_number if $debug==1
				 hour,minute = time.split('.')

				if ampm =='PM' and hour.to_i !=12
				 hour =  hour.to_i + 12 
				end
				if ampm =='AM' and hour.to_i ==12
				 hour =  0 
				end

				 #hour, ampm= 0,'AM'  if hour==24
				end

		#puts "##error## died_on: " + died_on unless valid_date?(died_on)
		rescue StandardError => e 
			puts "case:" + case_number.to_s
			puts e.message 
			puts time

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
			puts "case:" + case_number.to_s
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
		puts "result_on: " + result_on if $debug==1
			rescue StandardError => e 
				puts "case:" + case_number.to_s
				puts e.message 

			end

		end



		#death_cause = cause[1] if cause.length ==2

		if $debug==1
			puts "raw_content:" + fs
			puts "case_number:" + case_number
			puts "age:" + age.to_s
			puts "gender:" + gender.to_s
			puts "district:" + district.to_s
			puts "death_cause:" + death_cause.to_s
		end

		death_case = Hash.new

		# home death
		if fs.downcase.include? 'home death'
		death_case["home_death"] = "true"
		end

		# brought_dead
		if fs.downcase.include? 'brought dead'
		death_case["brought_dead"] = "true"			
		end


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
		death_case["death_time"]  = time.to_s
		death_case["death_ampm"]  = ampm.to_s
		death_case["dd"]  = dd.to_i
		death_case["mm"]  = mm.to_i
		death_case["yyyy"]  = yyyy.to_i
		death_case["weekday"]  = weekday.to_s
		death_case["hour"]  = hour.to_i
		death_case["minute"]  = minute.to_i


		return death_case
		# return as hash and use it in the sql insert statement appropriately

end