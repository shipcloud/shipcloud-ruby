module Shipcloud
  module Request
    class Connection
      attr_reader :https

      def initialize(request_info)
        @info = request_info
      end

      def setup_https
        if Shipcloud.configuration.use_ssl
          @https             = Net::HTTP.new(Shipcloud.configuration.api_base, Net::HTTP.https_default_port)
          @https.use_ssl     = true
          @https.verify_mode = OpenSSL::SSL::VERIFY_PEER
        else
          @https             = Net::HTTP.new(Shipcloud.configuration.api_base, Net::HTTP.http_default_port)
          @https.use_ssl     = false
        end
        @https.set_debug_output $stdout if Shipcloud.configuration.debug
      end

      def request
        https.start do |connection|
          https.request(https_request)
        end
      end

      protected

      def https_request
        https_request =
          case @info.http_method
          when :post
            Net::HTTP::Post.new(@info.url, Shipcloud.api_headers(@info.data))
          when :put
            Net::HTTP::Put.new(@info.url, Shipcloud.api_headers(@info.data))
          when :delete
            Net::HTTP::Delete.new(@info.url, Shipcloud.api_headers(@info.data))
          else
            Net::HTTP::Get.new(
              @info.path_with_params(@info.url, @info.data),
              Shipcloud.api_headers(@info.data),
            )
          end

        https_request.basic_auth(@info.api_key, "")
        https_request.body = @info.data.to_json if [:post, :put].include?(@info.http_method)
        https_request
      end
    end
  end
end
