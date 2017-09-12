$LOAD_PATH.unshift(File.join(__dir__, "lib"))
require "sinatra"
require "gruff"
require "tempfile"
require "pijpenstelen.rb"

get "/graph.png" do
  content_type :png
  buienradar = Pijpenstelen::Buienradar.new(params[:lat], params[:lon])
  return Pijpenstelen::Graph.new(buienradar.data).to_blob
end
