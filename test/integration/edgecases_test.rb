require "test_helper"

class EdgecasesTest < IntegrationTestCase
  ##
  # As a user with some 1337 h@cking skills
  # When I remove the attributes
  # Then I expect to see the LAT and LON of the Bilt
  describe "with neither lat nor lon" do
    it "successfully fetches data for The Bilt" do
      get "/graph.png"
      assert_equal 200, last_response.status
      assert_requested(:get,
                       "https://gps.buienradar.nl/getrr.php",
                       query: { lat: "52.11", lon: "5.18"})
    end
  end
end
