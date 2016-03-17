require "spec_helper"

describe Shipcloud::PickupRequest do
  valid_attributes = {
    carrier: "dpd",
    pickup_time: {
      earliest: "2015-09-15T09:00:00+02:00",
      latest: "2015-09-15T18:00:00+02:00"
    },
    shipments: [
      {
        id: "3a186c51d4281acbecf5ed38805b1db92a9d668b"
      }
    ]
  }

  describe "#initialize" do
    it "initializes all attributes correctly" do
      pickup_request = Shipcloud::PickupRequest.new(valid_attributes)

      expect(pickup_request.carrier).to eq "dpd"
      expect(pickup_request.pickup_time[:earliest]).to eq "2015-09-15T09:00:00+02:00"
      expect(pickup_request.pickup_time[:latest]).to eq "2015-09-15T18:00:00+02:00"
      expect(pickup_request.shipments.first[:id]).to eq "3a186c51d4281acbecf5ed38805b1db92a9d668b"
    end
  end

  describe ".create" do
    it "makes a new POST request using the correct API endpoints" do
      expect(Shipcloud).to receive(:request).
        with(:post, "pickup_requests", valid_attributes, api_key: nil).
        and_return("data" => {})

      Shipcloud::PickupRequest.create(valid_attributes)
    end

    it "initializes a PickupRequest with id, carrier and pickup_time" do
      allow(Shipcloud).to receive(:request).
        and_return(
          "id": "123456",
          "carrier": "dpd",
          "pickup_time": {
            "earliest": "2015-09-15T09:00:00+02:00",
            "latest": "2015-09-15T18:00:00+02:00"
          }
        )

      pickup_request = Shipcloud::PickupRequest.create(valid_attributes)

      expect(pickup_request.carrier).to eq "dpd"
      expect(pickup_request.pickup_time[:earliest]).to eq "2015-09-15T09:00:00+02:00"
      expect(pickup_request.pickup_time[:latest]).to eq "2015-09-15T18:00:00+02:00"
    end
  end
end
