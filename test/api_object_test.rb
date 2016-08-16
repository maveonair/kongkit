require 'test_helper'

describe Kongkit::Client::ApiObject do
  it 'returns the api' do
    api_name = 'mockbin'
    stub_kong_request(:get, "/apis/#{api_name}", 'api_object.json')

    api_object = Kongkit.api(api_name)
    assert api_object[:id]
    assert_match api_name, api_object[:name]
  end

  it 'returns the apis' do
    api_name = 'mockbin'

    stub_kong_request(:get, '/apis', 'api_objects.json')
    stub_kong_request(:get, "/apis?name=#{api_name}", 'api_objects.json')

    api_objects = Kongkit.apis
    assert_equal 5, api_objects[:total]

    api_objects = Kongkit.apis(name: api_name)
    mockbin = api_objects[:data].first
    assert mockbin[:id]
    assert_match api_name, mockbin[:name]
  end

  it 'adds an api' do
    api_request = {
      name: 'mockbin',
      request_host: 'mockbin.com',
      preserve_host: false,
      upstream_url: 'https://mockbin.com'
    }

    stub_kong_request(:post, '/apis', 'api_object.json', build_post_body(api_request))

    api_object = Kongkit.add_api(api_request)
    assert api_object[:id]
    assert_match api_request[:name], api_object[:name]
  end

  it 'edits an api' do
    api_name = 'mockbin'
    api_request = {
      name: 'mockbin-private',
    }

    stub_kong_request(:patch, "/apis/#{api_name}", 'api_object_renamed.json', build_post_body(api_request))

    api_object = Kongkit.edit_api(api_name, api_request)
    assert api_object[:id]
    assert_match api_request[:name], api_object[:name]
  end

  it 'deletes an api' do
    api_name = 'mockbin'

    stub_kong_request(:delete, "/apis/#{api_name}", nil)

    assert Kongkit.delete_api(api_name)
  end
end
