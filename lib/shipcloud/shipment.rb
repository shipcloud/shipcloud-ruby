module Shipcloud
  class Shipment < Base

    attr_accessor :to, :carrier, :package
    attr_reader :id, :tracking_url, :label_url, :price
  end
end