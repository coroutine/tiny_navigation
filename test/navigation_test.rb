require 'test_helper'
require 'tiny_navigation/navigation'
require 'tiny_navigation/item'

class NavigationTest < ActiveSupport::TestCase
  
  def setup
    @controller_class     = Struct.new(:controller_name)
    @current_controller   = @controller_class.new("tests")
  end
  
  test "can create a navigation with an item" do
    nav = navigation do
      item "Foos", :to => "foos#index"
    end
    
    assert_equal nav.items.length, 1
  end
  
  test "has correct selected item in one level of nesting" do
    nav = navigation do
      item "Tests", :to => "tests"
    end
    
    assert_equal nav.selected.length, 1
    assert_equal nav.selected.first.name, "Tests"
  end
  
  test "has correct selected items in multiple levels of nesting" do
    nav = navigation do
      item "Foos", :to => "foos#index" do
        item "Tests", :to => "tests#index"
      end
    end
    
    assert_equal nav.selected.length, 2
    assert_equal nav.selected.map(&:name), ["Foos", "Tests"]
  end
  
  # ------------------------------------------------------------------------------
  # Helpers
  # ------------------------------------------------------------------------------
  
  private
  
  def navigation(name = :main, current_controller = @current_controller, &block)
    Coroutine::TinyNavigation::Navigation.new(name, current_controller, &block)
  end
end
