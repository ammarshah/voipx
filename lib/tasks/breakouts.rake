namespace :breakouts do
  desc "Import breakouts data from excel sheet"
  
  task import: :environment do
    Breakout.delete_all
    ActiveRecord::Base.connection.execute("ALTER SEQUENCE breakouts_id_seq RESTART WITH 1")

    sheet = Roo::Spreadsheet.open('./breakouts.xlsx')
    breakouts_counter = 0
    (6..sheet.last_row).each do |i|
      begin
        row = sheet.row(i)
        codes = row[0].to_s.split(",")
        codes.each do |code|
          puts "Adding new breakout with CODE: #{code} and DESTINATION: #{row[1]}"
          breakout = Breakout.new(code: code, destination: row[1])
          breakout.save!
          breakouts_counter += 1
        end
      rescue Exception => e
        puts "=============== BREAKOUTS:: Exception ==============="
        puts e.message
        puts "Row no in breakouts excel sheet is #{i}"
      end
    end
    puts "=== Added #{breakouts_counter} breakouts ==="
  end

end