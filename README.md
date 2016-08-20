# Kongkit

Ruby library for the Kong API.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'kongkit'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install kongkit

## Usage

```ruby
# List APIs (default kong url: http://localhost:8001)
apis = Kongkit.apis

# Create consumer (default kong url: http://localhost:8001)
Kongkit.add_consumer(username: 'fabian')
```

or

```ruby
# Add API
client = Kongkit::Client.new('https://kong.enterprise.io:8001')
client.add_api(name: 'mockbin', request_host: 'mockbin.com', upstream_url: 'http://mockbin.com', preserve_host: true)

# Add Plugin
client.add_plugin('mockbin', name: 'rate-limiting', 'config.minute': 20, 'config.hour': 500)
```

### Pagination
When the returned resource contains a next value then the next page can be retrieved by calling the `next` method on the resource:

```ruby
# List APIs (default kong url: http://localhost:8001)
first_page = Kongkit.apis(size: 5)

next_page = first_page.next
```


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/maveonair/kongkit. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
