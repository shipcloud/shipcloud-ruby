module Shipcloud
  module Request
    class Info
      attr_accessor :http_method, :api_url, :api_key, :data

      def initialize(http_method, api_url, api_key, data)
        @api_key     = api_key
        @http_method = http_method
        @api_url     = api_url
        @data        = data
      end

      def url
        url = "/#{API_VERSION}/#{api_url}"
        url
      end

      def path_with_params(path, params)
        unless params.empty?
          encoded_params = URI.encode_www_form(params)
          [path, encoded_params].join("?")
        else
          path
        end
      end
    end
  end
end
