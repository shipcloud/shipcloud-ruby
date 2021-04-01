# frozen_string_literal: true

module Shipcloud
  module Request
    class Base
      attr_reader :info

      def initialize(info)
        @info = info
      end

      def perform
        raise AuthenticationError unless @info.api_key

        connection.setup_https
        response = connection.request
        validate_response(response)
        JSON.parse(response.body) unless response.body.nil?
      rescue JSON::ParserError
        raise ShipcloudError.new(response)
      end

      protected

      def validate_response(response)
        error = ShipcloudError.from_response(response)
        if error
          raise error
        end
      end

      # rubocop:disable Naming/MemoizedInstanceVariableName
      def connection
        @connection ||= Connection.new(info)
      end
      # rubocop:enable Naming/MemoizedInstanceVariableName
    end
  end
end
