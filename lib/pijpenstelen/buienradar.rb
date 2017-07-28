require "net/http"

class Pijpenstelen::Buienradar
  def initialize(lat, lon)
    @lat = lat
    @lon = lon
  end

  def data
    Hash[response.each_line.map {|l| l.strip.split("|").reverse }]
  end

  def lat
    BigDecimal.new(@lat, 6).round(2)
  end

  def lon
    BigDecimal.new(@lon, 6).round(2)
  end

  def response
    Net::HTTP.get(URI.parse("https://gpsgadget.buienradar.nl/data/raintext/?lat=#{lat.to_s("F")}&lon=#{lon.to_s("F")}"))
  end
end
