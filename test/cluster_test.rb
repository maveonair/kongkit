require 'test_helper'

describe Kongkit::Client::Cluster do
  it 'returns the node status' do
    stub_kong_request(:get, '/cluster', 'cluster.json')

    data = Kongkit.cluster_status
    assert_match 'alive', data[:data].first[:status]
  end

  it 'removes the node from the cluster' do
    node_name = 'kong.prod1_7946'
    stub_kong_request(:delete, "/cluster?name=#{node_name}", nil)

    assert Kongkit.remove_node(node_name)
  end
end
