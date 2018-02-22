namespace :old_users_and_breakouts_data do
  desc "Import old users and breakouts data from CSV file"
  
  task import: :environment do
    require 'csv'
    users_counter = 0
    routes_counter = 0
    CSV.foreach('./test_file.csv', headers: true) do |row|
      begin
        puts "\n"
        row_hash = row.to_h
        
        random_password = [*('a'..'z'),*('0'..'9')].shuffle[0,10].join
        
        user = User.find_by_email(row_hash['user_email'])
        unless user
          puts "Adding a new user: #{row_hash['user_email']}"
          user = User.new(first_name: row_hash['user_fname'], last_name: row_hash['user_lname'], email: row_hash['user_email'], password: random_password, password_confirmation: random_password)
          user.confirm
          user.save!
          users_counter += 1
          puts "Sending welcome email to #{user.email}..."
          # send campaign email here
        end
        
        breakout = Breakout.find_by_code(row_hash['code'])
        if breakout
          purchase_type = row_hash['service_id'] == '1' ? 'buy' : 'sell'
          quality_type = row_hash['cli'] == '1' ? 'cli' : 'non_cli'
          puts "Adding a new route of '#{user.email}' with details (breakout: #{breakout.code}, destination: #{breakout.destination}, price: #{row_hash['targetrate']}, quality_type: #{quality_type}(#{row_hash['cli']}), purchase_type: #{purchase_type}(#{row_hash['service_id']})"
          route = user.routes.new(purchase_type: purchase_type, quality_type: quality_type, price: row_hash['targetrate'], breakout: breakout)
          route.save!
          routes_counter += 1
        end
      rescue Exception => e
        puts "=============== OLD USERS DATA IMPORT::Exception ==============="
        puts e.message
        puts "Row info: #{row}"
      end
    end
    puts "\n\n\n=== TASK COMPLETED!!! ==="
    puts "=== Added #{users_counter} #{'user'.pluralize(users_counter)} and #{routes_counter} #{'route'.pluralize(routes_counter)} ==="
  end
end