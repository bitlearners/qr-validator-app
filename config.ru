# This file is used by Rack-based servers to start the application.

require_relative "app"
require_relative "config/environment"
#require_relative "app/services/*/*"
require 'firebase'
require 'pry'

run Rails.application
Rails.application.load_server
