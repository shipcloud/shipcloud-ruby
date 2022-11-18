# frozen_string_literal: true

module Shipcloud
  module Operations
    module Update
      module ClassMethods
        # Updates an object
        # @param [String] id The id of the object that should be updated
        # @param [Hash] attributes The attributes that should be updated
        # @param [String] optional api_key The api key. If no api key is given, Shipcloud.api_key
        # will be used for the request
        # @param [String] optional affiliate_id Your affiliate ID. If no affiliate ID is given,
        # Shipcloud.affiliate_id will be used for the request
        def update(id, attributes = {}, **kwargs)
          attributes.merge!(kwargs)
          options = attributes.slice(:api_key, :affiliate_id) || {}
          attributes.reject! { |key| [:api_key, :affiliate_id].include?(key) }
          response = Shipcloud.request(
            :put, "#{base_url}/#{id}", attributes,
            api_key: options[:api_key], affiliate_id: options[:affiliate_id]
          )
          new(response)
        end
      end

      def self.included(base)
        base.extend(ClassMethods)
      end

      # Updates an object
      #
      # @param [Hash] attributes The attributes that should be updated
      # @param [String] optional api_key The api key. If no api key is given, Shipcloud.api_key
      # will be used for the request
      # @param [String] optional affiliate_id Your affiliate ID. If no affiliate ID is given,
      # Shipcloud.affiliate_id will be used for the request
      def update(attributes = {}, **kwargs)
        self.class.update(id, attributes, **kwargs)
      end
    end
  end
end
