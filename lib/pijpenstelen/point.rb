## A Datapoint.
class Pijpenstelen::Point
  attr_accessor :timestamp, :value

  def initialize(timestamp, value)
    @timestamp = timestamp
    @value = value
  end

  def precipitation
    (10 ** ((limited_value - 109) / 32)).round(2)
  end

  def label
    timestamp
  end

  def ==(other)
    other.value == value && other.timestamp == timestamp
  end

  private

  def limited_value
    [[@value.to_f, 255.0].min, 0.0].max
  end
end
