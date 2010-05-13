require 'test_helper'
require 'simple_navigation/navigation'
require 'simple_navigation/item'

class NavigationTest < ActiveSupport::TestCase
  
  test "can create an empty navigation" do
    assert Coroutine::SimpleNavigation::Navigation.new(:main, "tests")
  end
  
  test "can create a navigation with an item" do
    nav = Coroutine::SimpleNavigation::Navigation.new(:main, "tests") do
      item "Foos", :to => "foos#index"
    end
    
    assert_equal nav.items.length, 1
  end
end
