module Coroutine                        #:nodoc:
  module TinyNavigation                 #:nodoc:
    module Data                         #:nodoc:
      
      # This class represents a navigation tree. It holds all the data for tree
      # and provides a number of convenience methods related to that tree.
      #
      class Navigation
        
        attr_reader :name, :items
      
        # This method creates a new navigation data object.
        # 
        # <tt>name</tt> is the unique identifer of the navigation.
        # 
        # <tt>current_controller</tt> the currently loaded controller
        # 
        # The block given to the navigation item is used to define navigation
        # items of this navigation object.
        #
        def initialize(name, current_controller, &block)
          @items                  = []
          @name                   = name
          @current_controller     = current_controller
        
          self.instance_eval(&block) if block_given?
        end
      
        # This method returns an array of selected navigation items. The array 
        # represents a bread-crumb list in that the head of the list represents 
        # a top-level navigation item, and the tail of the list represents selected 
        # sub-navigation items.
        #
        # <tt>item</tt> is the reference point for the calculation.
        #
        def selected(item=self)
          items = []
          item.items.each do |item|
            items << item << selected(item) if item.selected?
          end
          items.flatten
        end
      
        # This method delegates method missing calls to the controller, in case 
        # the navigation item has user-defined properties.
        #
        def method_missing(method_name, *args) #:nodoc:
          @current_controller.send method_name, *args
        end
      
      
        private
        
        # This method adds a new item to the items collection.
        #
        # <tt>name</tt> is the friendly name for the navigation item.
        #
        # <tt>options</tt> is a hash containing any user-defined properties.
        #
        def item(name, options={}, &block)
          @items << Item.new(name, @current_controller, options, &block)
        end
      
      end
    
    end
  end
end