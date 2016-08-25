module Kongkit
  class Client
    module Cluster
      # Retrieve cluster status
      #
      # Retrieve the cluster status, returning information for each node in the cluster.
      #
      # @see https://getkong.org/docs/0.8.x/admin-api/#retrieve-cluster-status
      # @return [Kongkit::Client::Resource] Cluster status
      def cluster_status
        get('/cluster')
      end

      # Forcibly remove a node
      #
      # Forcibly remove a node from the cluster.
      #
      # @see https://getkong.org/docs/0.8.x/admin-api/#forcibly-remove-a-node
      # @param name [String] Name of the node
      # @return [Boolean] `true` if successfully removed
      def remove_node(name)
        delete('/cluster', query: { name: name })
      end
    end
  end
end
