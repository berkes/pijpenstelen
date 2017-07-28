require "bigdecimal"
require "test_helper"

class PijpenstelenBuienradarTest < TestCase
  let(:lat) { BigDecimal.new(1, 6) }
  let(:lon) { BigDecimal.new(2, 6) }

  describe "#data" do
    it "it contains label-value pairs reversed from response body" do
      response = stub("Net::HTTPResponse", each_line: ["070|08:05", "100|08:10"])
      subject.stubs(response: response)

      assert_equal({ "08:05" => "070", "08:10" => "100" }, subject.data)
    end

    it "strips lines with whitespace" do
      response = stub("Net::HTTPResponse", each_line: ["070|08:05\n"])
      subject.stubs(response: response)

      assert_equal({ "08:05" => "070" }, subject.data)
    end
  end

  describe "response" do
    it "reads from Net::HTTP" do
      Net::HTTP.expects(:get).returns(stub("Net::HTTPResponse"))
      subject.response
    end
  end

  describe "lat,lon" do
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
