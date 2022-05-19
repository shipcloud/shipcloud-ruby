# frozen_string_literal: true

module Shipcloud
  class Order < Base
    include Shipcloud::Operations::All
    include Shipcloud::Operations::Find

    attr_reader :id, :external_customer_id, :external_order_id, :placed_at, :refundable_until,
                :delivery_address, :order_line_items
  end
end
