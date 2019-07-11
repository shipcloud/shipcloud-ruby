require 'spec_helper'

describe Shipcloud::Shipment do
  let(:valid_attributes) do
    {
      to: {
        company: 'shipcloud GmbH',
        first_name:   'Max',
        last_name: 'Mustermann',
        street: 'Musterallee',
        street_no: '43',
        city: 'Berlin',
        zip_code: '10000',
      },
      carrier: 'dhl',
      package: {
        weight: 2.5,
        length: 40,
        width: 20,
        height: 20
      },
      metadata: {
        product: {
          name: "foo"
        },
        category: {
          id: "123456",
          name: "bar"
        }
      },
      customs_declaration: {
        id: "123456",
        contents_type: "commercial_goods",
      },
    }
  end

  let(:shipment) {
    Shipcloud::Shipment.new(valid_attributes)
  }

  describe "#initialize" do
    it "initializes all attributes correctly" do
      expect(shipment.to[:company]).to eq 'shipcloud GmbH'
      expect(shipment.to[:first_name]).to eq 'Max'
      expect(shipment.to[:last_name]).to eq 'Mustermann'
      expect(shipment.to[:street]).to eq 'Musterallee'
      expect(shipment.to[:street_no]).to eq '43'
      expect(shipment.to[:city]).to eq 'Berlin'
      expect(shipment.to[:zip_code]).to eq '10000'

      expect(shipment.carrier).to eq 'dhl'

      expect(shipment.package[:weight]).to eq 2.5
      expect(shipment.package[:length]).to eq 40
      expect(shipment.package[:width]).to eq 20
      expect(shipment.package[:height]).to eq 20

      expect(shipment.customs_declaration[:id]).to eq "123456"
      expect(shipment.customs_declaration[:contents_type]).to eq "commercial_goods"
    end

    it "initializes the metadata correctly" do
      metadata = {
        category: {
          id: "123456",
          name: "bar"
        },
        product: {
          name: "foo"
        }
      }

      expect(shipment.metadata).to eq metadata
    end
  end

  describe ".create" do
    it "makes a new POST request using the correct API endpoint" do
      expect(Shipcloud).to receive(:request).
        with(:post, "shipments", valid_attributes, api_key: nil, affiliate_id: nil).and_return("data" => {})
      Shipcloud::Shipment.create(valid_attributes)
    end

    it "use the affiliate ID provided for the request" do
      expect(Shipcloud).to receive(:request).
        with(:post, "shipments", valid_attributes, api_key: nil, affiliate_id: "affiliate_id").and_return("data" => {})
      Shipcloud::Shipment.create(valid_attributes, affiliate_id: "affiliate_id")
    end
  end

  describe ".find" do
    it "makes a new GET request using the correct API endpoint to receive a specific subscription" do
      expect(Shipcloud).to receive(:request).with(:get, "shipments/123", {}, api_key: nil, affiliate_id: nil).
        and_return("id" => "123")
      Shipcloud::Shipment.find("123")
    end

    it "use the affiliate ID provided for the request" do
      expect(Shipcloud).to receive(:request).with(
        :get, "shipments/123", {}, api_key: nil, affiliate_id: "affiliate_id",
      ).and_return("id" => "123")
      Shipcloud::Shipment.find("123", affiliate_id: "affiliate_id")
    end
  end

  describe ".update" do
    it "makes a new PUT request using the correct API endpoint" do
      expect(Shipcloud).to receive(:request).
        with(:put, "shipments/123", { carrier: "ups" }, api_key: nil, affiliate_id: nil).and_return("data" => {})
      Shipcloud::Shipment.update("123", carrier: "ups")
    end

    it "use the affiliate ID provided for the request" do
      expect(Shipcloud).to receive(:request).
        with(
          :put, "shipments/123", { carrier: "ups" }, api_key: nil, affiliate_id: "affiliate_id",
        ).and_return("data" => {})
      Shipcloud::Shipment.update("123", { carrier: "ups" }, affiliate_id: "affiliate_id")
    end
  end

  describe ".delete" do
    it "makes a new DELETE request using the correct API endpoint" do
      expect(Shipcloud).to receive(:request).with(:delete, "shipments/123", {}, api_key: nil, affiliate_id: nil).
        and_return(true)
      Shipcloud::Shipment.delete("123")
    end

    it "doesn't raise an error" do
      stub_request(:delete, "https://api.shipcloud.io/v1/shipments/123").
        to_return(status: 204, body: "")

      expect { Shipcloud::Shipment.delete("123", api_key: "your-api-key") }.
        to_not raise_error
    end

    it "use the affiliate ID provided for the request" do
      expect(Shipcloud).to receive(:request).with(
        :delete, "shipments/123", {}, api_key: nil, affiliate_id: "affiliate_id",
      ).and_return(true)
      Shipcloud::Shipment.delete("123", affiliate_id: "affiliate_id")
    end
  end

  describe ".all" do
    it "makes a new Get request using the correct API endpoint" do
      expect(Shipcloud).to receive(:request).
        with(:get, "shipments", {}, api_key: nil, affiliate_id: nil).
        and_return("shipments" => [])

      Shipcloud::Shipment.all
    end

    it "returns a list of Shipment objects" do
      stub_shipments_requests

      shipments = Shipcloud::Shipment.all

      shipments.each do |shipment|
        expect(shipment).to be_a Shipcloud::Shipment
      end
    end

    it "returns a filtered list of Shipment objects when using filter parameters" do
      filter = {
        "carrier" => "dhl",
        "service" => "returns",
        "reference_number" => "ref123456",
        "carrier_tracking_no" => "43128000105",
        "tracking_status" => "out_for_delivery",
        "page" => 2,
        "per_page" => 25,
      }

      expect(Shipcloud).to receive(:request).
        with(:get, "shipments", filter, api_key: nil, affiliate_id: nil).
        and_return("shipments" => shipments_array)

      Shipcloud::Shipment.all(filter, api_key: nil)
    end

    it "use the affiliate ID provided for the request" do
      expect(Shipcloud).to receive(:request).
        with(:get, "shipments", {}, api_key: nil, affiliate_id: "affiliate_id").
        and_return("shipments" => [])

      Shipcloud::Shipment.all(affiliate_id: "affiliate_id")
    end
  end

  def stub_shipments_requests(affiliate_id: nil)
    allow(Shipcloud).to receive(:request).
      with(:get, "shipments", {}, api_key: nil, affiliate_id: affiliate_id).
      and_return("shipments" => shipments_array)
  end

  def shipments_array
    [
      { "id" => "86afb143f9c9c0cfd4eb7a7c26a5c616585a6271",
        "carrier_tracking_no" => "43128000105",
        "carrier" => "hermes",
        "service" => "standard",
        "created_at" => "2014-11-12T14:03:45+01:00",
        "price" => 3.5,
        "tracking_url" => "http://track.shipcloud.dev/de/86afb143f9",
        "to" => {
          "first_name" => "Hans",
          "last_name" => "Meier",
          "street" => "Semmelweg",
          "street_no" => "1",
          "zip_code" => "12345",
          "city" => "Hamburg",
          "country" => "DE"
        },
        "from" => {
          "company" => "webionate GmbH",
          "last_name" => "Fahlbusch",
          "street" => "Lüdmoor",
          "street_no" => "35a",
          "zip_code" => "22175",
          "city" => "Hamburg",
          "country" => "DE"
        },
        "packages" => {
          "id" => "be81573799958587ae891b983aabf9c4089fc462",
          "length" => 10.0,
          "width" => 10.0,
          "height" => 10.0,
          "weight" => 1.5
        }
      },
      { "id" => "be81573799958587ae891b983aabf9c4089fc462",
        "carrier_tracking_no" => "1Z12345E1305277940",
        "carrier" => "ups",
        "service" => "standard",
        "created_at" => "2014-11-12T14:03:45+01:00",
        "price" => 3.0,
        "tracking_url" => "http://track.shipcloud.dev/de/be598a2fd2",
        "to" => {
          "first_name" => "Test",
          "last_name" => "Kunde",
          "street" => "Gluckstr.",
          "street_no" => "57",
          "zip_code" => "22081",
          "city" => "Hamburg",
          "country" => "DE"
        },
        "from" => {
          "company" => "webionate GmbH",
          "last_name" => "Fahlbusch",
          "street" => "Lüdmoor",
          "street_no" => "35a",
          "zip_code" => "22175",
          "city" => "Hamburg",
          "country" => "DE"
        },
        "packages" => {
          "id" => "74d4f1fc193d8a7ca542d1ee4e2021f3ddb82242",
          "length" => 15.0,
          "width" => 20.0,
          "height" => 10.0,
          "weight" => 2.0
        }
      }
    ]
  end
end
