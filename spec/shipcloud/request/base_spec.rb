require "spec_helper"

describe Shipcloud::Request::Base do
  context "#perform" do
    it "checks for an api key" do
      Shipcloud.stub(:api_key).and_return(nil)

      expect{
        Shipcloud::Request::Base.new(nil).perform
      }.to raise_error Shipcloud::AuthenticationError
    end

    it "performs an https request" do
      Shipcloud.stub(:api_key).and_return("some key")
      connection = stub
      validator = stub
      Shipcloud::Request::Connection.stub(:new).and_return(connection)
      Shipcloud::Request::Validator.stub(:new).and_return(validator)

      connection.should_receive(:setup_https)
      connection.should_receive(:request)
      validator.should_receive(:validated_data_for)

      Shipcloud::Request::Base.new(nil).perform
    end
  end
end