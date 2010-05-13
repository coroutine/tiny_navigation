require 'simple_navigation/item'
require 'simple_navigation/navigation'

module Coroutine
  
  # SimpleNavigation provides an easy-to-use DSL for defining navigation structures;
  # these structures are defined in config/simple_navigation.rb.
  # 
  # == Here are a few things SimpleNavigation WILL do:
  # 
  #   * It provides the ability to define and map menu items to resources using the 
  #     convention set forth in the Rails 3 router.  For example, to map a menu item 
  #     _Foo_ to the <tt>show</tt> action of the <tt>foos_controller</tt> simply do:
  # 
  #       navigation :top_tabs do
  #         item "Foo", :to => "foos#show"
  #       end
  # 
  #     If one were to omit the specified action from the <tt>:to</tt> option, the
  #     navigation item's action would default to <tt>index</tt>.
  # 
  #     The URL generated from this mapping can be accessed via the <tt>url</tt>
  #     method of the navigation item.
  # 
  #   * It provides a <tt>selected</tt> method for getting the selected menu items of
  #     a navigational structure.  For example, for this definition:
  #
  #       navigation :main do
  #         item "Foo", :to => "foos#index"
  #         item "Bar", :to => "bars#index" do
  #           item "Baz", :to => "bazzs#index"
  #         end
  #       end
  # 
  #     If the menu item _Foo_ is selected, an array containing that menu item is
  #     returned.  However, if the menu item _Baz_ is selected, an array containing
  #     the _Bar_ and the _Baz_ menu items.  This is useful for generating bread-crumbs
  #     or simply highlighting both the main nav item and its selected sub-nav item.
  # 
  #   * It allows for the declaration of custom attributes on nav items.  For instance,
  #     given the configuration in the previous example, we want to right-align the _Bar_
  #     navigation item.  To do this we could simply add another option to the item:
  # 
  #       navigation :main do
  #         item "Foo", :to => "foos#index", :align => :left
  #         item "Bar", :to => "bars#index", :align => :right do
  #           item "Baz", :to => "bazzs#index"
  #         end
  #       end
  # 
  #     Now, when we render the navigation items we can call <tt>right_align</tt> on
  #     the item to get its value:
  # 
  #       navigation(:main).each do |item|
  #         if item.align == :right
  #           ...
  #         end
  #       end
  #
  #   * It delegates controller method calls made from within the config file to the 
  #     current controller.  For instance, let's say you're using Ryan Bates' fantastic
  #     CanCan gem for authorization--which adds a some methods to the controller, namely 
  #     the <tt>can?</tt> method--and you want to show or hide navigation items based upon
  #     a user's ability.  You can do that!  Check it:
  # 
  #       navigation :main do
  #         item("Foo", :to => "foos#index") if can? :read, Foo
  #         item "Bar", :to => "bars#index" do
  #           item "Baz", :to => "bazzs#index"
  #         end
  #       end
  # 
  #     *IMPORTANT* if a custom attribute is defined on an item, as mentioned earlier,
  #     it will take precedence over a controller attribute of the same name, thus
  #     hiding access to the controller attribute.
  # 
  # == Here are a couple things that SimpleNavigation WILL NOT do:
  # 
  #   * SimpleNavigation makes no attempt at rendering the navigation.  That's up
  #     to you.  You may want to render your nav items into <tt>div</tt> tags, while
  #     I may want to use an unordered list.  That's fine, go for it.
  # 
  #   * SimpleNavigation does provide authorization logic for limiting access to
  #     navigation items; that's a separate concern.  It's easy enough to use
  #     an authorization gem that does that job quite well, and by allowing for calls
  #     to the current controller from within config/simple_navigation.rb you can
  #     do that.
  module SimpleNavigation
    class Config #:nodoc:
      
      attr_reader :nav
      
      def initialize(current_controller, conf=File.join(Rails.root, "config", "simple_navigation.rb"))
        @current_controller = current_controller
        @nav = {}
        
        # Make sure we only load the config file the first time the navigation is loaded
        # and never again.
        Config.class_eval { class << self; attr_reader :file end; @file ||= File.read(conf) }
        self.instance_eval(Config.file);
      end
      
      private
      
      def navigation(name, &block)
        raise "Navigation names must be unique.  You specified '#{name}' twice." if @nav.has_key?(name)
        @nav[name] = Navigation.new(name, @current_controller, &block)
      end
    end
    
    # This module adds the navigation method to ActionController::Base and makes
    # the method available as a helper.
    module ControllerMethods
      def self.included(base) #:nodoc:
        base.send :helper_method, :navigation
      end
      
      private
      
      # Returns a Coroutine::SimpleNavigation::Navigation object for the supplied
      # navigation name.
      def navigation(which_navigation)
        config = Coroutine::SimpleNavigation::Config.new self
        config.nav[which_navigation]
      end
    end
  end
end