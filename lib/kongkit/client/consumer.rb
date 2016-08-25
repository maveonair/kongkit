module Kongkit
  class Client
    module Consumer
      # List consumers
      #
      # @see https://getkong.org/docs/0.8.x/admin-api/#list-consumers
      # @option options [String] :id A filter on the list based on the consumer `id` field
      # @option options [String] :custom_id A filter on the list based on the consumer `custom_id` field
      # @option options [String] :username A filter on the list based on the consumer `username` field
      # @option options [Integer] :size A limit on the number of objects to be returned, default: 100
      # @option options [String] :offset A cursor used for pagination. Offset is an object identifier that defines a place in the list.
      # @return [Kongkit::Client::Resource] API Objects
      def consumers(options = {})
        get('/consumers', query: options)
      end

      # Retrieve consumer
      #
      # @see https://getkong.org/docs/0.8.x/admin-api/#retrieve-consumer
      # @param identifier [String] The unique identifier or the username of the consumer to retrieve
      # @return [Kongkit::Client::Resource] Consumer
      def consumer(identifier)
        get(consumer_path(identifier))
      end

      # Create consumer
      #
      # @note At least username or custom_id should be specified.
      #
      # @see https://getkong.org/docs/0.8.x/admin-api/#create-consumer
      # @option attributes [String] :username The username of the consumer (semi-optional)
      # @option attributes [String] :custom_id Field for storing an existing ID for the consumer, useful for mapping Kong with users in your existing database (semi-optional)
      # @return [Kongkit::Client::Resource] Consumer
      def create_consumer(attributes)
        post('/consumers', body: attributes)
      end

      # Edit consumer
      #
      # @note At least username or custom_id should be specified.
      #
      # @see https://getkong.org/docs/0.8.x/admin-api/#update-consumer
      # @param identifier [String] The unique identifier or the name of the consumer to update
      # @option attributes [String] :username The username of the consumer (semi-optional)
      # @option attributes [String] :custom_id Field for storing an existing ID for the consumer, useful for mapping Kong with users in your existing database (semi-optional)
      # @return [Kongkit::Client::Resource] Consumer
      def edit_consumer(identifier, attributes)
        patch(consumer_path(identifier), body: attributes)
      end

      # Delete Consumer
      #
      # @see https://getkong.org/docs/0.8.x/admin-api/#delete-consumer
      # @param identifier [String] The unique identifier or the name of the consumer to delete
      # @return [Boolean] `true` if successfully deleted
      def delete_consumer(identifier)
        delete(consumer_path(identifier))
      end

      private

      def consumer_path(identifier)
        "/consumers/#{identifier}"
      end
    end
  end
end
