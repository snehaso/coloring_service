require 'spec_helper'
require 'rack/test'
require 'json'

describe 'ColoringService' do
  include Rack::Test::Methods

  def app
    ColoringService.new
  end

  it 'returns json response to post request' do
    post '/color', {}
    expect(last_response).to be_ok
  end
end
