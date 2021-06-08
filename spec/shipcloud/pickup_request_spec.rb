# frozen_string_literal: true
require "spec_helper"

describe Shipcloud::PickupRequest do
  valid_attributes = {
    carrier: "dpd",
    pickup_time: {
      earliest: "2015-09-15T09:00:00+02:00",
      latest: "2015-09-15T18:00:00+02:00",
    },
    shipments: [
      { id: "abc_123" },
    ],
  }

  valid_attributes_with_pickup_address = {
    carrier: "dpd",
    pickup_time: {
      earliest: "2015-09-15T09:00:00+02:00",
      latest: "2015-09-15T18:00:00+02:00",
    },
    pickup_address: {
      company: "Muster-Company",
      first_name: "Max",
      last_name: "Mustermann",
      street: "Musterstraße",
      street_no: "42",
      zip_code: "54321",
      city: "Musterstadt",
      country: "DE",
      phone: "555-555",
    },
    shipments: [
      { id: "abc_123" },
    ],
  }

  describe "#initialize" do
    it "initializes all attributes correctly" do
      pickup_request = Shipcloud::PickupRequest.new(valid_attributes_with_pickup_address)

      expect(pickup_request.carrier).to eq "dpd"
      expect(pickup_request.pickup_time[:earliest]).to eq "2015-09-15T09:00:00+02:00"
      expect(pickup_request.pickup_time[:latest]).to eq "2015-09-15T18:00:00+02:00"
      expect(pickup_request.pickup_address[:company]).to eq "Muster-Company"
      expect(pickup_request.pickup_address[:first_name]).to eq "Max"
      expect(pickup_request.pickup_address[:last_name]).to eq "Mustermann"
      expect(pickup_request.pickup_address[:street]).to eq "Musterstraße"
      expect(pickup_request.pickup_address[:street_no]).to eq "42"
      expect(pickup_request.pickup_address[:zip_code]).to eq "54321"
      expect(pickup_request.pickup_address[:country]).to eq "DE"
      expect(pickup_request.pickup_address[:phone]).to eq "555-555"
      expect(pickup_request.shipments).to eq [{ id: "abc_123" }]
    end
  end

  describe ".create" do
    it "makes a new POST request using the correct API endpoint" do
      expect(Shipcloud).to receive(:request).
        with(:post, "pickup_requests", valid_attributes, api_key: nil, affiliate_id: nil).
        and_return("data" => {})

      Shipcloud::PickupRequest.create(valid_attributes)
    end

    it "returns pickup request id" do
      allow(Shipcloud).to receive(:request).
        and_return(
          "id" => "123456",
          "carrier_pickup_number" => "abcdef",
          "carrier" => "dpd",
          "pickup_time" => {
            "earliest" => "2015-09-15T09:00:00+02:00",
            "latest" => "2015-09-15T18:00:00+02:00",
          },
        )

      pickup_request = Shipcloud::PickupRequest.create(valid_attributes)

      expect(pickup_request.id).to eq "123456"
      expect(pickup_request.carrier_pickup_number).to eq "abcdef"
    end

    it "returns a pickup_address" do
      allow(Shipcloud).to receive(:request).
        and_return(
          "id" => "123456",
          "carrier_pickup_number" => "abcdef",
          "carrier" => "dpd",
          "pickup_time" => {
            "earliest" => "2015-09-15T09:00:00+02:00",
            "latest" => "2015-09-15T18:00:00+02:00",
          },
          "pickup_address" => {
            "id" => "522a7cb1-d6c8-418c-ac26-011127ab5bbe",
            "company" => "Muster-Company",
            "first_name" => "Max",
            "last_name" => "Mustermann",
            "street" => "Musterstraße",
            "street_no" => "42",
            "zip_code" => "54321",
            "city" => "Musterstadt",
            "country" => "DE",
            "phone" => "555-555",
          },
        )

      pickup_request = Shipcloud::PickupRequest.create(valid_attributes_with_pickup_address)

      expect(pickup_request.pickup_address).to eq(
        "id" => "522a7cb1-d6c8-418c-ac26-011127ab5bbe",
        "company" => "Muster-Company",
        "first_name" => "Max",
        "last_name" => "Mustermann",
        "street" => "Musterstraße",
        "street_no" => "42",
        "zip_code" => "54321",
        "city" => "Musterstadt",
        "country" => "DE",
        "phone" => "555-555",
      )
    end

    it "use the affiliate ID provided for the request" do
      expect(Shipcloud).to receive(:request).
        with(
          :post,
          "pickup_requests",
          valid_attributes,
          api_key: nil,
          affiliate_id: "affiliate_id",
        ).and_return("data" => {})

      Shipcloud::PickupRequest.create(valid_attributes, affiliate_id: "affiliate_id")
    end
  end
end
