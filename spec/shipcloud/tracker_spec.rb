# frozen_string_literal: true
require "spec_helper"

describe Shipcloud::PickupRequest do
  valid_attributes = {
    carrier: "ups",
    carrier_tracking_no: "723558934169",
  }

  describe "#initialize" do
    it "initializes all attributes correctly" do
      tracker = Shipcloud::Tracker.new(valid_attributes)

      expect(tracker.carrier).to eq "ups"
      expect(tracker.carrier_tracking_no).to eq "723558934169"
    end
  end

  describe ".all" do
    it "makes a new GET request using the correct API endpoint" do
      expect(Shipcloud).to receive(:request).
        with(:get, "trackers", {}, api_key: nil, affiliate_id: nil).
        and_return("trackers" => [])

      Shipcloud::Tracker.all
    end

    it "returns a list of Tracker objects" do
      stub_trackers_requests

      trackers = Shipcloud::Tracker.all

      trackers.each do |tracker|
        expect(tracker).to be_a Shipcloud::Tracker
      end
    end

    it "use the affiliate ID provided for the request" do
      expect(Shipcloud).to receive(:request).
        with(:get, "trackers", {}, api_key: nil, affiliate_id: "affiliate_id").
        and_return("trackers" => [])

      Shipcloud::Tracker.all(affiliate_id: "affiliate_id")
    end
  end

  describe ".create" do
    it "makes a new POST request using the correct API endpoint" do
      expect(Shipcloud).to receive(:request).
        with(:post, "trackers", valid_attributes, api_key: nil, affiliate_id: nil).
        and_return("data" => {})

      Shipcloud::Tracker.create(valid_attributes)
    end

    it "use the affiliate ID provided for the request" do
      expect(Shipcloud).to receive(:request).
        with(:post, "trackers", valid_attributes, api_key: nil, affiliate_id: "affiliate_id").
        and_return("data" => {})

      Shipcloud::Tracker.create(valid_attributes, affiliate_id: "affiliate_id")
    end
  end

  describe ".find" do
    it "makes a new GET request using the correct API endpoint to receive a specific tracker" do
      expect(Shipcloud).to receive(:request).
      with(:get, "trackers/123", {}, api_key: nil, affiliate_id: nil).
      and_return("id" => "123")

      Shipcloud::Tracker.find("123")
    end

    it "use the affiliate ID provided for the request" do
      expect(Shipcloud).to receive(:request).
      with(:get, "trackers/123", {}, api_key: nil, affiliate_id: "affiliate_id").
      and_return("id" => "123")

      Shipcloud::Tracker.find("123", affiliate_id: "affiliate_id")
    end
  end

  def stub_trackers_requests(affiliate_id: nil)
    allow(Shipcloud).to receive(:request).
      with(:get, "trackers", {}, api_key: nil, affiliate_id: affiliate_id).
      and_return("trackers" => trackers_array)
  end

  def trackers_array
    [
      {
        "id" => "4a6922e2-09ad-4724-807c-7b4e572d3c6b",
        "carrier_tracking_no" => "723558934169",
        "status" => "registered",
        "created_at" => "2015-07-21T09:35:23+02:00",
        "to" => {
          "company" => nil,
          "first_name" => "Hans",
          "last_name" => "Meier",
          "care_of" => nil,
          "street" => "Semmelweg",
          "street_no" => "1",
          "zip_code" => "12345",
          "city" => "Hamburg",
          "state" => nil,
          "country" => "DE",
        },
        "tracking_status_updated_at" => nil,
        "last_polling_at" => nil,
        "next_polling_at" => "2015-07-21T09:35:23+02:00",
        "shipment_id" => "123456",
        "carrier" => "ups",
        "tracking_events" => [],
      },
      {
        "id" => "7b4e572d3c6b-4a6922e2-09ad-4724-807c",
        "carrier_tracking_no" => "723558934170",
        "status" => "registered",
        "created_at" => "2015-07-20T09:35:23+02:00",
        "to" => {
          "company" => nil,
          "first_name" => "Rita",
          "last_name" => "Rose",
          "care_of" => nil,
          "street" => "Geranienweg",
          "street_no" => "2",
          "zip_code" => "23456",
          "city" => "Berlin",
          "state" => nil,
          "country" => "DE",
        },
        "tracking_status_updated_at" => nil,
        "last_polling_at" => nil,
        "next_polling_at" => "2015-07-21T09:35:23+02:00",
        "shipment_id" => "654321",
        "carrier" => "dpd",
        "tracking_events" => [],
      },
    ]
  end
end
