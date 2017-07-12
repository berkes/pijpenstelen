require "sinatra"
require "gruff"
require "tempfile"

get "/graph.png" do
  data = Hash[File.readlines("data/nijmegen.txt").map {|l| l.strip.split("|").reverse }]
  graph = Gruff::Line.new
  graph.labels = Hash[data.keys.each_with_index.map{|v,i| [i,v]} ]
  graph.data "Regen", data.values.map(&:to_i)
  send_graph(graph)
end

def send_graph(graph)
  content_type :png
  return graph.to_blob
end
