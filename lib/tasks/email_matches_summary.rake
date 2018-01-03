namespace :email_matches_summary do
  desc "Sends a summary of route matches to all users"
  
  task send: :environment do
    begin
      User.all.each do |user|
        all_matches_hash = Hash.new
        user.routes.each do |route|
          unnotified_matches = route.get_unnotified_matches
          if unnotified_matches.any?
            all_matches_hash[route.id] = unnotified_matches
            unnotified_matches.each do |un_m| # mark as notified
              NotifiedMatch.create(user: user, route: route, match: un_m)
            end
          end
        end
        if all_matches_hash.any?
          UserMailer.matches_summary(user, all_matches_hash).deliver_now
        end
      end
      puts "=== Sent matches summary at #{Time.now} ==="
    rescue Exception => e
      puts "=============== EMAIL MATCHES SUMMARY::Exception ==============="
      puts e.message
    end
  end

end