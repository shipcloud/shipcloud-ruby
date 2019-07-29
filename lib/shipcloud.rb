require "net/http"
require "net/https"
require "json"
require "shipcloud/version"
require "shipcloud/shipcloud_error"

module Shipcloud
  API_VERSION = "v1"
  ROOT_PATH   = File.dirname(__FILE__)

  API_HEADERS = {
    "Content-Type" => "application/json",
    "User-Agent" => "shipcloud-ruby v#{Shipcloud::VERSION}, API #{Shipcloud::API_VERSION}, #{RUBY_VERSION}, #{RUBY_PLATFORM}, #{RUBY_PATCHLEVEL}"
  }

  DEFAULT_AFFILIATE_ID = "integration.shipcloud-ruby-gem.v#{Shipcloud::VERSION}".freeze

  autoload :Base,           "shipcloud/base"
  autoload :Shipment,       "shipcloud/shipment"
  autoload :Carrier,        "shipcloud/carrier"
  autoload :Address,        "shipcloud/address"
  autoload :PickupRequest,  "shipcloud/pickup_request"
  autoload :ShipmentQuote,  "shipcloud/shipment_quote"
  autoload :Tracker,        "shipcloud/tracker"
  autoload :Webhook,        "shipcloud/webhook"

  module Operations
    autoload :Create,       "shipcloud/operations/create"
    autoload :Find,         "shipcloud/operations/find"
    autoload :All,          "shipcloud/operations/all"
    autoload :Delete,       "shipcloud/operations/delete"
    autoload :Update,       "shipcloud/operations/update"
  end

  module Request
    autoload :Base,         "shipcloud/request/base"
    autoload :Connection,   "shipcloud/request/connection"
    autoload :Info,         "shipcloud/request/info"
  end

  class << self
    attr_accessor :configuration
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configure
    yield(configuration)
  end

  def self.api_headers
    API_HEADERS.merge(
      "Affiliate-ID" => affiliate_id,
    )
  end

  class Configuration
    attr_accessor :affiliate_id, :api_key, :api_base, :use_ssl, :debug

    def initialize
      @api_key = nil
      @api_base = 'api.shipcloud.io'
      @use_ssl = true
      @debug = false
    end
  end

  # Returns the set api key
  #
  # @return [String] The api key
  def self.api_key
    configuration.api_key
  end

  # Sets the api key
  #
  # @param [String] api_key The api key
  def self.api_key=(api_key)
    configuration.api_key = api_key
  end

  def self.affiliate_id
    configuration.affiliate_id || DEFAULT_AFFILIATE_ID
  end

  # Makes a request against the shipcloud API
  #
  # @param [Symbol] http_method The http method to use, must be one of :get, :post, :put and :delete
  # @param [String] api_url The API url to use
  # @param [Hash] data The data to send, e.g. used when creating new objects.
  # @param [String] optional api_key The api key. If no api key is given, Shipcloud.api_key will
  # be used for the request
  # @return [Array] The parsed JSON response.
  def self.request(http_method, api_url, data, api_key: nil, affiliate_id: nil)
    api_key ||= Shipcloud.api_key
    affiliate_id ||= Shipcloud.affiliate_id
    info = Request::Info.new(http_method, api_url, api_key, data, affiliate_id)
    Request::Base.new(info).perform
  end
end
