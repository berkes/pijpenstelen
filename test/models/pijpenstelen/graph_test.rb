require "test_helper"

class PijpenstelenGraphTest < TestCase
  describe "#labels" do
    let (:data) { { "08:05" => "070", "08:10" => "100" } }
    it "makes an indexed hash with keys from data" do
      assert_equal({ 0 => "08:05", 1 => "08:10" }, subject.labels)
    end
  end

  describe "#data" do
    let (:data) { { "08:05" => "070", "08:10" => "100" } }
    it "has all the values casted to integer" do
      assert_equal [70, 100], subject.data
    end
  end

  describe "to_blob" do
    it "delegates to @graph to blob" do
      subject.graph  = mock("Gruff::Line", to_blob: nil)
      subject.to_blob
    end
  end

  private

  def data
    {}
  end

  def subject
    @subject ||= Pijpenstelen::Graph.new(data)
  end
end
