# frozen_string_literal: true
require "spec_helper"

describe Shipcloud::Request::Info do
  describe "#url" do
    it "returns the correct url" do
      info = Shipcloud::Request::Info.new(:get, "shipments", "api_key", {})

      expect(info.url).to eq "/v1/shipments"
    end
  end

  describe "#path_with_params" do
    it "returns just the path if there aren't any params" do
      info = Shipcloud::Request::Info.new(:get, "shipments", "api_key", {})
      path = info.path_with_params(info.url, info.data)

      expect(path).to eq "/v1/shipments"
    end

    it "returns the path and given params" do
      info = Shipcloud::Request::Info.new(:get, "shipments", "api_key", foo: "bar")
      path = info.path_with_params(info.url, info.data)

      expect(path).to eq "/v1/shipments?foo=bar"
    end
  end
end
