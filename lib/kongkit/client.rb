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

    def initialize(url = 'http://localhost:8001')
      @url = url

      self.class.base_uri(@url)
      self.class.headers('Accept' => 'application/json')
    end
  end
end
