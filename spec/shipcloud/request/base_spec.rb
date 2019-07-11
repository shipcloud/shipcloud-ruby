require "spec_helper"

describe Shipcloud::Request::Base do
  context "#perform" do
    it "checks for an api key" do
      info = Shipcloud::Request::Info.new(:get, "shipments", nil, {})

      expect{
        Shipcloud::Request::Base.new(info, "affiliate_id").perform
      }.to raise_error Shipcloud::AuthenticationError
    end

    it "performs an https request and returns a response hash" do
      connection = double
      expect(Shipcloud::Request::Connection).to receive(:new).and_return(connection)
      expect(connection).to receive(:setup_https)
      response = double(code: "200", body: { id: 1 }.to_json)
      expect(connection).to receive(:request).and_return(response)
      info = Shipcloud::Request::Info.new(:get, "shipments", "api_key", {})

      data = Shipcloud::Request::Base.new(info, "affiliate_id").perform

      expect(data).to eq("id" => 1)
    end

    it "performs an https request and raises an Shipcloud::ClientError if the response "\
       "has a 400 status code" do
      connection = double
      expect(Shipcloud::Request::Connection).to receive(:new).and_return(connection)
      expect(connection).to receive(:setup_https)
      response = double(code: "400", body: { id: 1 }.to_json)
      expect(connection).to receive(:request).and_return(response)
      info = Shipcloud::Request::Info.new(:get, "shipments", "api_key", {})

      expect { Shipcloud::Request::Base.new(info, "affiliate_id").perform }.to raise_error(Shipcloud::ClientError)
    end

    it "performs an https request and raises an Shipcloud::ServerError if the response "\
       "has a 500 status code" do
      connection = double
      expect(Shipcloud::Request::Connection).to receive(:new).and_return(connection)
      expect(connection).to receive(:setup_https)
      response = double(code: "500", body: { id: 1 }.to_json)
      expect(connection).to receive(:request).and_return(response)
      info = Shipcloud::Request::Info.new(:get, "shipments", "api_key", {})

      expect { Shipcloud::Request::Base.new(info, "affiliate_id").perform }.
        to raise_error(Shipcloud::ServerError)
    end

    it "performs an https request and raises an Shipcloud::ShipcloudError if the body of the "\
       "response is not in JSON" do
      connection = double
      expect(Shipcloud::Request::Connection).to receive(:new).and_return(connection)
      expect(connection).to receive(:setup_https)
      response = double(code: "200", body: "no json")
      expect(connection).to receive(:request).and_return(response)
      info = Shipcloud::Request::Info.new(:get, "shipments", "api_key", {})

      expect { Shipcloud::Request::Base.new(info, "affiliate_id").perform }.
        to raise_error(Shipcloud::ShipcloudError)
    end
  end
end
