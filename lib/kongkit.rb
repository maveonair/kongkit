require 'kongkit/client'
require 'kongkit/configuration'
require 'kongkit/version'

module Kongkit
  class << self
    attr_accessor :configuration

    def configuration
      @@configuration ||= Kongkit::Configuration.new
    end

    # API client
    #
    # @return [Kongkit::Client] API wrapper
    def client
      return @client if defined?(@client)

      @client = Kongkit::Client.new(configuration.url)
    end

    def configure
      yield(configuration)
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
