#------------------------------------------------------------
# setup
#------------------------------------------------------------

# external gems
require "action_pack"
require "action_controller"

# add data files
%w(config navigation item).each do |file| 
  require File.join(File.dirname(__FILE__), "tiny_navigation/data", file)
end

# add controller files
require File.dirname(__FILE__) + "/tiny_navigation/controller/base"


# add extensions to action controller
::ActionController::Base.send(:include, Coroutine::TinyNavigation::Controller::Base)



#------------------------------------------------------------
# doc namespaces
#------------------------------------------------------------

module Coroutine  #:nodoc:
  
  # TinyNavigation provides an easy-to-use DSL for defining navigation structures;
  # these structures are defined in config/tiny_navigation.rb.
  # 
  # == Here are a few things TinyNavigation WILL do:
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
  # == Here are a couple things that TinyNavigation WILL NOT do:
  # 
  #   * TinyNavigation makes no attempt at rendering the navigation.  That's up
  #     to you.  You may want to render your nav items into <tt>div</tt> tags, while
  #     I may want to use an unordered list.  That's fine, go for it.
  # 
  #   * TinyNavigation does not provide authorization logic for limiting access to
  #     navigation items; that's a separate concern.  It's easy enough to use
  #     an authorization gem that does that job quite well, and by allowing for calls
  #     to the current controller from within config/tiny_navigation.rb you can
  #     do that.
  #
  module TinyNavigation
   
    # This module defines all behavior and logic related to extending controller
    # behavior.
    #
    module Controller
    end
    
    # This module defines all objects that primarily serve to provide data structures
    # and access methods.
    #
    module Data
    end
    
  end
end