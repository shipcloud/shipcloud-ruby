module Shipcloud
  class PickupRequest < Base
    include Shipcloud::Operations::Create

    attr_accessor :carrier, :pickup_time, :shipments
    attr_reader :id, :carrier_pickup_number

    def self.base_url
      "pickup_requests"
    end
  end
end
