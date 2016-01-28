require 'sinatra/base'
require 'json'
require 'pusher'
require './color'

class ColoringService < Sinatra::Base
  configure do
    set pusher: {app_id: '173595', key: 'da03829d30f7142f7f34' ,secret: 'c6ad3e310bcd83460059'}
  end

  post '/color' do
    data = JSON.parse(request.body.read)
    pusher_channel = data['pusher_notification_channel']
    if !data.is_a?(Hash) || data['words'].nil? || pusher_channel.nil?
      halt 404, 'Bad request'
    end

    pusher = Pusher::Client.new(app_id: settings.pusher[:app_id],
                                key: settings.pusher[:key],
                                secret: settings.pusher[:secret])
    Color.new(data['color_scheme']).words_to_html(data['words']).each do |word_html|
      pusher.trigger(pusher_channel, 'new_notification', {message: word_html})
    end
    {:success => "ok"}.to_json
  end
end

