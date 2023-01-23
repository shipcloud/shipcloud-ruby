# frozen_string_literal: true
require "spec_helper"

describe Shipcloud::OrderReturn do
  describe "#initialize" do
    it "initializes all attributes correctly" do
      order = Shipcloud::Order.new(id: "order-id")
      valid_attributes = {
        order: order,
        id: "order-return-id",
        status: "requested",
        created_at: "2023-01-15T15:30:00+01:00",
        updated_at: "2023-01-15T16:30:00+01:00",
        returned_items: [
          {
            order_line_item_id: "order_line_item_id",
            quantity: 42,
            reason_for_return: "delivery_too_late",
          },
        ],
      }

      order_return = described_class.new(valid_attributes)

      expect(order_return.order).to be order
      expect(order_return.id).to eq "order-return-id"
      expect(order_return.status).to eq "requested"
      expect(order_return.created_at).to eq "2023-01-15T15:30:00+01:00"
      expect(order_return.updated_at).to eq "2023-01-15T16:30:00+01:00"
      expect(order_return.returned_items).to eq [
        {
          order_line_item_id: "order_line_item_id",
          quantity: 42,
          reason_for_return: "delivery_too_late",
        },
      ]
    end
  end

  describe ".all" do
    it "executes a GET request to the 'orders/returns' API endpoint" do
      allow(Shipcloud).to receive(:request).and_return([])

      described_class.all(api_key: "api-key", affiliate_id: "affiliate-id")

      expect(Shipcloud).to have_received(:request).
        with(:get, "orders/returns", {}, api_key: "api-key", affiliate_id: "affiliate-id")
    end

    it "returns a list of Order Return objects" do
      stub_order_returns_request

      order_returns = described_class.all

      order_returns.each do |order_return|
        expect(order_return).to be_an_instance_of described_class
      end
    end
  end

  describe ".find" do
    it "executes a GET request to the 'orders/returns/:id' API endpoint" do
      allow(Shipcloud).to receive(:request).and_return("id" => "order-return-id")

      described_class.find("order-return-id", api_key: "api-key", affiliate_id: "affiliate-id")

      expect(Shipcloud).to have_received(:request).with(
        :get,
        "orders/returns/order-return-id",
        {},
        api_key: "api-key",
        affiliate_id: "affiliate-id",
      )
    end
  end

  def stub_order_returns_request(params: {}, affiliate_id: nil)
    allow(Shipcloud).to receive(:request).
      with(:get, "orders/returns", params, api_key: nil, affiliate_id: affiliate_id).
      and_return(order_returns_array)
  end

  def order_returns_array
    [
      {
        id: "order-return-id",
        order_id: "order-id",
        status: "requested",
        created_at: "2023-01-15T15:30:00+01:00",
        updated_at: "2023-01-15T16:30:00+01:00",
        returned_items: [
          {
            order_line_item_id: "order_line_item_id",
            quantity: 42,
            reason_for_return: "delivery_too_late",
          },
        ],
      },
    ]
  end
end
