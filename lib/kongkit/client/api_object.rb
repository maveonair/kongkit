module Kongkit
  class Client
    module ApiObject
      # List APIs
      #
      # @see https://getkong.org/docs/0.8.x/admin-api/#list-apis
      # @option options [String] :id A filter on the list based on the apis `id` field
      # @option options [String] :name A filter on the list based on the apis `name` field
      # @option options [String] :request_host A filter on the list based on the apis `request_host` field
      # @option options [String] :request_path A filter on the list based on the apis `request_path` field
      # @option options [String] :upstream_url A filter on the list based on the apis `upstream_url` field
      # @option options [Integer] :size A limit on the number of objects to be returned, default: 100
      # @option options [String] :offset A cursor used for pagination. Offset is an object identifier that defines a place in the list.
      # @return [Kongkit::Client::Resource] API Objects
      def apis(options = {})
        get('/apis', query: options)
      end

      # Retrieve API
      #
      # @see https://getkong.org/docs/0.8.x/admin-api/#retrieve-api
      # @param identifier [String] The unique identifier or the name of the API to retrieve
      # @return [Kongkit::Client::Resource] API Object
      def api(identifier)
        get(api_path(identifier))
      end

      # Add API
      #
      # @note At least request_host or request_path or both should be specified.
      #
      # @see https://getkong.org/docs/0.8.x/admin-api/#add-api
      # @option attributes [String] :name The API name (optional)
      # @option attributes [String] :request_host The public DNS address that points to your API (semi-optional)
      # @option attributes [String] :request_path The public path that points to your API (semi-optional)
      # @option attributes [String] :strip_request_path Strip the request_path value before proxying the request to the final API (optional)
      # @option attributes [String] :preserve_host Preserves the original Host header sent by the client, instead of replacing it with the hostname of the upstream_url (optional)
      # @option attributes [String] :upstream_url The base target URL that points to your API server, this URL will be used for proxying requests
      # @return [Kongkit::Client::Resource] API Object
      def add_api(attributes)
        post('/apis', body: attributes)
      end

      # Edit API
      #
      # @note At least request_host or request_path or both should be specified.
      #
      # @see https://getkong.org/docs/0.8.x/admin-api/#update-api
      # @param identifier [String] The unique identifier or the name of the API to update
      # @option attributes [String] :name The API name (optional)
      # @option attributes [String] :request_host The public DNS address that points to your API (semi-optional)
      # @option attributes [String] :request_path The public path that points to your API (semi-optional)
      # @option attributes [String] :strip_request_path Strip the request_path value before proxying the request to the final API (optional)
      # @option attributes [String] :preserve_host Preserves the original Host header sent by the client, instead of replacing it with the hostname of the upstream_url (optional)
      # @option attributes [String] :upstream_url The base target URL that points to your API server, this URL will be used for proxying requests
      # @return [Kongkit::Client::Resource] API Object
      def edit_api(identifier, attributes)
        patch(api_path(identifier), body: attributes)
      end

      # Delete API
      #
      # @see https://getkong.org/docs/0.8.x/admin-api/#delete-api
      # @param identifier [String] The unique identifier or the name of the API to delete
      # @return [Boolean] `true` if successfully deleted
      def delete_api(identifier)
        delete(api_path(identifier))
      end

      private

      def api_path(identifier)
        "/apis/#{identifier}"
      end
    end
  end
end
