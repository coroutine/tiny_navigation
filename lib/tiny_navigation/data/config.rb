module Coroutine                        #:nodoc:
  module TinyNavigation                 #:nodoc:
    module Data                         #:nodoc:
      
      # This class represents a configuration object. It is responsible for reading in the 
      # DSL and converting it to a structured set of navigation objects.
      #
      class Config #:nodoc:
      
        attr_reader :nav
        
        # This method creates a new configuration object. It reads in the configuration
        # file and saves the contents to a class variable so it only has to be loaded
        # once.
        #
        # <tt>current_controller</tt> is a reference to the controller object being extended.
        #
        # <tt>config</tt> is the location of the config file to load. Defaults to the generated
        # file.
        #
        def initialize(current_controller, conf=File.join(Rails.root, "config", "tiny_navigation.rb"))
          @current_controller = current_controller
          @nav = {}
        
          Config.class_eval { class << self; attr_reader :file end; @file ||= File.read(conf) }
          
          self.instance_eval(Config.file)
        end
      
      
        private
      
        # This method adds a navigation structure to the application.
        #
        # <tt>name</tt> is the key in the navigation hash.
        #
        def navigation(name, &block)
          raise "Navigation names must be unique.  You specified '#{name}' twice." if @nav.has_key?(name)
          @nav[name] = Navigation.new(name, @current_controller, &block)
        end
      
      end
      
    end
  end
end