module Shipcloud
  class ShipmentQuote < Base
    include Shipcloud::Operations::Create

    attr_accessor :from, :to, :carrier, :package, :service
    attr_reader :shipment_quote

    def self.base_url
      "#{camel_to_snakecase(class_name)}s"
    end

    def self.price
      shipment_quote.price
    end
  end
end
