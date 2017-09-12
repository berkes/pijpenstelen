require "bigdecimal"
require "test_helper"

class PijpenstelenBuienradarTest < TestCase
  let(:lat) { BigDecimal.new(1, 6) }
  let(:lon) { BigDecimal.new(2, 6) }

  describe "#data" do
    it "it contains Points from response body" do
      response = stub("Net::HTTPResponse", each_line: ["070|08:05", "100|08:10"])
      Pijpenstelen::Buienradar.stubs(get: response)

      points = [Pijpenstelen::Point.new("08:05", "070"),
                Pijpenstelen::Point.new("08:10", "100")]
      assert_equal(points, subject.data)
    end

    it "strips lines with whitespace" do
      response = stub("Net::HTTPResponse", each_line: ["070|08:05\n"])
      Pijpenstelen::Buienradar.stubs(get: response)

      points = [Pijpenstelen::Point.new("08:05", "070")]
      assert_equal(points, subject.data)
    end
  end

  describe "#options" do
    it "contains query with lat and lon" do
      assert_equal({ lat: lat.to_s("F"), lon: lon.to_s("F") }, subject.options[:query])
    end
  end

  describe "lat,lon" do
    describe "defaults" do
      let(:lat) { nil }
      let(:lon) { nil }

      it "is set to De Bilt" do
        assert_equal BigDecimal.new("52.11"), subject.lat
        assert_equal BigDecimal.new("5.18"), subject.lon
      end
    end

    describe "with floats" do
      let(:lat) { 1.000 }
      let(:lon) { 2.000 }
      it "is casted to BigDecimal" do
        assert_equal BigDecimal.new(1), subject.lat
        assert_equal BigDecimal.new(2), subject.lon
      end
    end

    describe "with strings" do
      let(:lat) { "1.0" }
      let(:lon) { "2.0" }
      it "is casted to BigDecimal" do
        assert_equal BigDecimal.new(1), subject.lat
        assert_equal BigDecimal.new(2), subject.lon
      end
    end

    describe "with BigDecimal" do
      it "is casted to BigDecimal" do
        assert_equal BigDecimal.new(1), subject.lat
        assert_equal BigDecimal.new(2), subject.lon
      end
    end

    describe "big precision" do
      let(:lat) { 1.0111 }
      let(:lon) { 2.0111 }
      it "is rounded to 2 digits" do
        assert_equal "1.01", subject.lat.to_s("F")
        assert_equal "2.01", subject.lon.to_s("F")
      end
    end
  end

  private

  def subject
    @subject ||= Pijpenstelen::Buienradar.new(lat, lon)
  end
end
