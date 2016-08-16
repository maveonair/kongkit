module Kongkit
  class Client
    class Resource
      def initialize(client, data)
        @client = client
        @data = data
      end

      # Allow fields to be retrieved via Hash notation
      #
      # @param key [Symbol] A symbol key
      # @return [Object] from data if exists
      def [](key)
        data[key]
      rescue NoMethodError
        nil
      end

      # Retrieves the next resource
      #
      # @return [Kongkit::Client::Resource] Resource
      def next
        return nil if data[:next].nil?
        client.get(data[:next])
      end

      # Returns a string containing a human-readable representation of this object
      #
      # @return [String] human-readable representation of this object
      def inspect
        data.inspect
      end

      private

      attr_reader :client, :data
    end
  end
end
