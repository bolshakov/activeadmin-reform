$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
$LOAD_PATH << File.expand_path('../support', __FILE__)
require 'detect_rails_version'

# ENV['BUNDLE_GEMFILE'] = File.expand_path('../../Gemfile', __FILE__)
require 'bundler'
Bundler.setup

ENV['RAILS_ENV'] = 'test'
rails_root = File.expand_path('../dummy', __FILE__)

# Create the test app if it doesn't exists
unless File.exists?(rails_root)
  system 'rake setup'
end

# Ensure the Active Admin load path is happy
require 'rails'
require 'active_model'
require 'ransack/constants'
require 'ransack/adapters/active_record/ransack/constants'
require 'active_admin'
# ActiveAdminbi .application.load_paths = [rails_root + "/app/admin"]

require rails_root + '/config/environment.rb'

# Disabling authentication in specs so that we don't have to worry about
# it allover the place
ActiveAdmin.application.authentication_method = false
ActiveAdmin.application.current_user_method = false

require 'rspec/rails'
require 'capybara/rails'
require 'capybara/rspec'
require 'capybara/poltergeist'

Capybara.register_driver :poltergeist do |app|
  Capybara::Poltergeist::Driver.new(app,
                                    js_errors: true,
                                    timeout: 80,
                                    debug: true,
                                    phantomjs_options: ['--debug=no', '--load-images=no']
                                   )
end

Capybara.javascript_driver = :poltergeist

RSpec.configure do |config|
  config.use_transactional_fixtures = false

  config.before(:suite) do
    DatabaseCleaner.strategy = :truncation
    DatabaseCleaner.clean_with(:truncation)
  end
  config.before(:each) do
    DatabaseCleaner.strategy = :truncation
    DatabaseCleaner.start
  end
  config.after(:each) do
    DatabaseCleaner.clean
  end
end
