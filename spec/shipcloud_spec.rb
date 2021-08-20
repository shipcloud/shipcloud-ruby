# frozen_string_literal: true
require "spec_helper"

describe Shipcloud do
  describe ".request" do
    context "given no api key exists" do
      it "raises an authentication error" do
        expect do
          Shipcloud.request(:get, "clients", {})
        end.to raise_error(Shipcloud::AuthenticationError)
      end
    end

    context "with an invalid api key" do
      before(:each) do
        WebMock.stub_request(:any, /#{Shipcloud.configuration.api_base}/).to_return(body: "{}")
        Shipcloud.api_key = "your-api-key"
      end

      it "attempts to get a url with one param" do
        Shipcloud.request(:get, "transactions", { param_name: "param_value" })

        expect(WebMock).to have_requested(:get, "#{api_url}/transactions?param_name=param_value")
      end

      it "attempts to get a url with more than one param" do
        Shipcloud.request(:get, "transactions", { client: "client_id", order: "created_at_desc" })

        expect(WebMock).
          to have_requested(:get, "#{api_url}/transactions?client=client_id&order=created_at_desc")
      end

      it "doesn't add a question mark if no params" do
        Shipcloud.request(:get, "transactions", {})
        expect(WebMock).to have_requested(:get, "#{api_url}/transactions")
      end
    end

    context "with an api key passed in as an argument" do
      it "uses the given api key instead of the global one" do
        WebMock.stub_request(:any, /#{Shipcloud.configuration.api_base}/).to_return(body: "{}")
        Shipcloud.api_key = "global-api-key"

        Shipcloud.request(:get, "transactions", {}, api_key: "123")

        expect(WebMock).to have_requested(
          :get,
          "#{api_url}/transactions",
        ).with(
          headers: {
            "Authorization" => "Basic #{Base64.strict_encode64('123:').chomp}",
          },
        )
      end
    end
  end

  describe ".configure" do
    before :each do
      Shipcloud.configuration = nil
    end

    it "defaults api_key to nil" do
      expect(Shipcloud.configuration.api_key).to be_nil
    end

    it "sets the api_key" do
      Shipcloud.configure do |config|
        config.api_key = "your-api-key"
      end
      expect(Shipcloud.configuration.api_key).to eq "your-api-key"
    end

    it "gets the api key, set as a class variable (DEPRECATED)" do
      Shipcloud.api_key = "old-school-api-key"
      expect(Shipcloud.api_key).to eq "old-school-api-key"
      expect(Shipcloud.configuration.api_key).to eq "old-school-api-key"
    end

    it "defaults api_base to 'api.shipcloud.io'" do
      expect(Shipcloud.configuration.api_base).to eq "api.shipcloud.io"
    end

    it "overwrites the default api base" do
      Shipcloud.configure do |config|
        config.api_base = "api.shipcloud.dev"
      end
      expect(Shipcloud.configuration.api_base).to eq "api.shipcloud.dev"
    end

    it "defaults use_ssl to true" do
      expect(Shipcloud.configuration.use_ssl).to be true
    end

    it "overwrites the default ssl mode" do
      Shipcloud.configure do |config|
        config.use_ssl = false
      end
      expect(Shipcloud.configuration.use_ssl).to be false
    end

    it "defaults debug to false" do
      expect(Shipcloud.configuration.debug).to be false
    end

    it "overwrites the default debug mode" do
      Shipcloud.configure do |config|
        config.debug = true
      end
      expect(Shipcloud.configuration.debug).to be true
    end

    it "defaults affiliate_id to nil" do
      expect(Shipcloud.configuration.affiliate_id).to be_nil
    end

    it "sets and gets the affiliate_id" do
      Shipcloud.configure do |config|
        config.affiliate_id = "integration.my_rails_app.1234567"
      end

      expect(Shipcloud.configuration.affiliate_id).to eq "integration.my_rails_app.1234567"
    end
  end

  describe ".api_headers" do
    it "returns the correct api headers with default affiliate id" do
      Shipcloud.configuration = nil # reset configuration

      expect(Shipcloud.api_headers).to eq(
        "Content-Type" => "application/json",
        "User-Agent" => "shipcloud-ruby v#{Shipcloud::VERSION}, API #{Shipcloud::API_VERSION}, " \
          "#{RUBY_VERSION}, #{RUBY_PLATFORM}, #{RUBY_PATCHLEVEL}",
        "Affiliate-ID" => "integration.shipcloud-ruby-gem.v#{Shipcloud::VERSION}",
      )
    end

    it "returns the correct api headers with affiliate id if configured" do
      Shipcloud.configure do |config|
        config.affiliate_id = "integration.my_rails_app.1234567"
      end
      expect(Shipcloud.api_headers).to eq(
        "Content-Type" => "application/json",
        "User-Agent" => "shipcloud-ruby v#{Shipcloud::VERSION}, API #{Shipcloud::API_VERSION}, " \
          "#{RUBY_VERSION}, #{RUBY_PLATFORM}, #{RUBY_PATCHLEVEL}",
        "Affiliate-ID" => "integration.my_rails_app.1234567",
      )
    end
  end

  def api_url
    "https://#{Shipcloud.configuration.api_base}/#{Shipcloud::API_VERSION}"
  end
end
