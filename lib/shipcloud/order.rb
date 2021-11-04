# frozen_string_literal: true

module Shipcloud
  class Order < Base
    include Shipcloud::Operations::All

    attr_reader :delivery_address, :external_customer_id, :external_order_id, :order_line_items
  end
end
