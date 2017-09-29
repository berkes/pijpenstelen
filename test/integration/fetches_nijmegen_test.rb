require "test_helper"
require "fileutils"

class FetchesNijmegenTest < IntegrationTestCase
  describe "lat=51.842176, lon=5.859548" do
    it "reads from buienradar API using lat and lon" do
      get "/graph.png?lat=#{lat}&lon=#{lon}"
      assert_requested(:get,
                       "https://gps.buienradar.nl/getrr.php",
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

  describe "lat=53.8, lon=5.7" do
    let(:fake_data) { File.read(fixture_path.join("data_amsterdam.txt")) }
    before do
      @lat = 53.8
      @lon = 5.7
    end

    it "returns an different image" do
      @temp_file = Tempfile.new("test_image.png")
      @temp_file.binmode

      get "/graph.png?lat=#{lat}&lon=#{lon}"

      @temp_file.write last_response.body
      @temp_file.rewind

      comparison_file = fixture_path.join("graph_nijmegen.png")
      refute_equal_images(comparison_file, @temp_file.path)
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

    expected_img = Magick::Image.read(expected_path)[0]
    actual_img = Magick::Image.read(actual_path)[0]
    diff_img, diff_metric = expected_img.compare_channel(actual_img, Magick::MeanSquaredErrorMetric)

    assert_in_delta(0.0, diff_metric, 0.0001, msg)
  rescue Minitest::Assertion
    dir = File.join("/tmp", "artifacts")
    FileUtils.mkdir_p(dir)
    img_path = File.join(dir, "#{name}.png")
    diff_img.write(img_path)
    raise
  end

  def refute_equal_images(expected_path, actual_path, msg = nil)
    msg ||= "Images are equal: #{expected_path} == #{actual_path}"

    expected_img = Magick::Image.read(expected_path)[0]
    actual_img = Magick::Image.read(actual_path)[0]
    _, diff_metric = expected_img.
                     compare_channel(actual_img, Magick::MeanSquaredErrorMetric)

    refute_in_delta(0.0, diff_metric, 0.0001, msg)
  end
end
