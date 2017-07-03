require "test_helper"

class FetchesNijmegenTest < IntegrationTestCase
  describe "lat=51.842176, lon=5.859548" do
    let(:lat) { 51.842176 }
    let(:lon) { 5.859548 }

    it "returns an image" do
      get "/graph.png?lat=#{lat},lon=#{lon}"
      assert last_response.ok?, "Expected OK, got #{last_response.status}"
      assert_equal "image/png", last_response.content_type
    end
  end
end
