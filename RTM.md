## RTM API Basics

RealTime Messaging API reference is [here](https://api.slack.com/rtm).

### Make a Team

Sign up at [slack.com](https://slack.com), my team is _dblockdotorg.slack.com_.

### Create a New Bot Integration

This is something done in Slack, under [integrations](https://artsy.slack.com/services). Create a [new bot](https://artsy.slack.com/services/new/bot), and note its API token.

![](screenshots/register-bot.png)

### Gemfile

```ruby
source 'http://rubygems.org'

gem 'http'
gem 'faye-websocket'
gem 'eventmachine'
```

### Start

```ruby
require 'http'
require 'json'

rc = JSON.parse HTTP.post("https://slack.com/api/rtm.start", params: {
  token: ENV['SLACK_API_TOKEN'],
})

puts rc['url']
```

```
wss://ms364.slack-msgs.com/websocket/...
```

### See Events

```ruby
require 'faye/websocket'
require 'eventmachine'

EM.run {
  ws = Faye::WebSocket::Client.new(url)

  ws.on :open do |event|
    p [:open]
  end

  ws.on :message do |event|
    p [:message, JSON.parse(event.data)]
  end

  ws.on :close do |event|
    p [:close, event.code, event.reason]
    ws = nil
  end
}
```

### Say Hi Back

```ruby
ws.on :message do |event|
  data = JSON.parse(event.data) if event && event.data

  if data && data['type'] == 'message' && data['text'] == 'hi'
    ws.send({ type: 'message', text: "hi <@#{data['user']}>", channel: data['channel'] }.to_json)
  end
end
```



