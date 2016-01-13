require "spec_helper"

describe Shipcloud::Request::Base do
  context "#perform" do
    it "checks for an api key" do
      info = Shipcloud::Request::Info.new(:get, "shipments", nil, {})

      expect{
        Shipcloud::Request::Base.new(info).perform
      }.to raise_error Shipcloud::AuthenticationError
    end

    it "performs an https request" do
      info = Shipcloud::Request::Info.new(:get, "shipments", "api_key", {})
      connection = double
      validator = double
      allow(Shipcloud::Request::Connection).to receive(:new).with(info).and_return(connection)
      allow(Shipcloud::Request::Validator).to receive(:new).with(info).and_return(validator)

      expect(connection).to receive(:setup_https)
      response = double
      expect(connection).to receive(:request).and_return(response)
      expect(validator).to receive(:validated_data_for).with(response)

      Shipcloud::Request::Base.new(info).perform
    end
  end
end
