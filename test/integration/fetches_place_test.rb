require "test_helper"

class FetchesPlaceTest < IntegrationTestCase
  describe "lat=51.842176, lon=5.859548" do
    it "returns Nijmegen" do
      get "/place?lat=#{lat}&lon=#{lon}"
      assert_equal "Nijmegen", last_response.body
      assert_equal 200, last_response.status
    end
  end

  private

  def lat
    @lat ||= 51.842176
  end

  def lon
    @lon ||= 5.859548
  end
end
