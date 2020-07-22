require 'sqlite3'
require 'pp'
require 'rubyXL'
require 'rubyXL/convenience_methods'


begin
    
    db = SQLite3::Database.open "tamilnadu_case.db"



	db.results_as_hash = true
        
    ary = db.execute "SELECT * FROM Cases where Id > 24 "    
    # columns in table
    # RawContent, CaseNumber, Age, Gender, District, DeathCause, admitted_on ,died_on , sample_taken_on , result_on 

    # 0 set as default value
    rows, cols = 100,100  # your values
    grid = Array.new(rows) { Array.new(cols,0) }



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
        if died_on !='' && admitted_on !=''
        treatment_days = (died_on-admitted_on).to_i
        age = row['Age']

        #puts row['Age'].to_s + "," + treatment_days.to_s 
        grid[age][treatment_days]+=1
        end

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

#puts grid


workbook = RubyXL::Workbook.new
worksheet = workbook.add_worksheet('age correlation death days from admission date')


worksheet.add_cell(0, 0, "Age Days")

(1..100).each  do |row|
worksheet.add_cell(row, 0, row)
end


(0..100).each  do |column|
worksheet.add_cell(0, column+1, column)
end    

(0..99).each  do |row|
    (0..99).each  do |column|
        worksheet.add_cell(row, column+1, grid[row][column]) if grid[row][column] != 0
    end
end



workbook.write("test.xlsx")
