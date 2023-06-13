# frozen_string_literal: true

module Shipcloud
  class Shipment < Base
    include Shipcloud::Operations::Delete
    include Shipcloud::Operations::Update
    include Shipcloud::Operations::All

    attr_accessor :from, :to, :carrier, :service, :package, :reference_number, :metadata,
                  :additional_services
    attr_reader :id, :created_at, :carrier_tracking_no, :tracking_url, :label_url, :carrier_tracking_url,
                :packages, :price, :customs_declaration, :pickup, :label_voucher_url

    def self.index_response_root
      "#{class_name.downcase}s"
    end
  end
end
