require 'sqlite3'
require 'pp'



begin
    
    db = SQLite3::Database.open "tamilnadu_case.db"



	db.results_as_hash = true
        
    ary = db.execute "SELECT * FROM Cases where Id > 24 "    
    # columns in table
    # RawContent, CaseNumber, Age, Gender, District, DeathCause, admitted_on ,died_on , sample_taken_on , result_on 

    ary.each do |row|
        printf "%s, %s,  %s,  %s,  %s,  %s,  %s \n", row['CaseNumber'], row['District'], row['Age'], row['admitted_on'],row['died_on'],row['sample_taken_on'],row['result_on']
        puts Date.strptime(row['admitted_on'], '%d-%m-%Y') if row['admitted_on'] != ''
    end


    
rescue SQLite3::Exception => e 
    
    puts "Exception occurred"
    puts e
    
ensure

end