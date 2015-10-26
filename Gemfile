source 'https://rubygems.org'

require File.expand_path 'spec/support/detect_rails_version', File.dirname(__FILE__)

gemspec
group :test do
  gem 'rails', detect_rails_version
  gem 'activeadmin', github: 'activeadmin', ref: '54bede0558a99ab759f98f9b24e1b0144063a81e'
  gem 'sqlite3'
  gem 'rspec-rails'

  gem 'launchy'
  gem 'database_cleaner'
  gem 'capybara'
  gem 'selenium-webdriver'
  gem 'poltergeist'
end
