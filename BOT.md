## BOT API Basics

[Slack-ruby-bot](https://github.com/dblock/slack-ruby-bot) makes it all very easy.

### Make a Team

Sign up at [slack.com](https://slack.com), my team is _dblockdotorg.slack.com_.

### Create a New Bot Integration

This is something done in Slack, under [integrations](https://artsy.slack.com/services). Create a [new bot](https://artsy.slack.com/services/new/bot), and note its API token.

![](screenshots/register-bot.png)

### Gemfile

```ruby
source 'http://rubygems.org'

gem 'slack-ruby-bot'
```

### Say Hi

```ruby
require 'slack-ruby-bot'

module HiBot
  class App < SlackRubyBot::App
  end

  class Hi < SlackRubyBot::Commands::Base
    command 'hi' do |client, data, _match|
      client.message text: "hi <@#{data.user}>", channel: data.channel
    end
  end
end

HiBot::App.instance.run
```
