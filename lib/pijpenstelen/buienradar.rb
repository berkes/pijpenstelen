require "net/http"

class Pijpenstelen::Buienradar
  attr_writer :file

  def initialize(lat, lon)
    @lat = lat
    @lon = lon
  end

  def data
    Net::HTTP.get(URI.parse("https://gpsgadget.buienradar.nl/data/raintext/?lat=#{lat.to_s("F")}&lon=#{lon.to_s("F")}"))
    Hash[file.each_line.map {|l| l.strip.split("|").reverse }]
  end

  def lat
    BigDecimal.new(@lat, 6).round(2)
  end

  def lon
    BigDecimal.new(@lon, 6).round(2)
  end

  private

  def file
    @file ||= File.read("data/nijmegen.txt")
  end
end
