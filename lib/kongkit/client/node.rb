module Kongkit
  class Client
    module Node
      #  Retrieve node information
      #
      # Retrieve generic details about a node.
      #
      # @see https://getkong.org/docs/0.8.x/admin-api/#retrieve-node-information
      # @return [Hash] Node information
      def node_information
        get('/')
      end

      # Retrieve node status
      #
      # Retrieve usage information about a node, with some basic information
      # about the connections being processed by the underlying nginx process,
      # and the number of entities stored in the datastore collections
      # (including plugin's collections).
      #
      # If you want to monitor the Kong process, since Kong is built on top of nginx,
      # every existing nginx monitoring tool or agent can be used.
      #
      # @see https://getkong.org/docs/0.8.x/admin-api/#retrieve-node-status
      # @return [Hash] Node status
      def node_status
        get('/status')
      end
    end
  end
end
