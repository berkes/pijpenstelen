require "rack/ssl"
require "./pijpenstelen.rb"

use Rack::SSL if ENV["RACK_ENV"] == "production"

run Sinatra::Application
