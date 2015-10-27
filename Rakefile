require 'bundler/gem_tasks'
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec)

task default: :spec

desc 'Creates a test rails app for the specs to run against'
task :setup do
  source_path = 'spec/dummy'
  template = 'spec/support/rails_template.rb'
  system <<-BASH
    bundle exec rails new #{source_path} -m #{template} --skip-spring --skip-git --skip-turbolinks --skip-test-unit
  BASH
end
