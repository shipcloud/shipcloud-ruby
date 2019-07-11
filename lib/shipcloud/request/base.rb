module Shipcloud
  module Request
    class Base
      attr_reader :info

      def initialize(info, affiliate_id)
        @info = info
        @affiliate_id = affiliate_id
      end

      def perform
        raise AuthenticationError unless @info.api_key
        connection.setup_https
        response = connection.request(@affiliate_id)
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

      def connection
        @connection ||= Connection.new(info)
      end
    end
  end
end
