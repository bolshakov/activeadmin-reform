source 'https://rubygems.org'

require File.expand_path 'spec/support/detect_rails_version', File.dirname(__FILE__)

gemspec
group :test do
  gem 'rails', detect_rails_version
  gem 'activeadmin', github: 'activeadmin', ref: '3aae773f978ad176cb8b5ebde3f2e2fc7652ed89'
  gem 'sqlite3'
  gem 'rspec-rails'

  gem 'launchy'
  gem 'database_cleaner'
  gem 'capybara'
end
