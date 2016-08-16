require 'test_helper'

describe Kongkit::Client::Consumer do
  it 'returns the consumer' do
    consumer_name = 'john'
    stub_kong_request(:get, "/consumers/#{consumer_name}", 'consumer.json')

    consumer = Kongkit.consumer(consumer_name)
    assert consumer[:id]
    assert_match consumer_name, consumer[:username]
  end

  it 'returns the consumers' do
    consumer_name = 'john'

    stub_kong_request(:get, '/consumers', 'consumers.json')
    stub_kong_request(:get, "/consumers?username=#{consumer_name}", 'consumers.json')

    consumers = Kongkit.consumers
    assert_equal 4, consumers[:total]

    consumers = Kongkit.consumers(username: consumer_name)
    john = consumers[:data].first
    assert john[:id]
    assert_match consumer_name, john[:username]
  end

  it 'creates a consumer' do
    consumer_request = {
      username: 'john',
    }

    stub_kong_request(:post, '/consumers', 'consumer.json', build_post_body(consumer_request))

    consumer = Kongkit.create_consumer(consumer_request)
    assert consumer[:id]
    assert_match consumer_request[:username], consumer[:username]
  end

  it 'edits a consumer' do
    consumer_name = 'john'
    consumer_request = {
      username: 'jane',
    }

    stub_kong_request(:patch, "/consumers/#{consumer_name}", 'consumer_renamed.json', build_post_body(consumer_request))

    consumer = Kongkit.edit_consumer(consumer_name, consumer_request)
    assert consumer[:id]
    assert_match consumer_request[:username], consumer[:username]
  end

  it 'deletes a consumer' do
    consumer_name = 'john'

    stub_kong_request(:delete, "/consumers/#{consumer_name}", nil)

    assert Kongkit.delete_consumer(consumer_name)
  end
end
