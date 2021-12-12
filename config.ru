# This file is used by Rack-based servers to start the application.

require_relative "config/environment"

run Rails.application
Rails.application.load_server

require 'resque/server'  
run Rack::URLMap.new "/" => Test2App::Application,  "/resque" => Resque::Server.new


