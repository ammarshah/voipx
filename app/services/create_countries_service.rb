class CreateCountriesService
  def call
    Country.delete_all
    ActiveRecord::Base.connection.execute("ALTER SEQUENCE countries_id_seq RESTART WITH 1")
    ISO3166::Country.all.each do |c|
      begin
        cr = c.currency
        Country.create(
          name: c.name,
          code: c.alpha3,
          alpha2: c.alpha2,
          alpha3: c.alpha3,
          phone_code: c.country_code
        )  
      rescue Exception => e
        puts "#{e.message}"
        puts "Error! in #{c.name} #{c.alpha2}"  
      end
    end
  end
end
