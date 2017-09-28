require "test_helper"

class PijpenstelenPlaceTest < TestCase
  let(:lat) { BigDecimal.new(1, 6) }
  let(:lon) { BigDecimal.new(2, 6) }

  before do
    subject.geocoder = geocoder
  end

  describe "geocoder" do
    it "is an instance of OfflineGeocoder by default" do
      subject.geocoder = nil
      assert_kind_of OfflineGeocoder, subject.geocoder
    end
  end

  describe "#name" do
    it "looks up nearest city name from OfflineGeocoder#search" do
      geocoder.expects(:search).with(lat, lon).returns(geocoder_london)
      assert_equal "Bayswater", subject.name
    end
  end

  private

  def subject
    @subject ||= Pijpenstelen::Place.new(lat, lon)
  end

  def geocoder
    @geocoder ||= stub("Geocoder")
  end

  def geocoder_london
    {
      lat: 51.51116,
      lon: -0.18426,
      name: "Bayswater",
      admin1: "England",
      admin2: "Greater London",
      cc: "GB",
      country: "United Kingdom"
    }
  end
end
