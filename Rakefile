require 'json'
require 'mongoid'
require 'rake/testtask'

require_relative 'models/runtime'
require_relative 'crawler'

Mongoid.load!('config/mongoid.yml')

# crawling
namespace :crawler do

  desc 'Crawls all runtimes'
  task :all do
    Crawler.new.all
  end

end

# tests
Rake::TestTask.new do |t|
  t.warning = true
  t.verbose = true
  t.test_files = FileList['test/**/test*.rb']
end

task :default => [:test]