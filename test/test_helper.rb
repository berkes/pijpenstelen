require "mocha"
require "minitest/autorun"
require "minitest/spec"
require "minitest/pride"

require "mocha/minitest"
require "webmock/minitest"
require "rack/test"
require "pp"
require "byebug"

require "rmagick"

require_relative "support/test_case"
require_relative "support/integration_test_case"

require "sinatra"
require_relative "../pijpenstelen.rb"

## Otherwise sinatra sets root to /test
settings.root = File.expand_path(File.join(__dir__, ".."))
