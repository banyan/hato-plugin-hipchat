# Hato::Plugin::Hipchat

This plugin provides a method to send messages via [HipChat](https://www.hipchat.com/).

## Configuration

```ruby
Hato::Config.define do
  api_key 'test'
  host    '0.0.0.0'
  port    9699

  # ...

  tag 'test' do
    plugin 'Hipchat' do
      auth_token 'yes your secret token here'
      room %w[hato pigeon]
      from 'hato-bot'
    end
  end

  # ...
end
```

## Installation

Add this line to your application's Gemfile:

    gem 'hato-plugin-hipchat'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install hato-plugin-hipchat

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
