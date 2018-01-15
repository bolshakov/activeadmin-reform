require 'yaml'

ruby_versions = %w(2.2.2 ruby-head)

[
  { rails: '3.2.22.5', active_admin: '1.0.0.pre5' },
  { rails: '4.2.10', active_admin: '1.2.1' },
  # { rails: '5.1.4', active_admin: '1.2.1' },
].each do |deps|
  appraise "rails_#{deps[:rails]}_active_admin_#{deps[:active_admin]}" do
    gem 'rails', deps[:rails]
    gem 'activeadmin', deps[:active_admin]
  end
end

travis = ::YAML.dump(
  'language' => 'ruby',
  'rvm' => ruby_versions,
  'allow_failures' => {
    'rvm' => ['ruby-head']
  },
  'before_script' => [
    './bin/setup',
   ],
  'script'  => [
    'bundle exec rake spec',
    'bundle exec rubocop --fail-level C'
  ],
  'gemfile' => Dir.glob('gemfiles/*.gemfile'),
  'addons' => {
    'code_climate' => {
      'repo_token' => 'c326cca5984d0e32d2c6b5d9b985756ee9312f63fc6a9480fc9cfa55c454d68a'
    }
  }


)

::File.open('.travis.yml', 'w+') do |file|
  file.write(travis)
end
