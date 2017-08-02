require "httparty"

class Pijpenstelen::Buienradar
  include HTTParty

  base_uri "https://gps.buienradar.nl"

  def initialize(lat, lon)
    @lat = lat
    @lon = lon
  end

  def data
    response = self.class.get("/getrr.php", options)
    Hash[response.each_line.map {|l| l.strip.split("|").reverse }]
  end

  def lat
    BigDecimal.new(@lat, 6).round(2)
  end

  def lon
    BigDecimal.new(@lon, 6).round(2)
  end

  def options
    { query: { lat: lat.to_s("F"), lon: lon.to_s("F") } }
  end
end
