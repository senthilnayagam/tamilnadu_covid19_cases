require 'sqlite3'
require 'pp'



begin
    
    db = SQLite3::Database.open "tamilnadu_case.db"



	db.results_as_hash = true
        
    ary = db.execute "SELECT * FROM Cases where Id > 24 "    
    # columns in table
    # RawContent, CaseNumber, Age, Gender, District, DeathCause, admitted_on ,died_on , sample_taken_on , result_on 



    ary.each do |row|
    	admitted_on,died_on,sample_taken_on,result_on='','','',''
        #printf "%s, %s,  %s,  %s,  %s,  %s,  %s \n", row['CaseNumber'], row['District'], row['Age'], row['admitted_on'],row['died_on'],row['sample_taken_on'],row['result_on']
        
        begin

        admitted_on =Date.strptime(row['admitted_on'], '%d-%m-%Y') if row['admitted_on'] != ''
        died_on  = Date.strptime(row['died_on'], '%d-%m-%Y') if row['died_on'] != ''
        sample_taken_on =  Date.strptime(row['sample_taken_on'], '%d-%m-%Y') if row['sample_taken_on'] != ''
        result_on = Date.strptime(row['result_on'], '%d-%m-%Y') if row['result_on'] != ''
        #puts "case: " + row['CaseNumber'].to_s + " # admission to death: " + (died_on-admitted_on).to_i.to_s if died_on !='' && admitted_on !=''
        #puts "Age: " + row['Age'].to_s + " # admission to death: " + (died_on-admitted_on).to_i.to_s if died_on !='' && admitted_on !=''
        puts row['Age'].to_s + "," + (died_on-admitted_on).to_i.to_s if died_on !='' && admitted_on !=''

    rescue ArgumentError => ee
    	puts ee
    	printf "%s, %s,  %s,  %s,  %s,  %s,  %s \n", row['CaseNumber'], row['District'], row['Age'], row['admitted_on'],row['died_on'],row['sample_taken_on'],row['result_on']
    end



    end


    
rescue SQLite3::Exception => e 
    
    puts "Exception occurred"
    puts e
    
ensure

end