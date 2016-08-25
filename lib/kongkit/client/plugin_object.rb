module Kongkit
  class Client
    module PluginObject
      # List all Plugins
      #
      # @see https://getkong.org/docs/0.8.x/admin-api/#list-all-plugins
      # @option options [String] :id A filter on the list based on the `id` field
      # @option options [String] :name A filter on the list based on the `name` field
      # @option options [String] :api_id A filter on the list based on the `api_id` field
      # @option options [String] :consumer_id A filter on the list based on the `consumer_id` field
      # @option options [Integer] :size A limit on the number of objects to be returned, default: 100
      # @option options [offset] :offset A cursor used for pagination. offset is an object identifier that defines a place in the list.
      # @return [Kongkit::Client::Resource] Plugin Objects
      def plugins(options = {})
        get('/plugins', options)
      end

      # List enabled Plugins
      #
      # Retrieve a list of all installed plugins on the Kong node.
      #
      # @see https://getkong.org/docs/0.8.x/admin-api/#list-enabled-plugins
      # @return [Kongkit::Client::Resource] Plugin Objects
      def enabled_plugins
        get('/plugins/enabled')
      end

      # Retrieve Plugin Schema
      #
      # Retrieve the schema of a plugin's configuration.
      # This is useful to understand what fields a plugin accepts,
      # and can be used for building third-party integrations to the Kong's plugin system.
      #
      # @see https://getkong.org/docs/0.8.x/admin-api/#list-enabled-plugins
      # @param name [String] The name of the plugin to retrieve its schema
      # @return [Kongkit::Client::Resource] Plugin Objects
      def plugin_schema(name)
        get("/plugins/schema/#{name}")
      end

      # Retrieve Plugin
      #
      # @see https://getkong.org/docs/0.8.x/admin-api/#retrieve-plugin
      # @param id [String] The unique identifier of the plugin to retrieve
      # @return [Kongkit::Client::Resource] Plugin Object
      def plugin(id)
        get("/plugins/#{id}")
      end

      # List Plugins per API
      #
      # @see https://getkong.org/docs/0.8.x/admin-api/#list-plugins-per-api
      # @param api_identifier [String] The unique identifier or the name of the API
      # @option options [String] :id A filter on the list based on the `id` field
      # @option options [String] :name A filter on the list based on the `name` field
      # @option options [String] :api_id A filter on the list based on the `api_id` field
      # @option options [String] :consumer_id A filter on the list based on the `consumer_id` field
      # @option options [Integer] :size A limit on the number of objects to be returned, default: 100
      # @option options [offset] :offset A cursor used for pagination. offset is an object identifier that defines a place in the list.
      # @return [Kongkit::Client::Resource] Plugin Objects
      def api_plugins(api_identifier, options = {})
        get(api_plugins_path(api_identifier), options)
      end

      # Add plugin
      #
      # @see https://getkong.org/docs/0.8.x/admin-api/#add-plugin
      # @param api_identifier [String] The unique identifier or the name of the API on which to add a plugin configuration
      # @option attributes [String] :name The name of the Plugin that's going to be added.
      # @option attributes [String] :consumer_id The unique identifier of the consumer that overrides the existing settings for this specific consumer on incoming requests (optional)
      # @option attributes [String] :config.{property} The configuration properties for the Plugin.
      # @return [Kongkit::Client::Resource] Plugin Object
      def add_plugin(api_identifier, attributes)
        post(api_plugins_path(api_identifier), body: attributes)
      end

      # Edit plugin
      #
      # @see https://getkong.org/docs/0.8.x/admin-api/#update-plugin
      # @param api_identifier [String] The unique identifier or the name of the API for which to update the plugin configuration
      # @param id [String] he unique identifier of the plugin configuration to update on this API
      # @option attributes [String] :name The name of the Plugin that's going to be added.
      # @option attributes [String] :consumer_id The unique identifier of the consumer that overrides the existing settings for this specific consumer on incoming requests (optional)
      # @option attributes [String] :config.{property} The configuration properties for the Plugin.
      # @return [Kongkit::Client::Resource] Plugin Object
      def edit_plugin(api_identifier, id, attributes)
        patch(api_plugin_path(api_identifier, id), body: attributes)
      end

      # Remove plugin
      #
      # @see https://getkong.org/docs/0.8.x/admin-api/#delete-plugin
      # @param api_identifier [String] The unique identifier or the name of the API for which to remove the plugin configuration
      # @param id [String] The unique identifier of the plugin configuration to update on this API
      # @return [Boolean] `true` if successfully removed
      def remove_plugin(api_identifier, id)
        delete(api_plugin_path(api_identifier, id))
      end

      private

      def api_plugins_path(api_identifier)
        "/apis/#{api_identifier}/plugins"
      end

      def api_plugin_path(api_identifier, id)
        "#{api_plugins_path(api_identifier)}/#{id}"
      end
    end
  end
end
