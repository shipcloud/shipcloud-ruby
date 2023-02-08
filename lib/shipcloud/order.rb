# frozen_string_literal: true

module Shipcloud
  class Order < Base
    include Shipcloud::Operations::All
    include Shipcloud::Operations::Find
    include Shipcloud::Operations::Create
    include Shipcloud::Operations::Delete

    attr_reader :id
    attr_accessor :external_customer_id, :external_order_id, :placed_at, :total_price, :total_vat,
                  :currency, :total_weight, :weight_unit, :refundable_until,
                  :refund_deduction_amount, :delivery_address, :order_line_items, :metadata

    def returns
      @_returns ||= Shipcloud::Operations::Nested.new(
        OrderReturn, "orders/#{id}/returns", order: self
      ) do |nested_operations|
        nested_operations.add :all
        nested_operations.add :find
        nested_operations.add :create
      end
    end
  end
end
