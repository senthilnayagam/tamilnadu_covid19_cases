require 'pg'

connection = PG.connect :user => 'postgres', :password => 'root', :dbname => 'tamilnadu_case'

#connection.exec "CREATE DATABASE tamilnadu_case"

connection.exec "DROP TABLE IF EXISTS Cases"
puts "Drop table cases if present"

connection.exec "CREATE TABLE Cases(Id INTEGER PRIMARY KEY, Summary TEXT)"
puts "Table created"

puts "Creating data......"

Dir["./cases/*"].each_with_index do |file, index|

	f = File.open(file)
	f_data = f.read
	connection.exec "INSERT INTO Cases (Id, Summary) VALUES( 
						#{index + 1}, 
						'#{f_data}'
					)"
end

puts "Data inserted successfully"

res = connection.exec "SELECT * FROM cases LIMIT 5"

puts "printing some sample data"

puts res.map { |row| puts row } 





