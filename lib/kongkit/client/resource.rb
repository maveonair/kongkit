module Kongkit
  class Client
    class Resource
      include Enumerable

      def initialize(client, data, status_code)
        @client      = client
        @data        = data
        @status_code = status_code
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

      # Calls block once for each key in the data hash, passing the key-value pair as parameters
      #
      # @return [Enumerator] Enumerator
      def each(&block)
        data.each(&block)
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

      # Returns true if there is any error
      #
      # @return [Boolean] `true` if the response was an error
      def error?
        status_code >= 400
      end

      # Return the JSON representation of the resource
      #
      # @return [Hash] JSON representation
      def to_json
        data.merge({status_code: status_code}).to_json
      end

      private

      attr_reader :client, :data, :status_code
    end
  end
end
