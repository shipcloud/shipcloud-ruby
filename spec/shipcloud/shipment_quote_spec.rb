# frozen_string_literal: true
require "spec_helper"

describe Shipcloud::ShipmentQuote do
  valid_attributes = {
    to: {
      company: "Beispielfirma",
      street: "Beispielstrasse",
      street_no: "42",
      city: "Berlin",
      zip_code: "10000",
    },
    from: {
      company: "shipcloud GmbH",
      street: "Musterallee",
      street_no: "23",
      city: "Hamburg",
      zip_code: "20000",
    },
    service: "standard",
    carrier: "dhl",
    package: {
      weight: 2.5,
      length: 40,
      width: 20,
      height: 20,
    },
  }

  describe "#initialize" do
    it "initializes all attributes correctly" do
      quote = Shipcloud::ShipmentQuote.new(valid_attributes)

      expect(quote.to[:company]).to eq "Beispielfirma"
      expect(quote.to[:street]).to eq "Beispielstrasse"
      expect(quote.to[:street_no]).to eq "42"
      expect(quote.to[:city]).to eq "Berlin"
      expect(quote.to[:zip_code]).to eq "10000"
      expect(quote.from[:company]).to eq "shipcloud GmbH"
      expect(quote.from[:street]).to eq "Musterallee"
      expect(quote.from[:street_no]).to eq "23"
      expect(quote.from[:city]).to eq "Hamburg"
      expect(quote.from[:zip_code]).to eq "20000"
      expect(quote.carrier).to eq "dhl"
      expect(quote.service).to eq "standard"
      expect(quote.package[:weight]).to eq 2.5
      expect(quote.package[:length]).to eq 40
      expect(quote.package[:width]).to eq 20
      expect(quote.package[:height]).to eq 20
    end
  end

  describe ".create" do
    it "makes a new POST request using the correct API endpoint" do
      expect(Shipcloud).to receive(:request).
        with(:post, "shipment_quotes", valid_attributes, api_key: nil, affiliate_id: nil).
        and_return("data" => {})

      Shipcloud::ShipmentQuote.create(valid_attributes)
    end

    it "initializes a ShipmentQuote with price" do
      allow(Shipcloud).to receive(:request).
        and_return(
          "shipment_quote" => {
            "price" => 42.12,
          },
        )

      shipment_quote = Shipcloud::ShipmentQuote.create(valid_attributes)

      expect(shipment_quote.price).to eq 42.12
    end

    it "use the affiliate ID provided for the request" do
      expect(Shipcloud).to receive(:request).
        with(
          :post,
          "shipment_quotes",
          valid_attributes,
          api_key: nil,
          affiliate_id: "affiliate_id",
        ).and_return("data" => {})

      Shipcloud::ShipmentQuote.create(valid_attributes, affiliate_id: "affiliate_id")
    end
  end
end
