$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'kongkit'

require 'minitest/spec'
require 'minitest/autorun'
require 'minitest/reporters'
require 'webmock/minitest'
require 'pry'

Minitest::Reporters.use!

def stub_kong_request(method, path, fixture, body = '', status = 200)
  stub_request(method, "http://localhost:8001#{path}")
    .with(headers: {'Accept'=>'application/json'}, body: body)
    .to_return(status: status, body: load_fixture(fixture), headers: {})
end

def load_fixture(file_name)
  return nil if file_name.nil?

  file_path = File.join(Dir.pwd, 'test', 'fixtures', file_name)
  File.read(file_path)
end

def build_post_body(attributes)
  attributes.map do |key, value|
    escaped_value = value.is_a?(String) ? CGI.escape(value) : value

    "#{key}=#{escaped_value}"
  end.join('&')
end
