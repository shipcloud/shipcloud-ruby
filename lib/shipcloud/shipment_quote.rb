# frozen_string_literal: true

module Shipcloud
  class ShipmentQuote < Base
    include Shipcloud::Operations::Create

    attr_accessor :from, :to, :carrier, :package, :service
    attr_reader :price

    def self.base_url
      "shipment_quotes"
    end

    def self.create_response_root
      "shipment_quote"
    end
  end
end
