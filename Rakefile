require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'

desc 'Default: run unit tests.'
task :default => :test

desc 'Test the tiny_navigation plugin.'
Rake::TestTask.new(:test) do |t|
  t.libs << 'lib'
  t.libs << 'test'
  t.pattern = 'test/**/*_test.rb'
  t.verbose = true
end

desc 'Generate documentation for the tiny_navigation plugin.'
Rake::RDocTask.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'TinyNavigation'
  rdoc.options << '--line-numbers' << '--inline-source'
  rdoc.rdoc_files.include('README')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gemspec|
    gemspec.authors     = ["Coroutine", "Tim Lowrimore"]
    gemspec.description = "TinyNavigation makes it easy to define site navigation using a small DSL."
    gemspec.email       = "gems@coroutine.com"
    gemspec.homepage    = "http://github.com/coroutine/tiny_navigation"
    gemspec.name        = "tiny_navigation"
    gemspec.summary     = "TinyNavigation provides an easy-to-use DSL for defining navigation structures."
    
    gemspec.add_dependency("action_pack", ">= 2.3.4")
    gemspec.add_dependency("active_support", ">= 2.3.4")
    gemspec.files.include("lib/**/*.rb")
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler not available. Install it with: gem install jeweler"
end