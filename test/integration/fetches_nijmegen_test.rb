require "test_helper"

class FetchesNijmegenTest < IntegrationTestCase
  describe "lat=51.842176, lon=5.859548" do
    it "reads from buienradar API using lat and lon" do
      get "/graph.png?lat=#{lat}&lon=#{lon}"
      assert_requested(:get,
                       "https://gpsgadget.buienradar.nl/data/raintext/",
                       query: { lat: "51.84", lon: "5.86"})
    end

    it "returns an image" do
      get "/graph.png?lat=#{lat}&lon=#{lon}"
      assert last_response.ok?, "Expected OK, got #{last_response.status}"
      assert_equal "image/png", last_response.content_type
    end

    it "matches a fixture graph image" do
      @temp_file = Tempfile.new("test_image.png")
      @temp_file.binmode

      get "/graph.png?lat=#{lat},lon=#{lon}"

      @temp_file.write last_response.body
      @temp_file.rewind

      comparison_file = fixture_path.join("graph_nijmegen.png")
      assert_equal_images(comparison_file, @temp_file.path)
    end
  end

  private

  def lat
    @lat ||= 51.842176
  end

  def lon
    @lon ||= 5.859548
  end

  def assert_equal_images(expected_path, actual_path, msg = nil)
    msg ||= "Images are not equal: #{expected_path} !== #{actual_path}"

    expected_hist = comparable_hist_for(expected_path)
    actual_hist   = comparable_hist_for(actual_path)

    begin
      assert_equal actual_hist, expected_hist, msg
    rescue Minitest::Assertion
      FileUtils.cp(actual_path, File.join("/tmp/artifacts/graph.png"))
      raise
    end
  end

  def comparable_hist_for(path)
    img = Magick::Image.read(path)[0]
    hist = img.color_histogram.sort_by {|_pixel, count| count }.to_h
    JSON.pretty_generate hist
  end
end
