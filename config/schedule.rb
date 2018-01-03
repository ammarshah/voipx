set :output, "#{path}/log/cron_log.log"

every :day, at: '7am' do
  rake "email_matches_summary:send"
end