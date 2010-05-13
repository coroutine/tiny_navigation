class SimpleNavigationGenerator < Rails::Generator::Base
  def manifest
    record do |m|
      m.file "simple_navigation.rb", "config/simple_navigation.rb"
    end
  end
end