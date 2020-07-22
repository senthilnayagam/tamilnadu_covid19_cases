
if ARGV.length < 2
	puts "pass two integer starting_number and ending_number"
	exit

end


starting_number = ARGV[0]
ending_number = ARGV[1]

(starting_number..ending_number).each do |number|

puts "Death Case No.#{number}:\nNo Data released\nhome death\n\n\n\n"

end