source 'https://rubygems.org'

require File.expand_path 'spec/support/detect_rails_version', File.dirname(__FILE__)

gemspec
group :test do
  gem 'rails', detect_rails_version
  gem 'activeadmin', github: 'activeadmin/activeadmin'
  gem 'sqlite3'
  gem 'rspec-rails'
  gem 'test-unit', '~> 3.0' # Rails 3.2 support

  gem 'launchy'
  gem 'database_cleaner'
  gem 'capybara'

  gem 'codeclimate-test-reporter', require: nil
end
