# frozen_string_literal: true
require "spec_helper"

describe Shipcloud::Request::Connection do
  describe "#setup_https" do
    it "creates a https object" do
      connection = Shipcloud::Request::Connection.new(nil)

      connection.setup_https

      expect(connection.https).to_not be_nil
    end
  end

  describe "#request" do
    it "performs the actual request" do
      connection = Shipcloud::Request::Connection.new(nil)
      connection.setup_https
      allow(connection).to receive(:https_request)

      expect(connection.https).to receive(:request)

      connection.request
    end
  end
end
