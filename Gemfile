source 'https://rubygems.org'
git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end
ruby '2.4.1'
gem 'rails', '~> 5.0.2'
gem 'puma', '~> 3.0'
# gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.2'
gem 'jquery-rails'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.5'
gem "figaro"
gem 'country_select'
gem 'intl-tel-input-rails'
gem 'rails_script', '~> 2.0'
gem "rolify"
gem "validate_url"
gem 'simple_form'
gem "paperclip", "~> 5.0.0"
gem 'chosen-rails'
gem "roo", "~> 2.7.0"
gem 'toastr-rails'
gem 'kaminari'
gem 'jquery-ui-rails'
gem 'rails-jquery-autocomplete'
gem 'mailboxer'
gem 'sendinblue'
gem 'paypal-recurring',
    github: 'samuelsimoes/paypal-recurring',
    ref: '7dd39ffc001e2027ce5be1b908d419a312099006'
gem 'ransack'
gem 'thredded', '~> 0.13.8'
gem 'rails-ujs'
gem 'whenever', require: false
group :development, :test do
  gem 'byebug', platform: :mri
end
group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '~> 3.0.5'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
# gem 'bootstrap', '~> 4.0.0.alpha6'
gem 'devise'
gem 'devise_invitable'
gem 'pg'
gem 'slim-rails'
gem 'therubyracer', :platform=>:ruby
# source 'https://rails-assets.org' do
#   gem 'rails-assets-tether', '>= 1.3.3'
# end
group :development do
  gem 'hub', :require=>nil
  gem 'rails_layout'
  gem 'spring-commands-rspec'
end
group :development, :test do
  gem 'factory_girl_rails'
  gem 'faker'
  gem 'pry-rails'
  gem 'pry-rescue'
  gem 'rspec-rails'
end
group :test do
  gem 'capybara'
  gem 'database_cleaner'
  gem 'launchy'
  gem 'selenium-webdriver'
end
