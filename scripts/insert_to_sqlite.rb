require 'sqlite3'
require 'pp'
require './parse_logic.rb'


=begin
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
	
=end


SQLite3::Database.new "tamilnadu_case.db"

db = SQLite3::Database.open "tamilnadu_case.db"

db.execute "DROP TABLE IF EXISTS Cases"
puts "Drop table cases if present"

db.execute "CREATE TABLE Cases(Id INTEGER PRIMARY KEY, CaseNumber INTEGER,  Age INTEGER DEFAULT 0, Gender TEXT, 
District TEXT, DeathCause TEXT, admitted_on TEXT, died_on TEXT, death_time TEXT, death_ampm TEXT, sample_taken_on TEXT, result_on TEXT,brought_dead TEXT, home_death TEXT,
comorbidity TEXT,diabetes TEXT, hypertension TEXT, kidney TEXT, heart TEXT, RawContent TEXT)"
puts "Table created"

puts "Creating data......"

(1..5000).each do |i|  # 1.. 1636 # put a big number so as not to increase the count daily
	filename = "../cases/case_"+i.to_s.rjust(4, "0")+".txt"

	if File.file?(filename)
	f = File.open(filename)


  	res = parse_data(f.read)
  	if res['age'] == ''
  	   res['gender'] = ''

  	end

	 sql = "INSERT INTO Cases (Id, RawContent,
		CaseNumber, Age, Gender, District, DeathCause ,admitted_on , died_on, death_time , death_ampm, sample_taken_on, result_on, brought_dead, home_death) 
		VALUES( 
						#{i}, 
						'#{res['raw_content']}',
						'#{res['case_number']}',
						'#{res['age']}',
						'#{res['gender']}',
						'#{res['district']}',
						'#{res['death_cause']}',
						'#{res['admitted_on']}',
						'#{res['died_on']}',
						'#{res['death_time']}',
						'#{res['death_ampm']}',
						'#{res['sample_taken_on']}',
						'#{res['result_on']}',
						'#{res['brought_dead']}',
						'#{res['home_death']}'
					)"	
	sql = sql.gsub(/\s+/, ' ')
	puts(sql)
	db.execute sql
	end
end

id = db.last_insert_row_id
puts "The last id of the inserted row is #{id}"

puts "update comorbidity"
db.execute "UPDATE  Cases SET comorbidity = 'true' WHERE lower(RawContent) like '% from % with %' "
puts db.changes


puts "update diabetes cases"
db.execute "UPDATE  Cases SET diabetes = 'true' WHERE lower(RawContent)  like '%diabetes%' or lower(RawContent)  like '%t2dm%' or lower(RawContent)  like '%mellitus%'"
puts db.changes

puts "update hypertension cases"
db.execute "UPDATE  Cases SET hypertension = 'true' WHERE lower(RawContent)  like '%hypertension%' or lower(RawContent)  like '%shtn%'"
puts db.changes

puts "update kidney diseases"
db.execute "UPDATE  Cases SET kidney = 'true' WHERE lower(RawContent)  like '%kidney%' or lower(RawContent)  like '%ckd%'"
puts db.changes

puts "update heart diseases"
db.execute "UPDATE  Cases SET heart = 'true' where lower(RawContent)  like '%heart%' or lower(RawContent)  like '%CAD%' "
puts db.changes

puts "updating additional comorbidity cases"
db.execute "UPDATE  Cases SET comorbidity = 'true' where diabetes='true' or hypertension='true' or kidney='true' or heart='true'"
puts db.changes