require 'test_helper'

describe Kongkit::Client::Node do
  it 'returns the node information' do
    stub_kong_request(:get, '/', 'node_information.json')

    data = Kongkit.node_information
    assert_match 'Welcome to Kong', data[:tagline]
  end

  it 'returns the node status' do
    stub_kong_request(:get, '/status', 'node_status.json')

    data = Kongkit.node_status
    assert_equal 2, data[:database][:apis]
  end
end
