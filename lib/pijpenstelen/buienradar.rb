class Pijpenstelen::Buienradar
  attr_writer :file

  def data
    Hash[file.each_line.map {|l| l.strip.split("|").reverse }]
  end

  private

  def file
    @file ||= File.read("data/nijmegen.txt")
  end
end
