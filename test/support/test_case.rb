##
# Common basic override for all our test cases.
# Contains our custom asserions, methods and setup and teardowns.
class TestCase < Minitest::Spec
  before do
  end

  after do
  end

  protected

  def fake_uuid(character = "x")
    [8, 4, 4, 4, 12].map { |length| character * length }.join("-")
  end
end
