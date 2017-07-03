require "sinatra"

get "/graph.png" do
  send_file("img/graph.png")
end
