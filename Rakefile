require 'json'
require 'mongoid'

require_relative 'crawler'

# only bootstrap necessary dbs here so mongodb?!
Mongoid.load!('config/mongoid.yml')
Mongo::Logger.logger.level = ::Logger::INFO

# crawling
namespace :crawler do
  desc 'Crawls all runtimes'
  task :all do
    Crawler.new.all
  end
end

# tests
require 'rake/testtask'
Rake::TestTask.new do |t|
  t.warning = true
  t.verbose = true
  t.test_files = FileList['test/**/test*.rb']
end

require 'rubocop/rake_task'
RuboCop::RakeTask.new

# first check code style, then execute the tests
task default: [:rubocop, :test]
