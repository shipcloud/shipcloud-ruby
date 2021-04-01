# frozen_string_literal: true

module Shipcloud
  module Request
    class Info
      attr_accessor :http_method, :api_url, :api_key, :data, :affiliate_id

      def initialize(http_method, api_url, api_key, data, affiliate_id)
        @api_key      = api_key
        @http_method  = http_method
        @api_url      = api_url
        @data         = data
        @affiliate_id = affiliate_id
      end

      def url
        "/#{API_VERSION}/#{api_url}"
      end

      def path_with_params(path, params)
        if params.empty?
          path
        else
          encoded_params = URI.encode_www_form(params)
          [path, encoded_params].join("?")
        end
      end
    end
  end
end
