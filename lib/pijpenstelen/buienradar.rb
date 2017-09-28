require "httparty"

class Pijpenstelen::Buienradar
  include HTTParty

  base_uri "https://gps.buienradar.nl"

  def initialize(lat, lon)
    @lat = lat || de_bilt[:lat]
    @lon = lon || de_bilt[:lon]
  end

  def data
    parsed.map{ |k,v| Pijpenstelen::Point.new(k, v) }
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

  private

  def parsed
    Hash[response.each_line.map {|l| l.strip.split("|").reverse }]
  end

  def response
    self.class.get("/getrr.php", options)
  end

  def de_bilt
    {
      lat: "52.1100",
      lon: "5.1806"
    }
  end
end
