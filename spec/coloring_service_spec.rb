require 'spec_helper'
require 'rack/test'
require 'json'

describe 'ColoringService' do
  include Rack::Test::Methods

  def app
    ColoringService.new
  end

  it 'sends colored words to pusher channel' do
    params = {
                words: %w(Behold her single in the field),
                color_scheme: :black_on_white
              }
    params[:words].each do |word|
      allow_any_instance_of(Pusher::Client).to receive(:trigger)
        .with('notifications', 'new_notification', {message: "<span>#{word}</span>"})
    end

    post '/color', params.to_json

    expect(last_response).to be_ok
  end

  it "should default color scheme to black on white" do
    %w(Behold her single in the field).each do |word|
      allow_any_instance_of(Pusher::Client).to receive(:trigger)
        .with('notifications', 'new_notification', {message: "<span>#{word}</span>"})
    end
    post '/color', { words: %w(Behold her single in the field)}.to_json

    expect(last_response).to be_ok
  end

  it "return 404 if words are not sent in request" do
    post '/color', {}.to_json

    expect(last_response.status).to eq(404)
  end
end
