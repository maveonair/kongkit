require 'test_helper'

describe Kongkit::Client::PluginObject do
  it 'returns all plugins' do
    plugin_name = 'rate-limiting'

    stub_kong_request(:get, '/plugins', 'plugins.json')
    stub_kong_request(:get, "/plugins?name=#{plugin_name}", 'plugins.json')

    api_objects = Kongkit.plugins
    assert_equal 10, api_objects[:total]

    api_objects = Kongkit.plugins(name: plugin_name)
    mockbin = api_objects[:data].first
    assert mockbin[:id]
    assert_match plugin_name, mockbin[:name]
  end

  it 'returns all enabled plugins' do
    stub_kong_request(:get, '/plugins/enabled', 'enabled_plugins.json')

    enabled_plugins = Kongkit.enabled_plugins
    assert enabled_plugins[:enabled_plugins].any?
  end

  it 'returns the plugin schema' do
    plugin_name = 'rate-limiting'
    stub_kong_request(:get, "/plugins/schema/#{plugin_name}", 'rate-limiting-schema.json')

    schema = Kongkit.plugin_schema(plugin_name)

  end

  it 'returns the plugin' do
    plugin_name = 'rate-limiting'
    stub_kong_request(:get, "/plugins/#{plugin_name}", 'plugin.json')

    api_object = Kongkit.plugin(plugin_name)
    assert api_object[:id]
    assert_match plugin_name, api_object[:name]
  end

  it 'returns the plugin per API' do
    api_name = 'mockbin'
    stub_kong_request(:get, "/apis/#{api_name}/plugins", 'api_plugins.json')

    plugins = Kongkit.api_plugins(api_name)
    assert_equal 10, plugins[:total]
    assert plugins[:data].any?
  end

  it 'adds a plugin to the API' do
    api_name = 'mockbin'
    plugin_name = 'rate-limiting'
    plugin_request = {
      name: plugin_name,
      'config.minute': 20,
      'config.hour': 500
    }
    stub_kong_request(:post, "/apis/#{api_name}/plugins", 'plugin.json', build_post_body(plugin_request))

    plugin = Kongkit.add_plugin(api_name, plugin_request)
    assert_match plugin_name, plugin[:name]
    assert_equal 20, plugin[:config][:minute]
    assert_equal 500, plugin[:config][:hour]
  end

  it 'edits a plugin to the API' do
    api_name = 'mockbin'
    plugin_name = 'rate-limiting'
    plugin_request = {
      'config.minute': 10
    }
    stub_kong_request(:patch, "/apis/#{api_name}/plugins/#{plugin_name}", 'edited_plugin.json', build_post_body(plugin_request))

    plugin = Kongkit.edit_plugin(api_name, plugin_name, plugin_request)
    assert_match plugin_name, plugin[:name]
    assert_equal 10, plugin[:config][:minute]
    assert_equal 500, plugin[:config][:hour]
  end

  it 'deletes an api' do
    api_name = 'mockbin'
    plugin_name = 'rate-limiting'

    stub_kong_request(:delete, "/apis/#{api_name}/plugins/#{plugin_name}", nil)

    assert Kongkit.remove_plugin(api_name, plugin_name)
  end
end
