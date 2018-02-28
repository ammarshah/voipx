namespace :old_users_and_breakouts_data do
  desc "Import old users and breakouts data from CSV file"
  
  task import: :environment do
    require 'csv' # to read CSV file
    require 'spreadsheet' # to write spreadsheet
    import_users_book = Spreadsheet::Workbook.new # initiate a workbook
    import_users_sheet = import_users_book.create_worksheet name: 'Users Imported' # create a new worksheet for entries of successfully imported users into the database
    import_users_sheet.row(0).push 'First Name', 'Last Name', 'Email', 'Company Name', 'Set Password Link' # add header on the first row
    badass_breakouts_book = Spreadsheet::Workbook.new # initiate a workbook
    badass_breakouts_sheet = badass_breakouts_book.create_worksheet name: 'Badass Breakouts' # create a new worksheet for entries of breakouts that are not found in the database
    badass_breakouts_sheet.row(0).push 'Destination', 'Code' # add header on the first row
    include Rails.application.routes.url_helpers # to use `user_confirmation_url` helper
    default_url_options[:host] = Rails.application.secrets.domain_name # set host in default_url_options

    users_counter = 0 # a counter just for logging after done importing
    routes_counter = 0 # a counter just for logging after done importing
    CSV.foreach('./old_user_data_buy_sell_only.csv', headers: true) do |row|
      begin
        puts "\n"
        row_hash = row.to_h # converts to a hash
 
        user = User.find_by_email(row_hash['user_email'])
        unless user
          puts "Adding a new user: #{row_hash['user_email']}"
          user = User.new(first_name: row_hash['user_fname'], last_name: row_hash['user_lname'], email: row_hash['user_email'])
          user.skip_confirmation_notification!
          if user.save
            users_counter += 1
            print "Adding to excel sheet\t"
            import_users_sheet.insert_row(import_users_sheet.last_row_index + 1, [row_hash['user_fname'], row_hash['user_lname'], row_hash['user_email'], row_hash['cname'], user_confirmation_url(confirmation_token: user.confirmation_token)])
            puts "--- ADDED! ---"
          end
        end
        
        breakout = Breakout.find_by_code(row_hash['code'])
        if breakout
          purchase_type = row_hash['service_id'] == '1' ? 'buy' : 'sell'
          quality_type = row_hash['cli'] == '1' ? 'cli' : 'non_cli'
          puts "Adding a new route of '#{user.email}' with details (breakout: #{breakout.code}, destination: #{breakout.destination}, price: #{row_hash['targetrate']}, quality_type: #{quality_type}(#{row_hash['cli']}), purchase_type: #{purchase_type}(#{row_hash['service_id']})"
          route = user.routes.new(purchase_type: purchase_type, quality_type: quality_type, price: row_hash['targetrate'], breakout: breakout)
          route.save!
          routes_counter += 1
        else
          print "Marking '#{row_hash['code']}' breakout as badass\t"
          badass_breakouts_sheet.insert_row(badass_breakouts_sheet.last_row_index + 1, [row_hash['countryname'], row_hash['code']])
          puts "--- MARKED! ---"
        end
      rescue Exception => e
        puts "=============== OLD USERS DATA IMPORT::Exception ==============="
        puts e.message
        puts "Row info: #{row}"
      end
    end
    import_users_book.write 'users_imported.xls' # write to worksheet and close
    badass_breakouts_book.write 'badass_breakouts.xls' # write to worksheet and close
    puts "\n\n\n=== TASK COMPLETED!!! ==="
    puts "=== Added #{users_counter} #{'user'.pluralize(users_counter)} and #{routes_counter} #{'route'.pluralize(routes_counter)} ==="
  end
end