source 'https://rubygems.org'

require File.expand_path 'spec/support/detect_rails_version', File.dirname(__FILE__)

gemspec
group :test do
  gem 'rails', detect_rails_version
  gem 'activeadmin', github: 'activeadmin', ref: 'ba285ea2fc23ade108ed582134cae8c641f910a4'
  gem 'sqlite3', '~> 1.3.11'
  gem 'rspec-rails', '~> 3.4.0'
  gem 'test-unit', '~> 3.0' # Rails 3.2 support

  gem 'launchy', '~> 2.4.3'
  gem 'database_cleaner', '~> 1.5.1'
  gem 'capybara', '~> 2.5.0'
  gem 'poltergeist'

  gem 'codeclimate-test-reporter', '~> 0.4.8', require: nil
end
