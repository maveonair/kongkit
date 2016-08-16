module Kongkit
  class Client
    module Request
      # HTTP GET request
      #
      # @param path [String] The API path
      # @param options [Hash] The options
      # @return [Kongkit::Client::Resource] Resource
      def get(path, options = {})
        response = self.class.get(path, options)
        parse(response)
      end

      # HTTP POST request
      #
      # @param path [String] The API path
      # @param options [Hash] The options
      # @return [Kongkit::Client::Resource] Resource
      def post(path, options = {})
        response = self.class.post(path, options)
        parse(response)
      end

      # HTTP PATCH request
      #
      # @param path [String] The API path
      # @param options [Hash] The options
      # @return [Kongkit::Client::Resource] Resource
      def patch(path, options = {})
        response = self.class.patch(path, options)
        parse(response)
      end

      # HTTP DELETE request
      #
      # @param path [String] The API path
      # @param options [Hash] The options
      # @return [Boolean] `true` if successfully respondeds
      def delete(path, options = {})
        response = self.class.delete(path, options)
        response.success?
      end

      private

      def parse(response)
        Kongkit::Client::Resource.new(self, JSON.parse(response.body, symbolize_names: true))
      end
    end
  end
end
