module Shipcloud
  class PickupRequest < Base
    include Shipcloud::Operations::Create

    attr_accessor :carrier, :pickup_time, :shipments

    def self.base_url
      "pickup_requests"
    end
  end
end
