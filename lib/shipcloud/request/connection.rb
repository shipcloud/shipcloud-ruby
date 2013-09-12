module Shipcloud
  module Request
    class Connection
      attr_reader :https

      def initialize(request_info)
        @info = request_info
      end

      def setup_https
        @https             = Net::HTTP.new(Shipcloud.configuration.api_base, Net::HTTP.https_default_port)
        @https.use_ssl     = true
        @https.verify_mode = OpenSSL::SSL::VERIFY_PEER
        # @https.ca_file     = File.join(ROOT_PATH, "data/shipcloud.crt")
        # @https.set_debug_output $stdout
      end

      def request
        https.start do |connection|
          https.request(https_request)
        end
      end

      protected

      def https_request
        https_request = case @info.http_method
                        when :post
                          Net::HTTP::Post.new(@info.url, API_HEADERS)
                        when :put
                          Net::HTTP::Put.new(@info.url, API_HEADERS)
                        when :delete
                          Net::HTTP::Delete.new(@info.url, API_HEADERS)
                        else
                          Net::HTTP::Get.new(@info.path_with_params(@info.url, @info.data), API_HEADERS)
                        end
        https_request.basic_auth(Shipcloud.api_key, "")
        https_request.body = @info.data.to_json if [:post, :put].include?(@info.http_method)
        https_request
      end
    end
  end
end
