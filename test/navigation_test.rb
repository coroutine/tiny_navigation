require 'test_helper'


class NavigationTest < ActiveSupport::TestCase
  
  def setup
    @controller_class     = Struct.new(:controller_name, :action_name)
    @current_controller   = @controller_class.new("tests", "index")
  end
  
  
  #-------------------------------------------------------------------------------
  # Definition tests
  #-------------------------------------------------------------------------------
  
  # flat structure  
  test "can create a navigation with one level of nesting" do
    nav = navigation do
      item "Foos", :to => "foos#index"
      item "Bars", :to => "bars#index"
    end
    
    assert_equal 2, nav.items.length
  end
  
  # nested structure
  test "can create a navigation with multiple levels of nesting" do
    nav = navigation do
      item "Foos", :to => "foos#index"
      item "Bars", :to => "bars#index" do
        item "Tests", :to => "tests#index"
      end
    end
    
    assert_equal 2, nav.items.length
    assert_equal 1, nav.items.last.items.length
  end
  
  # with conditions
  test "can create a navigation with conditional inclusion" do
    nav = navigation do
      item "Foos",  :to => "foos#index"   if 1 == 1
      item "Bars",  :to => "bars#index"   if 1 == 2
      item "Tests", :to => "tests#index"
    end
    
    assert_equal 2, nav.items.length
  end
  
  # extra options
  test "can create a navigation with user-defined properties on items" do
    nav = navigation do
      item "Foos",  :to => "foos#index", :align => :left
      item "Bars",  :to => "bars#index", :align => :right
    end
    
    assert_equal 2,       nav.items.length
    assert_equal :left,   nav.items.first.align
    assert_equal :right,  nav.items.last.align
  end
  
  
  
  #-------------------------------------------------------------------------------
  # Selection tests
  #-------------------------------------------------------------------------------
  
  # flat structure  
  test "has correct selected item in one level of nesting" do
    nav = navigation do
      item "Tests", :to => "tests"
    end
    
    assert_equal 1,       nav.selected.length
    assert_equal "Tests", nav.selected.first.name
  end
  
  # nested structure
  test "has correct selected items in multiple levels of nesting" do
    nav = navigation do
      item "Foos", :to => "foos#index" do
        item "Tests", :to => "tests#index"
      end
    end
    
    assert_equal 2,                 nav.selected.length
    assert_equal ["Foos", "Tests"], nav.selected.map(&:name)
  end
  
  test "when selection_context is 'action' it does not apply selection to a non-matching item, despite a controller match" do
    nav = navigation do
      item "Tests", :to => "tests#show", :selection_scope => :action
    end
    
    assert_nil nav.selected.first
  end
  
  test "when selection_context is 'action' it applies selection to a matching item when both controller and action match" do
    nav = navigation do
      item "Tests", :to => "tests#index", :selection_scope => :action
    end
    
    assert_equal "Tests", nav.selected.first.name
  end
  
  #-------------------------------------------------------------------------------
  # Helpers
  #-------------------------------------------------------------------------------
  
  private
  
  # This method bootstraps a navigation call in lieu of loading a config file.
  #
  def navigation(name = :main, current_controller = @current_controller, &block)
    Coroutine::TinyNavigation::Data::Navigation.new(name, current_controller, &block)
  end
  
end
