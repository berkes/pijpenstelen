require "sinatra"
require "gruff"
require "tempfile"
require "pijpenstelen.rb"

get "/graph.png" do
  content_type :png
  buienradar = Pijpenstelen::Buienradar.new(params[:lat] || 0, params[:lon] || 0)
  return Pijpenstelen::Graph.new(buienradar.data).to_blob
end
