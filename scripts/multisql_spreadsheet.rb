require 'sqlite3'
require 'pp'
require 'rubyXL'
require 'rubyXL/convenience_methods'




database_filename = "tamilnadu_case.db"
xlsx_filename='multisql.xlsx'

report = [
    ["sheet 1","raw data","select * from Cases"],
    ["sheet 2","admission date ","select distinct admitted_on, count(admitted_on) from Cases where admitted_on !='' group by admitted_on order by count(admitted_on) desc"],
    ["sheet 3","died on","select distinct died_on, count(died_on) from Cases where died_on !='' group by admitted_on order by count(died_on) desc"],
    ["sheet 4","brought dead","select * from Cases where brought_dead='true' "],
    ["sheet 5","home dead","select * from Cases where home_death='true'"],
    ["sheet 6","deaths district wise","select distinct district, count(district) from Cases where district !='' group by district order by count(district) desc"],
    ["sheet 7","death by age", "select DISTINCT Age, count(Age) from cases where  AGE !=''  group by Age order by Age"]

]


workbook = RubyXL::Workbook.new

begin
    
    db = SQLite3::Database.open database_filename
	db.results_as_hash = true
       


report.each do |sheet| 
    worksheet = workbook.add_worksheet(sheet[1])
    puts sheet[0]
    puts sheet[1]
    puts sheet[2]
    ary = db.execute sheet[2]  

    #pp ary  
    puts "rows: " + ary.length.to_s
    puts "columns: " + ary.first.keys.length.to_s


    keys = ary.first.keys

keys.each_with_index do |header,column|
worksheet.add_cell(0, column, header)
end

    #pp keys
    ary.each_with_index do |value,row|
     #   pp row
       #pp value
        keys.each_with_index do |header,column|
       #     puts row, column
             #ary[row][keys[column]]
           worksheet.add_cell(row+1, column, value[header]) 
        end
    end



end
    
rescue SQLite3::Exception => e 
    
    puts "Exception occurred"
    puts e
    
ensure

end

workbook.write(xlsx_filename)
