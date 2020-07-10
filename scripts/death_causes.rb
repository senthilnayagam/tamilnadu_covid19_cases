require './parse_logic.rb'

(1..3000).each do |i|  # 1.. 1636 # put a big number so as not to increase the count daily
	filename = "../cases/case_"+i.to_s.rjust(4, "0")+".txt"

	if File.file?(filename)
	f = File.open(filename)


  	res = parse_data(f.read)
	#puts res['death_cause']
	end
end

