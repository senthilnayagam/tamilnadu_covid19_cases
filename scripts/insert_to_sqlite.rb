require 'sqlite3'
require 'pp'
require './parse_logic.rb'

SQLite3::Database.new "tamilnadu_case.db"

db = SQLite3::Database.open "tamilnadu_case.db"

db.execute "DROP TABLE IF EXISTS Cases"
puts "Drop table cases if present"

db.execute "CREATE TABLE Cases(Id INTEGER PRIMARY KEY, RawContent TEXT, CaseNumber INTEGER, Age INTEGER DEFAULT 0, Gender TEXT, District TEXT, DeathCause TEXT)"
puts "Table created"

puts "Creating data......"

(1..3000).each do |i|  # 1.. 1636 # put a big number so as not to increase the count daily
	filename = "../cases/case_"+i.to_s.rjust(4, "0")+".txt"

	if File.file?(filename)
	f = File.open(filename)


  	res = parse_data(f.read)
  	if res['age'] == ''
  	   res['gender'] = ''

  	end

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
end

id = db.last_insert_row_id
puts "The last id of the inserted row is #{id}"