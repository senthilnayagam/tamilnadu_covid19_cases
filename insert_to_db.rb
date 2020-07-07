require 'pg'
require 'pp'
=begin
connection = PG.connect :user => 'postgres', :password => 'root', :dbname => 'tamilnadu_case'

#connection.exec "CREATE DATABASE tamilnadu_case"

connection.exec "DROP TABLE IF EXISTS Cases"
puts "Drop table cases if present"

connection.exec "CREATE TABLE Cases(Id INTEGER PRIMARY KEY, Summary TEXT)"
puts "Table created"

puts "Creating data......"
=end

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
puts


# return as hash and use it in the sql insert statement appropriately







end


(1..1636).each do |i|  # 1.. 1636
	
	f = File.open("./cases/case_"+i.to_s.rjust(4, "0")+".txt")


 parse_data(f.read)

=begin	
	connection.exec "INSERT INTO Cases (Id, Summary) VALUES( 
						#{i}, 
						'#{f.read}'
					)"
=end					
end


=begin
puts "Data inserted successfully"

res = connection.exec "SELECT * FROM cases LIMIT 5"

puts "printing some sample data"

puts res.map { |row| puts row } 
=end




