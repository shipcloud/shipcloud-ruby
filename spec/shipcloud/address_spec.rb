# encoding: utf-8
# frozen_string_literal: true
require "spec_helper"

describe Shipcloud::Address do
  valid_attributes = {
    company: "shipcloud GmbH",
    first_name: "Maxi",
    last_name: "Musterfrau",
    care_of: "Mustermann",
    street: "Musterstraße",
    street_no: "123",
    zip_code: "12345",
    city: "Hamburg",
    state: "Hamburg",
    country: "DE",
    phone: "040/123456789",
    email: "max@mustermail.com",
  }

  describe "#initialize" do
    it "initializes all attributes correctly" do
      address = Shipcloud::Address.new(valid_attributes)
      expect(address.company).to eq "shipcloud GmbH"
      expect(address.first_name).to eq "Maxi"
      expect(address.last_name).to eq "Musterfrau"
      expect(address.care_of).to eq "Mustermann"
      expect(address.street).to eq "Musterstraße"
      expect(address.street_no).to eq "123"
      expect(address.zip_code).to eq "12345"
      expect(address.city).to eq "Hamburg"
      expect(address.state).to eq "Hamburg"
      expect(address.country).to eq "DE"
      expect(address.phone).to eq "040/123456789"
      expect(address.email).to eq "max@mustermail.com"
    end
  end

  describe ".create" do
    it "makes a new POST request using the correct API endpoint" do
      expect(Shipcloud).to receive(:request).
        with(:post, "addresses", valid_attributes, api_key: nil, affiliate_id: nil).
        and_return("data" => {})

      Shipcloud::Address.create(valid_attributes)
    end

    it "returns an address containing an id" do
      expect(Shipcloud).to receive(:request).
        with(:post, "addresses", valid_attributes, api_key: nil, affiliate_id: nil).
        and_return(returned_address)

      address = Shipcloud::Address.create(valid_attributes)

      expect(address.id).to eq("1c81efb7-9b95-4dd8-92e3-cac1bca3df6f")
    end

    it "use the affiliate ID provided for the request" do
      expect(Shipcloud).to receive(:request).
        with(:post, "addresses", valid_attributes, api_key: nil, affiliate_id: "affiliate_id").
        and_return(returned_address)

      address = Shipcloud::Address.create(valid_attributes, affiliate_id: "affiliate_id")

      expect(address.id).to eq("1c81efb7-9b95-4dd8-92e3-cac1bca3df6f")
    end
  end

  describe ".find" do
    it "makes a new GET request using the correct API endpoint to receive a specific address" do
      expect(Shipcloud).to receive(:request).with(
        :get, "addresses/123", {}, api_key: nil, affiliate_id: nil
      ).and_return("id" => "123")

      Shipcloud::Address.find("123")
    end

    it "use the affiliate ID provided for the request" do
      expect(Shipcloud).to receive(:request).with(
        :get, "addresses/123", {}, api_key: nil, affiliate_id: "affiliate_id"
      ).and_return("id" => "123")

      Shipcloud::Address.find("123", affiliate_id: "affiliate_id")
    end
  end

  describe ".update" do
    it "makes a new PUT request using the correct API endpoint" do
      expect(Shipcloud).to receive(:request).with(
        :put, "addresses/123", { street: "Mittelweg" }, api_key: nil, affiliate_id: nil
      ).and_return("data" => {})

      Shipcloud::Address.update("123", street: "Mittelweg")
    end

    it "use the affiliate ID provided for the request" do
      expect(Shipcloud).to receive(:request).with(
        :put, "addresses/123", { street: "Mittelweg" }, api_key: nil, affiliate_id: "affiliate_id"
      ).and_return("data" => {})

      Shipcloud::Address.update("123", { street: "Mittelweg" }, affiliate_id: "affiliate_id")
    end
  end

  describe ".all" do
    it "makes a new Get request using the correct API endpoint" do
      expect(Shipcloud).to receive(:request).
        with(:get, "addresses", {}, api_key: nil, affiliate_id: nil).and_return([])

      Shipcloud::Address.all
    end

    it "returns a list of Address objects" do
      stub_addresses_request

      addresses = Shipcloud::Address.all

      addresses.each do |address|
        expect(address).to be_a Shipcloud::Address
      end
    end

    it "use the affiliate ID provided for the request" do
      stub_addresses_request(affiliate_id: "affiliate_id")

      addresses = Shipcloud::Address.all(affiliate_id: "affiliate_id")

      addresses.each do |address|
        expect(address).to be_a Shipcloud::Address
      end
    end
  end

  def stub_addresses_request(affiliate_id: nil)
    allow(Shipcloud).to receive(:request).
      with(:get, "addresses", {}, api_key: nil, affiliate_id: affiliate_id).
      and_return(
        [
          {
            "id" => "1c81efb7-9b95-4dd8-92e3-cac1bca3df6f",
            "company" => "",
            "first_name" => "Max",
            "last_name" => "Mustermann",
            "care_of" => "",
            "street" => "Musterstraße",
            "street_no" => "42",
            "zip_code" => "12345",
            "city" => "Musterstadt",
            "state" => "",
            "country" => "DE",
            "phone" => "",
          },
          {
            "id" => "7ea2a290-b456-4ecf-9010-e82b3da298f0",
            "company" => "Muster-Company",
            "first_name" => "Max",
            "last_name" => "Mustermann",
            "care_of" => "",
            "street" => "Musterstraße",
            "street_no" => "42",
            "zip_code" => "54321",
            "city" => "Musterstadt",
            "state" => "",
            "country" => "DE",
            "phone" => "",
          },
        ],
      )
  end

  def returned_address
    {
      "id" => "1c81efb7-9b95-4dd8-92e3-cac1bca3df6f",
      "company" => "shipcloud GmbH",
      "first_name" => "Maxi",
      "last_name" => "Musterfrau",
      "care_of" => "Mustermann",
      "street" => "Musterstraße",
      "street_no" => "123",
      "zip_code" => "12345",
      "city" => "Hamburg",
      "state" => "Hamburg",
      "country" => "DE",
      "phone" => "040/123456789",
    }
  end
end
