require "mocha"
require "minitest/autorun"
require "minitest/spec"
require "minitest/pride"

require "mocha/mini_test"
require "webmock/minitest"
require "rack/test"
require "pp"
require "byebug"

require "rmagick"

require_relative "support/test_case"
require_relative "support/integration_test_case"

require "sinatra"
require_relative "../pijpenstelen.rb"
