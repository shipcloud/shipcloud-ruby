require "spec_helper"

describe Shipcloud::Webhook do
  valid_attributes = {
    url: "https://example.com/webhook",
    event_types: ["shipment.tracking.delayed", "shipment.tracking.delivered"]
  }

  describe "#initialize" do
    it "initializes all attributes correctly" do
      webhook = Shipcloud::Webhook.new(valid_attributes)
      expect(webhook.url).to eq "https://example.com/webhook"
      expect(webhook.event_types).to eq ["shipment.tracking.delayed", "shipment.tracking.delivered"]
    end
  end

  describe ".create" do
    it "makes a new POST request using the correct API endpoint" do
      expect(Shipcloud).to receive(:request).
        with(:post, "webhooks", valid_attributes, api_key: nil).
        and_return("data" => {})
      Shipcloud::Webhook.create(valid_attributes)
    end
  end

  describe ".find" do
    it "makes a new GET request using the correct API endpoint to receive a specific webhook" do
      expect(Shipcloud).to receive(:request).
        with(:get, "webhooks/123", {}, api_key: nil).
        and_return("id" => "123")
      Shipcloud::Webhook.find("123")
    end
  end

  describe ".all" do
    it "makes a new Get request using the correct API endpoint" do
      expect(Shipcloud).to receive(:request).
        with(:get, "webhooks", {}, api_key: nil).
        and_return("webhooks" => [])

      Shipcloud::Webhook.all
    end

    it "returns a list of Webhook objects" do
      stub_webhooks_request

      webhooks = Shipcloud::Webhook.all

      webhooks.each do |webhook|
        expect(webhook).to be_a Shipcloud::Webhook
      end
    end
  end

  def stub_webhooks_request
    allow(Shipcloud).to receive(:request).
      with(:get, "webhooks", {}, api_key: nil).
      and_return("webhooks" => webhooks_array)
  end

  def webhooks_array
    [
      {
        "id" => "583cfd8b-77c7-4447-a3a0-1568bb9cc553",
        "url" => "https://example.com/webhook",
        "event_types" => ["shipment.tracking.delayed", "shipment.tracking.delivered"],
        "deactivated" => false
      },
      {
        "id" => "e0ff4250-6c8e-494d-a069-afd9d566e372",
        "url" => "https://example.com/webhook",
        "event_types" => ["shipment.tracking.delayed", "shipment.tracking.delivered"],
        "deactivated" => false
      }
    ]
  end
end
