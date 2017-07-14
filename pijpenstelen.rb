require "sinatra"
require "gruff"
require "tempfile"
require "pijpenstelen.rb"

get "/graph.png" do
  content_type :png
  return Pijpenstelen::Graph.new(Pijpenstelen::Buienradar.new.data).to_blob
end

