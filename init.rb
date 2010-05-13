require "tiny_navigation"
ActionController::Base.class_eval { include Coroutine::TinyNavigation::ControllerMethods }