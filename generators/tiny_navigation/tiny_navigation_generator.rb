class TinyNavigationGenerator < Rails::Generator::Base
  def manifest
    record do |m|
      m.file "tiny_navigation.rb", "config/tiny_navigation.rb"
    end
  end
end