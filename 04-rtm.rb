require 'http'
require 'json'

rc = JSON.parse HTTP.post("https://slack.com/api/rtm.start", params: {
  token: ENV['SLACK_API_TOKEN'],
})

url = rc['url']
puts url

require 'faye/websocket'
require 'eventmachine'

EM.run {
  ws = Faye::WebSocket::Client.new(url)

  ws.on :open do |event|
    p [:open]
  end

  ws.on :message do |event|
    data = JSON.parse(event.data) if event && event.data
    p [:message, data]

    if data && data['type'] == 'message' && data['text'] == 'hi'
      ws.send({ type: 'message', text: "hi <@#{data['user']}>", channel: data['channel'] }.to_json)
    end
  end

  ws.on :close do |event|
    p [:close, event.code, event.reason]
    ws = nil
  end
}

