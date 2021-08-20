# frozen_string_literal: true

module Shipcloud
  module Operations
    module All
      module ClassMethods
        # Loads all Objects of the resource
        # @param [Hash] optional filter Filter the shipments list using one or more filter
        # creteria
        # @param [String] optional api_key The api key. If no api key is given, Shipcloud.api_key
        # will be used for the request
        def all(filter = {}, api_key: nil, affiliate_id: nil)
          response = Shipcloud.request(
            :get,
            base_url,
            filter,
            api_key: api_key,
            affiliate_id: affiliate_id,
          )
          if index_response_root
            response = response.fetch(index_response_root, [])
          end
          response.map { |hash| new(hash) }
        end
      end

      def self.included(base)
        base.extend(ClassMethods)
      end
    end
  end
end
