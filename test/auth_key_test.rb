require 'test_helper'

describe Kongkit::Client::KeyAuthentication do
  it 'returns the auth keys' do
    consumer_name = 'john'
    stub_kong_request(:get, "/consumers/#{consumer_name}/key-auth", 'auth-keys.json')
    stub_kong_request(:get, "/consumers/#{consumer_name}", 'consumer.json')

    auth_keys = Kongkit.auth_keys(consumer_name)
    assert_equal 1, auth_keys[:total]

    consumer = Kongkit.consumer(consumer_name)
    auth_key = auth_keys[:data].first
    assert_match consumer[:id], auth_key[:consumer_id]
  end

  it 'creates an auth key' do
    consumer_name = 'john'
    stub_kong_request(:post, "/consumers/#{consumer_name}/key-auth", 'auth-key.json')

    auth_key = Kongkit.add_auth_key(consumer_name)
    assert auth_key[:key]
  end

  it 'deletes an auth key' do
    consumer_name = 'john'
    key = '19de16f8-1f53-4434-97c5-15e8ac7685b0'

    stub_kong_request(:delete, "/consumers/#{consumer_name}/key-auth/#{key}", nil)

    assert Kongkit.delete_auth_key(consumer_name, key)
  end
end
