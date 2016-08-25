require 'httparty'
require 'json'

require 'kongkit/client/api_object'
require 'kongkit/client/cluster'
require 'kongkit/client/consumer'
require 'kongkit/client/plugin_object'
require 'kongkit/client/node'
require 'kongkit/client/request'
require 'kongkit/client/resource'

module Kongkit
  class Client
    include HTTParty

    include ApiObject
    include Cluster
    include Consumer
    include PluginObject
    include Node
    include Request

    def initialize(configuration)
      @configuration = configuration

      self.class.base_uri(configuration.url)
      self.class.headers('Accept' => 'application/json')
    end

    def same_url?(url)
      configuration.url == url
    end

    private

    attr_reader :configuration
  end
end
