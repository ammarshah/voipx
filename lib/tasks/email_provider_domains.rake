namespace :email_provider_domains do

  desc "Read email_provider_domains.txt file, remove duplicate domains and sort"
  task remove_duplicates: :environment do
    puts "Reading file..."
    domains = File.read("./email_provider_domains.txt").split("\n")
    puts "Total domains before removing duplicates: #{domains.count}"

    puts "Removing empty values..."
    domains = domains.reject { |d| d.empty? }

    puts "Downcasing each domain..."
    domains = domains.map { |d| d.downcase }

    puts "Fetching unique domains..."
    domains = domains.uniq

    puts "Sorting domains..."
    domains = domains.sort
    begin
      puts "Re-writing unique domains only..."
      File.open("email_provider_domains.txt", "w+") { |file| file.puts domains }
    rescue Exception => e
      puts "=============== REMOVING DUPLICATES:: Exception ==============="
      puts e.message
    end
    puts "Total domains afer removing duplicates: #{domains.uniq.count}"
    puts "=== COMPLETED!!! ==="
  end


  desc "Import all domains data from email_provider_domains.txt file"
  task import: :environment do
    EmailProviderDomain.delete_all
    ActiveRecord::Base.connection.execute("ALTER SEQUENCE email_provider_domains_id_seq RESTART WITH 1")

    puts "Reading file..."
    domains = File.read("./email_provider_domains.txt").split("\n")
    domains_counter = 0
    domains.each do |domain|
      begin
        puts "Adding new domain (#{domain})"
        domain = EmailProviderDomain.new(name: domain)
        domain.save!
        domains_counter += 1
      rescue Exception => e
        puts "=============== IMPORTING DOMAINS:: Exception ==============="
        puts e.message
      end
    end
    puts "=== Added #{domains_counter} domains ==="
    puts "=== COMPLETED!!! ==="
  end

end