require "addressable"
##
# Common basic override for all our test cases.
# Contains our custom asserions, methods and setup and teardowns.
class TestCase < Minitest::Spec
  let(:fake_data) { File.read(fixture_path.join("data_nijmegen.txt")) }

  before do
    uri_template = Addressable::Template.new(
      "https://gps.buienradar.nl/getrr.php{?lat,lon}"
    )
    stub_request(:get, uri_template).
      to_return(status: 200, body: fake_data)
  end

  protected

  def fixture_path
    Pathname.new(File.join(__dir__, "..", "fixtures"))
  end
end
