module Coroutine
  module SimpleNavigation
    class Navigation
      
      attr_reader :name, :items
      
      # Creates a new navigation.
      # 
      # <tt>name</tt> is the unique identifer of the navigation.
      # 
      # <tt>current_controller</tt> the currently loaded controller
      # 
      # The block given to the navigation item is used to define navigation
      # items of this navigation object.
      def initialize(name, current_controller, &block)
        @items                    = []
        @name                     = name
        @current_controller     = current_controller
        
        self.instance_eval(&block) if block_given?
      end
      
      # Returns an array of selected navigation items.  The array represents a
      # bread-crumb list in that the head of the list represents a top-level
      # navigation item, and the tail of the list represents selected sub-navigation
      # items.
      def selected(item=self)
        items = []
        item.items.each do |item|
          items << item << selected(item) if item.selected?
        end
        items.flatten
      end
      
      def method_missing(method_name, *args) #:nodoc:
        @current_controller.send method_name, *args
      end
      
      private
      
      def item(name, options={}, &block)
        @items << Item.new(name, @current_controller, options, &block)
      end
      
    end
  end
end