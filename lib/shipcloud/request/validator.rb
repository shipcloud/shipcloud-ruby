module Shipcloud
  module Request
    class Validator
      attr_reader :info
      attr_accessor :response

      def initialize(info)
        @info = info
      end

      def validated_data_for(incoming_response)
        self.response = incoming_response
        verify_response_code
        if response.body
          info.data = JSON.parse(response.body)
          validate_response_data
        end
        info.data
      end

      protected

      def verify_response_code
        raise AuthenticationError if response.code.to_i == 401
        raise APIError if response.code.to_i >= 500
      end

      def validate_response_data
        raise APIError.new(info.data["errors"]) if info.data["errors"]
      end
    end
  end
end
