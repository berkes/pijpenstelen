require "gruff"

class Pijpenstelen::Graph
  attr_accessor :graph

  def initialize(data, graph = Gruff::StackedArea.new)
    @raw_data = data
    @graph = graph

    @graph.theme_pastel
    @graph.labels = labels
    @graph.data "Regen [mm/s]", self.data
    @graph.minimum_value = 0
    @graph.marker_font_size = 14
  end

  def to_blob
    @graph.to_blob
  end

  def data
    @raw_data.map(&:precipitation)
  end

  def labels
    @labels ||= all_labels.select { |k,_| k.even? }
  end

  private

  def all_labels
    Hash[@raw_data.map(&:label).each_with_index.map { |v,i| [i, v] }]
  end
end
