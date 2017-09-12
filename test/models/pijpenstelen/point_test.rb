require "test_helper"

class PijpenstelenPointTest < TestCase
  describe "#precipitation" do
    it "calculates value to mm/sec" do
      assert_equal 0.1, subject.precipitation
    end

    it "protects against values above 255" do
      subject.value = 300
      assert_in_delta 36517.4, subject.precipitation, 0.1
    end

    it "protects against values below 0" do
      subject.value = -77
      assert_in_delta 0, subject.precipitation, 0.1
    end

    it "rounds at two decimals" do
      subject.value = 100
      assert_equal "0.52", subject.precipitation.to_s
    end
  end

  describe "#label" do
    it "is the timestamp" do
      assert_equal "12:00", subject.label
    end
  end

  describe "#==" do
    it "is true when value and timestamp are equal" do
      assert_equal Pijpenstelen::Point.new("12:00", "77"),
                   Pijpenstelen::Point.new("12:00", "77")
    end
  end

  private

  def subject
    @subject ||= Pijpenstelen::Point.new("12:00", "77")
  end
end
