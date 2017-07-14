require "test_helper"

class PijpenstelenBuienradarTest < TestCase
  describe "#data" do
    it "it contains label-value pairs reversed from file" do
      subject.file = stub("File", each_line: ["070|08:05", "100|08:10"])
      assert_equal({ "08:05" => "070", "08:10" => "100" }, subject.data)
    end

    it "strips lines with whitespace" do
      subject.file = stub("File", each_line: [" 070|08:05\n"])
      assert_equal({ "08:05" => "070" }, subject.data)
    end

    it "reads from file" do
      File.expects(:read).returns("")
      subject.data
    end
  end

  private

  def subject
    @subject ||= Pijpenstelen::Buienradar.new
  end
end
