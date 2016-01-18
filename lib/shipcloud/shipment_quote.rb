module Shipcloud
  class ShipmentQuote < Base
    include Shipcloud::Operations::Create

    attr_accessor :from, :to, :carrier, :package, :service
    attr_reader :price

    # Creates a new object
    #
    # @param [Hash] attributes The attributes of the created object
    def self.create(attributes)
      response = Shipcloud.request(:post, base_url, attributes)
      new(response.fetch("shipment_quote", {}))
    end

    def self.base_url
      "shipment_quotes"
    end
  end
end
