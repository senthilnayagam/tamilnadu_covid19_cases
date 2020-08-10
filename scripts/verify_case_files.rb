
require 'pp'
require './parse_logic.rb'


puts "Verification starts"
error=false

error_records =[]
(1..10000).each do |i|  # 1.. 1636 # put a big number so as not to increase the count daily
	filename = "../cases/case_"+i.to_s.rjust(4, "0")+".txt"
	#filename = "../data/dump/case_"+i.to_s.rjust(4, "0")+".txt"
	case_number = i.to_s 

	if File.file?(filename)
	f = File.open(filename)


  	res = parse_data(f.read)
	  	if res['case_number'] != case_number
	  		error_records.append( filename + " : " + res['case_number'] + " | " + case_number + " : did not match")
	  		error =true
	  	end


	end
end

if error
puts "#### there was error ####"
pp error_records
else
puts "#### All records are fine ####"
end