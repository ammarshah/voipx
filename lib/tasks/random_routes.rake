namespace :random_routes do
  desc "Export 500 random routes to Spreadsheet"
  
  task export: :environment do
    require 'spreadsheet' # to write spreadsheet
    export_routes_book = Spreadsheet::Workbook.new # initiate a workbook
    export_routes_sheet = export_routes_book.create_worksheet name: 'Random Routes Exported' # create a new worksheet for 500 random routes
    export_routes_sheet.row(0).push 'Route ID', 'Destination', 'Breakout', 'Quality Type', 'Purchase Type', 'User ID', 'User Name' # add header on the first row

    counter = 0 # a counter just for logging after done exporting
    Route.all.limit(500).each do |route|
      begin
        puts "\n"
        user = User.find(route.user)
        puts "Inserting a new route...\t"
        puts route.breakout.code
        export_routes_sheet.insert_row(export_routes_sheet.last_row_index + 1, [route.id, route.breakout.destination, route.breakout.code.to_i, route.quality_type, route.purchase_type, user.id, user.name])
        puts "--- INSERTED! ---"
        counter += 1
      rescue Exception => e
        puts "=============== EXPORT 500 RANDOM ROUTES::Exception ==============="
        puts e.message
        puts "Route info: #{route.inspect}"
      end
    end
    export_routes_book.write 'random_routes_exported.xls' # write to worksheet and close
    puts "\n\n\n=== TASK COMPLETED!!! ==="
    puts "=== Added #{counter} routes ==="
  end
end