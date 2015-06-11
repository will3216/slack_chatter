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

## Basic Configuration

Create a new client instance
```ruby
client = SlackChatter::Client.new("slack-api-token")
```

Specifiy a custom icon to be used when posting:
```ruby
opts = {:icon_url => "http://www.example.com/slack-bot-profile-picture.jpg"}
client = SlackChatter::Client.new("slack-api-token", opts)
```

Specify a custom username to be used when posting:
```ruby
opts = {:username => "slack_chatter"}
client = SlackChatter::Client.new("slack-api-token", opts)
```

## Web API

### Basic Usage
The apit methods follow the following format
```ruby
client.method_namespace.action(required, arguments, {optional: arguments})
# Example:
client.chat.post_message("some-channel-id", "some message to post", {option_param: })
```
These methods directly correspond to those found in the [Slack API Docs](https://api.slack.com/methods)

NOTE: Not all methods accept an options hash. However, all methods with optional parameters do accept one.

### Channels

#### Get a list of Channels
```ruby
response = client.channels.list
=> #<SlackChatter::Response ok=true, response=#<HTTPARTY::RESPONSE:0x7fed1528eba0 ...>, channels=[...], code=200>
response.success?
=> true
response.code
=> 200
response.channels
=> channels [
  {
    "id"=>"C043CDARC",
    "name"=>"general",
    "is_channel"=>true,
    "created"=>1426800248,
    "creator"=>"U043CDAQU",
    "is_archived"=>false,
    "is_general"=>true,
    "is_member"=>true,
    "members"=>["U043CDAQU"],
    "topic"=>{
      "value"=>"",
      "creator"=>"",
      "last_set"=>0
    },
    "purpose"=>{
      "value"=>"This channel is for team-wide communication and announcements. All team members are in this channel.",
      "creator"=>"",
      "last_set"=>0
    },
    "num_members"=>1
  },
  {...},
  ...
]
```

#### Find a Channel by Name
```ruby
response = client.channels.find_by_name("wiggle-room")
=> {
  "id"=>"C06817EC8",
  "name"=>"wiggle-room",
  "is_channel"=>true,
  "created"=>1434045083,
  "creator"=>"U043CDAQU",
  "is_archived"=>false,
  "is_general"=>false,
  "is_member"=>true,
  "members"=>["U043CDAQU"],
  "topic"=>{
    "value"=>"",
    "creator"=>"",
    "last_set"=>0
  },
  "purpose"=>{
    "value"=>"",
    "creator"=>"",
    "last_set"=>0
  },
  "num_members"=>1
}
channel_id = response["id"]
=> "C06817EC8"
```

#### Create a Channel
```ruby
response = client.channels.create("new channel name")
=> #<SlackChatter::Response ok=true, response=#<HTTPARTY::RESPONSE:0x7fed1528eba0 ...>, channel={"id"=>"C0680SVU2", ...}, code=200>
channel_id = response.channel["id"]
=> "C0680SVU2"
```

#### Join a Channel
```ruby
response = client.channels.join("wiggle-room")
=> #<SlackChatter::Response ok=true, response=#<HTTPARTY::RESPONSE:0x7fed1528eba0 ...>, channel={"id"=>"C06817EC8", "name"=>"wiggle-room", "is_channel"=>true, "created"=>1434045083, "creator"=>"U043CDAQU", "is_archived"=>false, "is_general"=>false, "is_member"=>true, "last_read"=>"1434045087.000003", "latest"=>{"user"=>"U043CDAQU", "type"=>"message", "subtype"=>"channel_leave", "text"=>"<@U043CDAQU|sly_fox> has left the channel", "ts"=>"1434045087.000003"}, "unread_count"=>0, "unread_count_display"=>0, "members"=>["U043CDAQU"], "topic"=>{"value"=>"", "creator"=>"", "last_set"=>0}, "purpose"=>{"value"=>"", "creator"=>"", "last_set"=>0}}, code=200>
```

#### Get Channel History
```ruby
response = client.channels.history(channel_id)
=> #<SlackChatter::Response ok=true, response=#<HTTPARTY::RESPONSE:0x7fed1528eba0 ...>, latest="1434027718", messages=[...], has_more=false, code=200, success?=true>
```
Other options:
- latest: End of time range of messages to include in results
- oldest: Start of time range of messages to include in results
- inclusive: Include messages with latest or oldest timestamp in results (use 0 or 1 for boolean values)
- count: Number of messages to return, between 1 and 1000

Note: For all timestamps you must use epoch time, so for any Date, Time, or DateTime object you want to use as an argument use #to_i on it
```ruby
(Time.now() - 5.hours).to_i
=> 1434027718 # epoch
```

#### Invite a User to Channel
```ruby
response = client.channels.invite(channel_id, user_id)
```

#### Kick a User from a Channel
```ruby
response = client.channels.kick(channel_id, user_id)
```

#### Leave a Channel
```ruby
response = client.channels.leave(channel_id)
```

#### Mark a Time in a Channel
Used for tracking read position
```ruby
response = client.channels.mark(channel_id)
```

#### Rename a Channel
```ruby
response = client.channels.rename(channel_id, "new_name")
```

#### Set a Channel's Topic
```ruby
response = client.channels.leave(channel_id, "Dogs acting like cats")
```

#### Set a Channel's Purpose
```ruby
response = client.channels.leave(channel_id, "Post adorable videos")
```

#### Archive a Channel
```ruby
response = client.channels.archive(channel_id)
=> #<SlackChatter::Response ok=true, response=#<HTTPARTY::RESPONSE:0x7fed1528eba0 ...>, code=200>
```

#### Unarchive a Channel
```ruby
response = client.channels.unarchive(channel_id)
=> #<SlackChatter::Response ok=true, response=#<HTTPARTY::RESPONSE:0x7fed1528eba0 ...>, code=200>
```

### Chat

#### Post to a Message
```ruby
response = client.chat.post_message(channel_id, "I am a robot: beep boop boop beep")
=>  #<SlackChatter::Response ok=true, response=#<HTTPARTY::RESPONSE:0x7fed1528eba0 ...>, channel="C0680SVU2", ts="1434044883.000003", message={"text"=>"I am a robot: beep boop boop beep", "username"=>"bot", "type"=>"message", "subtype"=>"bot_message", "ts"=>"1434044883.000003"}, code=200>
message = response.message
=> {
  "text"=>"I am a robot: beep boop boop beep",
  "username"=>"bot",
  "type"=>"message",
  "subtype"=>"bot_message",
  "ts"=>"1434044883.000003"
}
```

#### Update a Message
```ruby
response = client.chat.update(message["ts"], channel_id, "Just kidding, not a robot")
=> #<SlackChatter::Response ok=true, response=#<HTTPARTY::RESPONSE:0x7fed1528eba0 ...>, code=200>
```

#### Delete a Message
```ruby
response = client.chat.delete(message["ts"], channel_id)
=> #<SlackChatter::Response ok=true, response=#<HTTPARTY::RESPONSE:0x7fed1528eba0 ...>, code=200>
```

### Groups
Groups has the same methods that Channels has, with the exception that you cannot join a group (you must be invited) and it has the following additional methods:

#### Open a Group
```ruby
client.groups.open(group_id)
=> #<SlackChatter::Response ok=true, response=#<HTTPARTY::RESPONSE:0x7fed1528eba0 ...>, code=200>
```

#### Close a Group
```ruby
client.groups.close(group_id)
=> #<SlackChatter::Response ok=true, response=#<HTTPARTY::RESPONSE:0x7fed1528eba0 ...>, code=200>
```

#### Create a Child Group
This method takes an existing private group and performs the following steps:

- Renames the existing group (from "example" to "example-archived").
- Archives the existing group.
- Creates a new group with the name of the existing group.
- Adds all members of the existing group to the new group.
- This is useful when inviting a new member to an existing group while hiding all previous chat history from them. In this scenario you can call groups.createChild followed by groups.invite.

The new group will have a special parent_group property pointing to the original archived group. This will only be returned for members of both groups, so will not be visible to any newly invited members.

```ruby
client.groups.create_child(group_id)
=> #<SlackChatter::Response ok=true, response=#<HTTPARTY::RESPONSE:0x7fed1528eba0 ...>, code=200>
```

### Im (or Direct Messages)

#### Open a Direct Message Channel
This method opens a direct message channel with another member of your Slack team.
```ruby
client.im.open(user_id)
=> #<SlackChatter::Response ok=true, response=#<HTTPARTY::RESPONSE:0x7fed1528eba0 ...>, code=200>
```

#### Get the History of a Direct Message Channel
```ruby
response = client.im.history(user_id, opts_hash)
=> #<SlackChatter::Response ok=true, response=#<HTTPARTY::RESPONSE:0x7fed1528eba0 ...>, latest="1434027718", messages=[...], has_more=false, code=200>
```
Options:
- latest: End of time range of messages to include in results
- oldest: Start of time range of messages to include in results
- inclusive: Include messages with latest or oldest timestamp in results (use 0 or 1 for boolean values)
- count: Number of messages to return, between 1 and 1000

Note: For all timestamps you must use epoch time, so for any Date, Time, or DateTime object you want to use as an argument use #to_i on it
```ruby
(Time.now() - 5.hours).to_i
=> 1434027718 # epoch
```

#### List all Direct Message Channels
```ruby
response = client.im.list
=> #<SlackChatter::Response ok=true, response=#<HTTPARTY::RESPONSE:0x7fed1528eba0 ...>, latest="1434027718", channels=[...], has_more=false, code=200>
```

#### Close a Direct Message Channel
This method closes a direct message channel with another member of your Slack team.
```ruby
client.im.close(user_id)
=> #<SlackChatter::Response ok=true, response=#<HTTPARTY::RESPONSE:0x7fed1528eba0 ...>, code=200>
```

#### Mark a Time in a Direct Message Channel
Used for tracking read position
```ruby
response = client.im.mark(channel_id)
```

### Files

#### Delete a File
```ruby

```

#### Get File Info
```ruby

```

#### List all Files
```ruby
response = client.files.list(options)
```
- user: user_id - Filter files created by a single user
- ts_from: epoch_timestamp - Filter files created after this timestamp (inclusive)
- ts_to: epoch_timestamp - Filter files created before this timestamp (inclusive)
- types: Filter files by type, one or more of the following values ie, ["images", "zips"] or "gdocs"
  - all - All files
  - posts - Posts
  - snippets - Snippets
  - images - Image files
  - gdocs - Google docs
  - zips - Zip files
  - pdfs - PDF files
- count: integer -  Number of items to return per page
- page: integer - Page number of results to return

#### Upload a File
**Not Currently Supported**


## Contributing

1. Fork it ( https://github.com/[my-github-username]/slack_chatter/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
