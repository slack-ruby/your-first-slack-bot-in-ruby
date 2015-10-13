require 'http'
require 'json'

rc = HTTP.post("https://slack.com/api/auth.test")
puts JSON.pretty_generate(JSON.parse(rc.body))

rc = HTTP.post("https://slack.com/api/auth.test", params: { token: ENV['SLACK_API_TOKEN'] })
puts JSON.pretty_generate(JSON.parse(rc.body))
