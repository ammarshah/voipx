PayPal::Recurring.configure do |config|
  config.sandbox = Rails.application.secrets.paypal_sandbox
  config.username = Rails.application.secrets.paypal_username
  config.password = Rails.application.secrets.paypal_password
  config.signature = Rails.application.secrets.paypal_signature
end
