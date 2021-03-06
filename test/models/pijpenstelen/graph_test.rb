require "test_helper"

class PijpenstelenGraphTest < TestCase
  before do
    @graph = stub("Graph", 
                  :labels= => true,
                  data: true,
                  :theme_pastel => {},
                  :marker_font_size= => 0,
                  :minimum_value= => 0)
  end

  describe "#graph setup" do
    it "defines theme pastel" do
      @graph.expects(:theme_pastel)
      @subject = Pijpenstelen::Graph.new(data, @graph)
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
      @data = [point("08:00", ""), point("08:30", "")]
      assert_equal({ 0 => "08:00" }, subject.labels)
    end

    it "has every even entry in data as label" do
      @data = [point("08:05", ""),
               point("08:10", ""),
               point("08:15", ""),
               point("08:20", "")]
      assert_equal({ 0 => "08:05", 2 => "08:15" }, subject.labels)
    end
  end

  describe "#data" do
    before do
      @data = [point("08:00", 0.1), point("08:30", 0.2)]
    end

    it "has all the precipitation from points" do
      assert_equal [0.1, 0.2], subject.data
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

  def point(timestamp, precipitation)
    stub("Point", label: timestamp, precipitation: precipitation)
  end

  def subject
    @subject ||= Pijpenstelen::Graph.new(data, @graph)
  end
end
