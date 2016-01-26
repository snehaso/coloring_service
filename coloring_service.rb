require 'sinatra/base'
require 'json'

class ColoringService < Sinatra::Base
  post '/color' do
    {:success => "ok"}.to_json
  end
end

