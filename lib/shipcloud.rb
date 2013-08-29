require "net/http"
require "net/https"
require "json"
require "shipcloud/version"

module Shipcloud
  API_BASE    = "api.shipcloud.io"
  API_VERSION = "v1"
  ROOT_PATH   = File.dirname(__FILE__)

  @@api_key = nil

  autoload :Base,           "shipcloud/base"
  autoload :Shipment,       "shipcloud/shipment"

  module Operations
    autoload :Create,       "shipcloud/operations/create"
  end

  module Request
    autoload :Base,         "shipcloud/request/base"
    autoload :Connection,   "shipcloud/request/connection"
    autoload :Info,         "shipcloud/request/info"
    autoload :Validator,    "shipcloud/request/validator"
  end

  class ShipcloudError < StandardError; end
  class AuthenticationError < ShipcloudError; end
  class APIError            < ShipcloudError; end

  # Returns the set api key
  #
  # @return [String] The api key
  def self.api_key
    @@api_key
  end

  # Sets the api key
  #
  # @param [String] api_key The api key
  def self.api_key=(api_key)
    @@api_key = api_key
  end

  # Makes a request against the shipcloud API
  #
  # @param [Symbol] http_method The http method to use, must be one of :get, :post, :put and :delete
  # @param [String] api_url The API url to use
  # @param [Hash] data The data to send, e.g. used when creating new objects.
  # @return [Array] The parsed JSON response.
  def self.request(http_method, api_url, data)
    info = Request::Info.new(http_method, api_url, data)
    Request::Base.new(info).perform
  end
end
