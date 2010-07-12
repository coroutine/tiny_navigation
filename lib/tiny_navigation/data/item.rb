module Coroutine                        #:nodoc:
  module TinyNavigation                 #:nodoc:
    module Data                         #:nodoc:
      
      # This class represents a navigation item. It holds all the data for item
      # and provides a number of convenience methods related to that item.
      #
      class Item < Navigation
      
        # This method creates a new instance of a navigation item.
        # 
        # <tt>name</tt> is the name of the navigation item.  The name should
        # be used for the label text when rendering the navigation item.
        # 
        # <tt>current_controller</tt> the currently loaded controller
        #
        # <tt>options</tt> provide configuration options and custom properties
        # to the nav item.  Currently, the only configuration option is
        # <tt>:to</tt> which is used to generate the URL of the navigation item.
        # All other options provided to via the <tt>options</tt> hash will be
        # treated as custom properties on the navigation item.  These custom
        # properties can be accessed as methods on the navigation item.
        # 
        # The block given to the navigation item is used to define sub-navigation
        # items of this item.
        #
        def initialize(name, current_controller, options={}, &block)
          super name, current_controller, &block
          set_controller_and_action options.delete(:to)
          @extra_options = options
        end
      
        # This method indicates whether the navigation item is currently selected.  
        # This takes into account any sub-nav items such that a parent item is 
        # selected if it has a selected child.
        #
        def selected?
          @controller_name == @current_controller.controller_name || @items.any?(&:selected?)
        end
      
        # This method returns the URL to which the navigation item points. This 
        # should be used in a scenario where the navigation item represents a link 
        # and the URL is the href of that link.
        #
        def url
          @current_controller.url_for :controller => @controller_name, :action => @action_name
        end
      
        # This method uses the extra_options hash takes precendence when looking 
        # for the called method. Otherwise, we'll let the super-class forward
        # the method call to the current controller.
        #
        def method_missing(method_name, *args) #:nodoc:
          if @extra_options.has_key? method_name
            @extra_options[method_name]
          else
            super method_name, *args
          end
        end
      
      
        private
      
        # This method converts the :to option value into controller and action
        # values.
        #
        def set_controller_and_action(to)
          if to
            controller_and_action = to.split "#"
            @controller_name      = controller_and_action.shift
            @action_name          = controller_and_action.shift || "index"
          end
        end
      end
      
    end
  end
end