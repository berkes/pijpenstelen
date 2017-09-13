require "test_helper"

class FetchesHomepageTest < IntegrationTestCase
  describe "index.html" do
    it "renders index.html file" do
      get "/"
      assert_equal 200, last_response.status
      #  since rack opens all files in ascii-8bit. we need to convert here too
      file = File.open(File.join("public", "index.html"), "r:ascii-8bit")
      assert_equal file.read, last_response.body
    end
  end
end
