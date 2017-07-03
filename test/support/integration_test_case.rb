class IntegrationTestCase < TestCase
  include Rack::Test::Methods

  before do
  end

  after do
  end

  protected

  def app
    @app ||= Sinatra::Application
  end
end
