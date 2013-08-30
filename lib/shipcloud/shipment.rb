module Shipcloud
  class Shipment < Base

    attr_accessor :from, :to, :carrier, :package, :reference_number
    attr_reader :id, :created_at, :carrier_tracking_no, :tracking_url, :label_url, :packages, :price
  end
end