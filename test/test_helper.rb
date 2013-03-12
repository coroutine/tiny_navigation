# require rails stuff
require "rubygems"
require "bundler"

Bundler.setup
require "test/unit"
require "active_support"


# require gem/plugin
require "#{File.dirname(__FILE__)}/../init"
