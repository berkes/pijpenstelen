##
# Common basic override for all our test cases.
# Contains our custom asserions, methods and setup and teardowns.
class TestCase < Minitest::Spec
  before do
  end

  after do
  end

  protected

  def fixture_path
    Pathname.new(File.join(__dir__, "..", "fixtures"))
  end
end
