# frozen_string_literal: true

module Shipcloud
  module Operations
    class Nested
      attr_reader :nested_resource_class, :nested_resource_route, :nested_resource_build_params

      def initialize(nested_resource_class, nested_resource_route, nested_resource_build_params)
        @nested_resource_class = nested_resource_class
        @nested_resource_route = nested_resource_route
        @nested_resource_build_params = nested_resource_build_params
      end

      def all(filter = {}, api_key: nil, affiliate_id: nil)
        Shipcloud.request(
          :get,
          nested_resource_route,
          filter,
          api_key: api_key,
          affiliate_id: affiliate_id,
        ).map { |hash| nested_resource_class.new(**hash.merge(nested_resource_build_params)) }
      end

      def find(id, api_key: nil, affiliate_id: nil)
        response = Shipcloud.request(
          :get,
          "#{nested_resource_route}/#{id}",
          {},
          api_key: api_key,
          affiliate_id: affiliate_id,
        )
        nested_resource_class.new(**response.merge(nested_resource_build_params))
      end

      def create(data, api_key: nil, affiliate_id: nil)
        response = Shipcloud.request(
          :post,
          nested_resource_route,
          data,
          api_key: api_key,
          affiliate_id: affiliate_id,
        )
        nested_resource_class.new(**response.merge(nested_resource_build_params))
      end
    end
  end
end
