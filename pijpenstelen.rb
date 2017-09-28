$LOAD_PATH.unshift(File.join(__dir__, "lib"))
require "sinatra"
require "gruff"
require "tempfile"
require "pijpenstelen.rb"

get "/" do
  send_file File.join(settings.public_folder, "index.html")
end

get "/graph.png" do
  content_type :png
  buienradar = Pijpenstelen::Buienradar.new(params[:lat], params[:lon])
  return Pijpenstelen::Graph.new(buienradar.data).to_blob
end

get "/place" do
  content_type :text
  return Pijpenstelen::Place.new(params[:lat], params[:lon]).name
end
