# frozen_string_literal: true

module Shipcloud
  module Operations
    module Update
      module ClassMethods
        # Updates a object
        # @param [String] id The id of the object that should be updated
        # @param [Hash] attributes The attributes that should be updated
        # @param \[String\] optional api_key The api key. If no api key is given, Shipcloud.api_key
        # will be used for the request
        def update(id, attributes, api_key: nil, affiliate_id: nil)
          response = Shipcloud.request(
            :put, "#{base_url}/#{id}", attributes, api_key: api_key, affiliate_id: affiliate_id
          )
          new(response)
        end
      end

      def self.included(base)
        base.extend(ClassMethods)
      end

      # Updates a object
      #
      # @param [Hash] attributes The attributes that should be updated
      # @param \[String\] optional api_key The api key. If no api key is given, Shipcloud.api_key
      # will be used for the request
      def update(attributes, api_key: nil, affiliate_id: nil)
        response = Shipcloud.request(
          :put, "#{base_url}/#{id}", attributes, api_key: api_key, affiliate_id: affiliate_id
        )
        set_attributes(response)
      end
    end
  end
end
