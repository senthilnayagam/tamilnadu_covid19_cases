require 'sqlite3'
require 'pp'
require './parse_logic.rb'

SQLite3::Database.new "tamilnadu_case.db"

db = SQLite3::Database.open "tamilnadu_case.db"

db.execute "DROP TABLE IF EXISTS Cases"
puts "Drop table cases if present"

db.execute "CREATE TABLE Cases(Id INTEGER PRIMARY KEY, RawContent TEXT, CaseNumber TEXT, Age TEXT, Gender TEXT, District TEXT, DeathCause TEXT)"
puts "Table created"

puts "Creating data......"

(1..1636).each do |i|  # 1.. 1636
	
	f = File.open("../cases/case_"+i.to_s.rjust(4, "0")+".txt")


  res = parse_data(f.read)

	
	db.execute "INSERT INTO Cases (Id, RawContent,
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

id = db.last_insert_row_id
puts "The last id of the inserted row is #{id}"