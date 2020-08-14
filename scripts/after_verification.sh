ruby insert_to_sqlite.rb
sqlite3 -header -csv tamilnadu_case.db "select * from Cases;" > ../cases/cases.csv
ruby multisql_spreadsheet.rb 