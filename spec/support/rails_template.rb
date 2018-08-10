# Rails template to build the sample app for specs

# Configure default_url_options ein test environment
environment <<-RUBY, env: 'test'
  config.action_mailer.default_url_options = { host: 'example.com' }
RUBY

environment <<-RUBY
  require 'active_admin'
  $LOAD_PATH.unshift('#{File.expand_path(File.join(File.dirname(__FILE__), '..', '..', 'lib'))}')
RUBY

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

# Setup a root path for devise
route "root :to => 'admin/dashboard#index'"

run 'rm Gemfile'
run 'rm -rf spec'

do_after_bundle = lambda do
  generate :model, 'author name:string{10}:uniq last_name:string birthday:date --no-test-framework'
  generate :model, 'post text --no-test-framework'
  generate :model, 'comment post:references text --no-test-framework'
  %w(Base ApplicationRecord).each do |base_class|
    inject_into_file 'app/models/author.rb', <<-RUBY, after: "#{base_class}\n"
      validates :name, length: { minimum: 2 }, allow_nil: true
    RUBY
    inject_into_file 'app/models/post.rb', <<-RUBY, after: "#{base_class}\n"
      validates :text, presence: true
      has_many :comments
    RUBY
  end
  generate :'active_admin:install --skip-users'
  rake 'db:migrate'

  copy_file(File.expand_path('../../templates/author_form.rb', __FILE__), 'app/models/author_form.rb')
  copy_file(File.expand_path('../../templates/commenter_form.rb', __FILE__), 'app/models/commenter_form.rb')
  copy_file(File.expand_path('../../templates/post_form.rb', __FILE__), 'app/models/post_form.rb')
end

if Rails.respond_to?(:gem_version) && Rails.gem_version >= Gem::Version.new('4.2')
  after_bundle(&do_after_bundle)
else
  run 'bundle install'
  do_after_bundle.call
end
