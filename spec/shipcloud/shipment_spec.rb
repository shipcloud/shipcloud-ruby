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
      }
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
    end
  end

  describe ".create" do
    it "makes a new POST request using the correct API endpoint" do
      Shipcloud.should_receive(:request).with(:post, "shipments", valid_attributes).and_return("data" => {})
      Shipcloud::Shipment.create(valid_attributes)
    end
  end
end
