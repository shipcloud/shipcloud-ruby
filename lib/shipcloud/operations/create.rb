# frozen_string_literal: true

module Shipcloud
  module Operations
    module Create
      module ClassMethods
        # Creates a new object
        #
        # @param [Hash] attributes The attributes of the created object
        # @param \[String\] optional api_key The api key. If no api key is given, Shipcloud.api_key
        # will be used for the request
        def create(attributes, api_key: nil, affiliate_id: nil)
          response = Shipcloud.request(
            :post,
            base_url,
            attributes,
            api_key: api_key,
            affiliate_id: affiliate_id,
          )
          if create_response_root
            response = response.fetch(create_response_root, {})
          end
          new(response)
        end
      end

      def self.included(base)
        base.extend(ClassMethods)
      end
    end
  end
end
