require "spec_helper"

describe Shipcloud::PickupRequest do
  valid_attributes = {
    carrier: "dpd",
    pickup_time: {
      earliest: "2015-09-15T09:00:00+02:00",
      latest: "2015-09-15T18:00:00+02:00"
    },
    shipments: [
      { id: "abc_123" }
    ]
  }

  describe "#initialize" do
    it "initializes all attributes correctly" do
      pickup_request = Shipcloud::PickupRequest.new(valid_attributes)

      expect(pickup_request.carrier).to eq "dpd"
      expect(pickup_request.pickup_time[:earliest]).to eq "2015-09-15T09:00:00+02:00"
      expect(pickup_request.pickup_time[:latest]).to eq "2015-09-15T18:00:00+02:00"
      expect(pickup_request.shipments).to eq [{ id: "abc_123" }]
    end
  end

  describe ".create" do
    it "makes a new POST request using the correct API endpoint" do
      expect(Shipcloud).to receive(:request).
        with(:post, "pickup_requests", valid_attributes, api_key: nil).
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
            "latest" => "2015-09-15T18:00:00+02:00"
          }
        )

      pickup_request = Shipcloud::PickupRequest.create(valid_attributes)

      expect(pickup_request.id).to eq "123456"
      expect(pickup_request.carrier_pickup_number).to eq "abcdef"
    end
  end
end
