# frozen_string_literal: true

module Shipcloud
  class OrderReturn < Base
    include Shipcloud::Operations::All
    include Shipcloud::Operations::Find

    attr_reader :id, :order, :order_id, :created_at, :updated_at
    attr_accessor :status, :returned_items

    def self.base_url
      "orders/returns"
    end
  end
end
