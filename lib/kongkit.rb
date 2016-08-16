require 'kongkit/client'
require 'kongkit/version'

module Kongkit
  class << self
    # API client
    #
    # @param url [String] Kong admin url
    # @return [Kongkit::Client] API wrapper
    def client(url = 'http://localhost:8001')
      return @client if defined?(@client) && @client.same_url?(url)

      @client = Kongkit::Client.new(url)
    end

    private

    def respond_to_missing?(method_name, include_private = false)
      client.respond_to?(method_name, include_private)
    end

    def method_missing(method_name, *args, &block)
      if client.respond_to?(method_name)
        return client.send(method_name, *args, &block)
      end

      super
    end
  end
end
