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
