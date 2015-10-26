# Rails template to build the sample app for specs

# Configure default_url_options ein test environment
environment <<-RUBY, env: 'test'
  config.action_mailer.default_url_options = { host: 'example.com' }
RUBY

environment <<-RUBY
  $LOAD_PATH.unshift('#{File.expand_path(File.join(File.dirname(__FILE__), '..', '..', 'lib'))}')
RUBY

copy_file(File.expand_path('../../templates/author_form.rb', __FILE__), 'app/models/author_form.rb')

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

# Setup a root path for devise
route "root :to => 'admin/dashboard#index'"

run 'rm Gemfile'

do_after_bundle = lambda do
  Bundler.with_clean_env do
    generate :model, 'author name:string{10}:uniq last_name:string birthday:date'
    generate :'active_admin:install --skip-users'
    rake 'db:migrate'
  end
end

if Rails.gem_version >= Gem::Version.new('4.2')
  after_bundle(&do_after_bundle)
else
  run 'bundle install'
  do_after_bundle.call
end



