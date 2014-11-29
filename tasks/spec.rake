ENV['BUNDLE_GEMFILE'] = File.dirname(__FILE__) + '/../Gemfile'

require 'rake'
require 'rake/testtask'
require 'rspec'
require 'rspec/core/rake_task'

desc "Run the test suite"
task :spec => ['spec:setup', 'spec:hikari_lib', 'spec:cleanup']

namespace :spec do
  desc "Setup the test environment"
  task :setup do
  end
  
  desc "Cleanup the test environment"
  task :cleanup do
    File.delete(File.expand_path(File.dirname(__FILE__) + '/../spec/test.db'))
  end
  
  desc "Test hikari"
  RSpec::Core::RakeTask.new(:hikari_lib) do |task|
    hikari_root = File.expand_path(File.dirname(__FILE__) + '/..')
    task.pattern = hikari_root + '/spec/lib/**/*_spec.rb'
  end

  desc "Run the coverage report"
  RSpec::Core::RakeTask.new(:rcov) do |task|
    hikari_root = File.expand_path(File.dirname(__FILE__) + '/..')
    task.pattern = hikari_root + '/spec/lib/**/*_spec.rb'
    task.rcov=true
    task.rcov_opts = %w{--rails --exclude osx\/objc,gems\/,spec\/,features\/}
  end
end
