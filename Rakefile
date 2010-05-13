require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'

desc 'Default: run unit tests.'
task :default => :test

desc 'Test the simple_navigation plugin.'
Rake::TestTask.new(:test) do |t|
  t.libs << 'lib'
  t.libs << 'test'
  t.pattern = 'test/**/*_test.rb'
  t.verbose = true
end

desc 'Generate documentation for the simple_navigation plugin.'
Rake::RDocTask.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'SimpleNavigation'
  rdoc.options << '--line-numbers' << '--inline-source'
  rdoc.rdoc_files.include('README')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gemspec|
    gemspec.name        = "simple_navigation"
    gemspec.summary     = "SimpleNavigation provides an easy-to-use DSL for defining navigation structures."
    gemspec.description = "SimpleNavigation makes it easy to define site navigation using a small DSL."
    gemspec.email       = "gems@coroutine.com"
    gemspec.homepage    = "http://github.com/coroutine/simple_navigation"
    gemspec.authors     = ["Coroutine", "Tim Lowrimore"]
  end
rescue LoadError
  puts "Jeweler not available. Install it with: gem install jeweler"
end