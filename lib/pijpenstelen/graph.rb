class Pijpenstelen::Graph
  attr_accessor :graph

  def initialize(data)
    @raw_data = data
    @graph = Gruff::Line.new
    @graph.labels = labels
    @graph.data "Regen", self.data
    @graph.minimum_value = 0
  end

  def to_blob
    @graph.to_blob
  end

  def data
    @raw_data.values.map(&:to_i)
  end

  def labels
    @labels ||= Hash[@raw_data.keys.each_with_index.map{|v,i| [i,v]} ]
  end
end
