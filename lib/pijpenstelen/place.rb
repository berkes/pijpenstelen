module Pijpenstelen
  ##
  # Model representing a place.
  # A place has the name of the nearest city, village or area,
  # as found with a lat-lon set.
  class Place
    attr_accessor :lat, :lon
    attr_writer :geocoder

    def initialize(lat, lon)
      @lat = lat
      @lon = lon
    end

    def name
      geocoder.search(lat, lon)[:name]
    end

    def geocoder
      @geocoder ||= OfflineGeocoder.new
    end
  end
end
