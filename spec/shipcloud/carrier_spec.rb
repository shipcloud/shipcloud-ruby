require 'spec_helper'

describe Shipcloud::Carrier do
  describe '#initialize' do
    it 'initializes all attributes correctly' do
      valid_attributes = { name: 'bogus', display_name: 'Bogus Carrier' }
      carrier = Shipcloud::Carrier.new(valid_attributes)

      expect(carrier.name).to eq 'bogus'
      expect(carrier.display_name).to eq 'Bogus Carrier'
    end
  end

  describe '.all' do
    it 'makes a new Get request using the correct API endpoint' do
      expect(Shipcloud).to receive(:request).
        with(:get, 'carriers', {}).and_return([])

      Shipcloud::Carrier.all
    end

    it 'returns a list of Carrier objects' do
      stub_carriers_request

      carriers = Shipcloud::Carrier.all

      carriers.each do |carrier|
        expect(carrier).to be_a Shipcloud::Carrier
      end
    end

    it 'initializes the Carrier objects correctly' do
      stub_carriers_request
      allow(Shipcloud::Carrier).to receive(:new)

      carriers = Shipcloud::Carrier.all

      expect(Shipcloud::Carrier).to have_received(:new).
        with({ 'name' => 'carrier_1', 'display_name' => 'Carrier 1' })
      expect(Shipcloud::Carrier).to have_received(:new).
        with({ 'name' => 'carrier_2', 'display_name' => 'Carrier 2' })
    end
  end

  def stub_carriers_request
    allow(Shipcloud).to receive(:request).
      with(:get, 'carriers', {}).
      and_return(
        [
          { 'name' => 'carrier_1', 'display_name' => 'Carrier 1' },
          { 'name' => 'carrier_2', 'display_name' => 'Carrier 2' },
        ]
      )
  end
end
