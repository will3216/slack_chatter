# SlackChatter

SlackChatter is a simple-to-use Slack API wrapper for ruby which makes it quick and easy to constantly annoy your friends, co-workers, and loved ones with waaayyyyy to many process status updates. It provides easy-access to all of the functionallity supported by the Slack Api with the following exceptions:
- File uploading
- Real-Time Messaging
(These are currently in the works and should be available shortly)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'slack_chatter'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install slack_chatter

## Usage

Create a new client instance
```ruby
client = SlackChatter::Client.new("some-slack-token")
```

Use methods namespaced as they are in the API reference ie, to list channels:
```ruby
client.channels.list
```

Each of these methods requires you to provide the required attributes as explicit arguments and then add any optional arguments in an options hash with the keys and values as those expected in the Slack API doc
```ruby
client.chat.post_message("some-channel-id", "some message to post", {option_param: })
```


## Contributing

1. Fork it ( https://github.com/[my-github-username]/slack_chatter/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
