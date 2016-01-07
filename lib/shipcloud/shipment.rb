module Shipcloud
  class Shipment < Base
    include Shipcloud::Operations::Delete
    include Shipcloud::Operations::Update
    include Shipcloud::Operations::All

    attr_accessor :from, :to, :carrier, :package, :reference_number
    attr_reader :id, :created_at, :carrier_tracking_no, :tracking_url, :label_url, :packages, :price

    def self.index_response_root
      "#{class_name.downcase}s"
    end
  end
end
