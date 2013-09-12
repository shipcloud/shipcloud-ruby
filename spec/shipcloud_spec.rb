require "spec_helper"

describe Shipcloud do
  describe ".request" do
    context "given no api key exists" do
      it "raises an authentication error" do
        expect { Shipcloud.request(:get, "clients", {}) }.to raise_error(Shipcloud::AuthenticationError)
      end
    end

    context "with an invalid api key" do
      before(:each) do
        WebMock.stub_request(:any, /#{Shipcloud.configuration.api_base}/).to_return(:body => "{}")
        Shipcloud.api_key = "your-api-key"
      end

      it "attempts to get a url with one param" do
        Shipcloud.request(:get, "transactions", { param_name: "param_value" })
        WebMock.should have_requested(:get, "https://#{Shipcloud::api_key}:@#{Shipcloud.configuration.api_base}/#{Shipcloud::API_VERSION}/transactions?param_name=param_value")
      end

      it "attempts to get a url with more than one param" do
        Shipcloud.request(:get, "transactions", { client: "client_id", order: "created_at_desc" })
        WebMock.should have_requested(:get, "https://#{Shipcloud::api_key}:@#{Shipcloud.configuration.api_base}/#{Shipcloud::API_VERSION}/transactions?client=client_id&order=created_at_desc")
      end

      it "doesn't add a question mark if no params" do
        Shipcloud.request(:get, "transactions", {})
        WebMock.should have_requested(:get, "https://#{Shipcloud::api_key}:@#{Shipcloud.configuration.api_base}/#{Shipcloud::API_VERSION}/transactions")
      end
    end
  end

  describe '.configure' do
    before :each do
      Shipcloud.configuration = nil
    end

    it 'defaults api_key to nil' do
      expect(Shipcloud.configuration.api_key).to be_nil
    end

    it 'sets the api_key' do
      Shipcloud.configure do |config|
        config.api_key = 'your-api-key'
      end
      expect(Shipcloud.configuration.api_key).to eq 'your-api-key'
    end

    it 'gets the api key, set as a class variable (DEPRECATED)' do
      Shipcloud.api_key = 'old-school-api-key'
      expect(Shipcloud.api_key).to eq 'old-school-api-key'
      expect(Shipcloud.configuration.api_key).to eq 'old-school-api-key'
    end

    it "defaults api_base to 'api.shipcloud.io'" do
      expect(Shipcloud.configuration.api_base).to eq 'api.shipcloud.io'
    end

    it 'overwrites the default api base' do
      Shipcloud.configure do |config|
        config.api_base = 'api.shipcloud.dev'
      end
      expect(Shipcloud.configuration.api_base).to eq 'api.shipcloud.dev'
    end

    it 'defaults use_ssl to true' do
      expect(Shipcloud.configuration.use_ssl).to be_true
    end

    it 'overwrites the default ssl mode' do
      Shipcloud.configure do |config|
        config.use_ssl = false
      end
      expect(Shipcloud.configuration.use_ssl).to be_false
    end
  end
end
