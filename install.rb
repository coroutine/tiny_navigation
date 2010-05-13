require 'rails_generator'
require 'rails_generator/scripts/generate'

Rails::Generator::Scripts::Generate.new.run(["simple_navigation", :destination => RAILS_ROOT])