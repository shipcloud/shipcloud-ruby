# frozen_string_literal: true
require "spec_helper"

describe Shipcloud::Order do
  describe "#initialize" do
    it "initializes all attributes correctly" do
      valid_attributes = {
        external_order_id: "external_order_id",
        external_customer_id: "external_customer_id",
        refundable_until: "refundable_until",
        total_weight: 12.34,
        refund_deduction_amount: 4.32,
        delivery_address: {
          id: "adress_id",
        },
        order_line_items: [
          {
            id: "order_line_item_id",
          },
        ],
      }
      order = Shipcloud::Order.new(valid_attributes)

      expect(order.external_order_id).to eq "external_order_id"
      expect(order.external_customer_id).to eq "external_customer_id"
      expect(order.refundable_until).to eq "refundable_until"
      expect(order.total_weight).to eq 12.34
      expect(order.refund_deduction_amount).to eq 4.32
      expect(order.delivery_address).to eq(id: "adress_id")
      expect(order.order_line_items).to eq [
        { id: "order_line_item_id" },
      ]
    end
  end

  describe ".all" do
    it "executes a GET request to the 'orders' API endpoint" do
      expect(Shipcloud).to receive(:request).
        with(:get, "orders", {}, api_key: nil, affiliate_id: nil).
        and_return([])

      Shipcloud::Order.all
    end

    it "returns a list of Order objects" do
      stub_orders_request

      orders = Shipcloud::Order.all

      orders.each do |order|
        expect(order).to be_a Shipcloud::Order
      end
    end

    it "returns a filtered list of order objects when using filter parameters" do
      filter = {
        "external_customer_id" => "external_customer_id",
        "external_order_id" => "external_order_id",
      }

      expect(Shipcloud).to receive(:request).
        with(:get, "orders", filter, api_key: nil, affiliate_id: nil).
        and_return(orders_array)

      Shipcloud::Order.all(filter, api_key: nil)
    end

    it "uses the affiliate ID provided for the request" do
      expect(Shipcloud).to receive(:request).
        with(:get, "orders", {}, api_key: nil, affiliate_id: "affiliate_id").
        and_return([])

      Shipcloud::Order.all(affiliate_id: "affiliate_id")
    end
  end

  describe ".find" do
    it "executes a GET request to the 'orders/:id' API endpoint" do
      expect(Shipcloud).to receive(:request).
        with(:get, "orders/order_id", {}, api_key: nil, affiliate_id: nil).
        and_return("id" => "order_id")

      Shipcloud::Order.find("order_id")
    end
  end

  describe ".create" do
    it "executes a POST request to the 'orders' API endpoint" do
      expect(Shipcloud).to receive(:request).
        with(:post, "orders", valid_attributes, api_key: nil, affiliate_id: nil).
        and_return("data" => {})

      Shipcloud::Order.create(valid_attributes)
    end

    it "uses the affiliate ID provided for the request" do
      expect(Shipcloud).to receive(:request).
        with(
          :post,
          "orders",
          valid_attributes,
          api_key: nil,
          affiliate_id: "affiliate_id",
        ).and_return("data" => {})

      Shipcloud::Order.create(valid_attributes, affiliate_id: "affiliate_id")
    end
  end

  describe ".delete" do
    it "executes a DELETE request to the 'orders/:id' API endpoint" do
      expect(Shipcloud).to receive(:request).
        with(:delete, "orders/123", {}, api_key: nil, affiliate_id: nil).
        and_return(true)

      Shipcloud::Order.delete("123")
    end

    it "does not raise an error" do
      stub_request(:delete, "https://api.shipcloud.io/v1/orders/123").
        to_return(status: 204, body: "")

      expect { Shipcloud::Order.delete("123", api_key: "your-api-key") }.
        to_not raise_error
    end

    it "uses the affiliate ID provided for the request" do
      expect(Shipcloud).to receive(:request).with(
        :delete, "orders/123", {}, api_key: nil, affiliate_id: "affiliate_id"
      ).and_return(true)

      Shipcloud::Order.delete("123", affiliate_id: "affiliate_id")
    end
  end

  def stub_orders_request(params: {}, affiliate_id: nil)
    allow(Shipcloud).to receive(:request).
      with(:get, "orders", params, api_key: nil, affiliate_id: affiliate_id).
      and_return(orders_array)
  end

  def orders_array
    [
      {
        id: "order_id",
        external_order_id: "external_order_id",
        external_customer_id: "external_customer_id",
        delivery_address: {
          id: "adress_id",
        },
        order_line_items: [
          {
            id: "order_line_item_id",
          },
        ],
      },
      {
        id: "order_id1",
        external_order_id: "external_order_id1",
        external_customer_id: "external_customer_id1",
        delivery_address: {
          id: "adress_id1",
        },
        order_line_items: [
          {
            id: "order_line_item_id1",
          },
        ],
      },
    ]
  end

  def valid_attributes
    {
      id: "order_id",
      external_order_id: "external_order_id",
      external_customer_id: "external_customer_id",
      delivery_address: {
        id: "adress_id",
      },
      order_line_items: [
        {
          id: "order_line_item_id",
        },
      ],
    }
  end
end
