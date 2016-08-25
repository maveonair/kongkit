module Kongkit
  class Client
    module KeyAuthentication
      # List Auth Keys for the given consumer
      #
      # @see https://getkong.org/plugins/key-authentication/
      # @param identifier [String] The unique identifier or the username of the consumer
      # @return [Kongkit::Client::Resource] Auth Keys
      def auth_keys(identifier)
        get(auth_key_path(identifier))
      end

      # Create a new Auth Key for the given consumer
      #
      # @see https://getkong.org/plugins/key-authentication/
      # @param identifier [String] The unique identifier or the username of the consumer
      # @return [Kongkit::Client::Resource] Auth Keys
      def add_auth_key(identifier)
        post(auth_key_path(identifier))
      end

      # Delete Auth Key
      #
      # @see https://getkong.org/docs/0.8.x/admin-api/#delete-consumer
      # @param identifier [String] The unique identifier or the name of the consumer to delete
      # @param id [String] The unique identifier of the Auth Key
      # @return [Boolean] `true` if successfully deleted
      def delete_auth_key(identifier, id)
        delete("#{auth_key_path(identifier)}/#{id}")
      end

      private

      def auth_key_path(identifier)
        "#{consumer_path(identifier)}/key-auth"
      end
    end
  end
end
