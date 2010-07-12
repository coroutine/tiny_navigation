module Coroutine              #:nodoc:
  module TinyNavigation       #:nodoc:
    module Controller         #:nodoc:
      
      # This module provides the core controller functionality implemented by 
      # the gem.
      #
      module Base
      
        def self.included(base)   #:nodoc:
          base.send(:include, InstanceMethods)
          base.send(:helper_method, :navigation)
        end
      
    
        # This module contains instance methods that will be mixed into the extended
        # controller.
        #
        module InstanceMethods
          private
      
          # This method returns a Coroutine::TinyNavigation::Data::Navigation object for 
          # the supplied navigation name.
          #
          def navigation(which_navigation)
            config = Coroutine::TinyNavigation::Data::Config.new self
            config.nav[which_navigation]
          end
        end
    
      end
      
      
    end
  end
end