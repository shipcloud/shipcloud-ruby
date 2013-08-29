module Shipcloud
  class Shipment < Base

    attr_accessor :to, :carrier, :package
  end
end