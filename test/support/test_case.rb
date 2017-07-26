require "addressable"
##
# Common basic override for all our test cases.
# Contains our custom asserions, methods and setup and teardowns.
class TestCase < Minitest::Spec
  before do
    uri_template = Addressable::Template.new(
      "https://gpsgadget.buienradar.nl/data/raintext/{?lat,lon}"
    )
    stub_request(:get, uri_template).to_return(status: 200, body: "")
  end

  after do
  end

  protected

  def fixture_path
    Pathname.new(File.join(__dir__, "..", "fixtures"))
  end
end
