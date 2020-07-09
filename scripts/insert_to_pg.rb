require 'pg'
require 'pp'
require './parse_logic.rb'

connection = PG.connect :user => 'postgres', :password => 'root', :dbname => 'tamilnadu_case'

#connection.exec "CREATE DATABASE tamilnadu_case"

connection.exec "DROP TABLE IF EXISTS Cases"
puts "Drop table cases if present"

connection.exec "CREATE TABLE Cases(Id INTEGER PRIMARY KEY, RawContent TEXT, CaseNumber TEXT, Age TEXT, Gender TEXT, District TEXT, DeathCause TEXT)"
puts "Table created"

puts "Creating data......"


(1..1636).each do |i|  # 1.. 1636
	
	f = File.open("../cases/case_"+i.to_s.rjust(4, "0")+".txt")


  res = parse_data(f.read)

	
	connection.exec "INSERT INTO Cases (Id, RawContent,
		CaseNumber, Age, Gender, District, DeathCause) 
		VALUES( 
						#{i}, 
						'#{res['raw_content']}',
						'#{res['case_number']}',
						'#{res['age']}',
						'#{res['gender']}',
						'#{res['district']}',
						'#{res['death_cause']}'
					)"			
end


=begin
puts "Data inserted successfully"

res = connection.exec "SELECT * FROM cases LIMIT 5"

puts "printing some sample data"

puts res.map { |row| puts row } 
=end




