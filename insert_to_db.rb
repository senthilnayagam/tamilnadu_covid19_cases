require 'pg'

connection = PG.connect :user => 'postgres', :password => 'root', :dbname => 'tamilnadu_case'

#connection.exec "CREATE DATABASE tamilnadu_case"

connection.exec "DROP TABLE IF EXISTS Cases"
puts "Drop table cases if present"

connection.exec "CREATE TABLE Cases(Id INTEGER PRIMARY KEY, Summary TEXT)"
puts "Table created"

puts "Creating data......"

(1..1571).each do |i|
	
	f = File.open("./cases/case_"+i.to_s.rjust(4, "0")+".txt")
	connection.exec "INSERT INTO Cases (Id, Summary) VALUES( 
						#{i}, 
						'#{f.read}'
					)"
end

puts "Data inserted successfully"

res = connection.exec "SELECT * FROM cases LIMIT 5"

puts "printing some sample data"

puts res.map { |row| puts row } 





