require "simple_navigation"
ActionController::Base.class_eval { include Coroutine::SimpleNavigation::ControllerMethods }