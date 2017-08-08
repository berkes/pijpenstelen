require "test_helper"

class PijpenstelenGraphTest < TestCase
  describe "#graph setup" do
    before do
      @graph = stub("Graph", 
                    :labels= => true,
                    data: true,
                    :marker_font_size= => 0,
                    :minimum_value= => 0)
    end

    it "sets marker font size to 14 px" do
      @graph.expects(:marker_font_size=).with(14)
      @subject = Pijpenstelen::Graph.new(data, @graph)
    end

    it "sets minimum value to 0" do
      @graph.expects(:minimum_value=).with(0)
      @subject = Pijpenstelen::Graph.new(data, @graph)
    end
  end

  describe "#labels" do
    it "makes an indexed hash with keys from data" do
      @data = { "08:00" => "070", "08:30" => "100" }
      assert_equal({ 0 => "08:00" }, subject.labels)
    end

    it "has every even entry in data as label" do
      @data = { "08:05" => 0, "08:10" => 0, "08:15" => 0, "08:20" => 0}
      assert_equal({ 0 => "08:05", 2 => "08:15" }, subject.labels)
    end
  end

  describe "#data" do
    before do
      @data = { "08:05" => "070", "08:10" => "100" } 
    end

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
    @data ||= {}
  end

  def subject
    @subject ||= Pijpenstelen::Graph.new(data)
  end
end
