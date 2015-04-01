require "spec_helper"

describe Shipcloud::Request::Validator do
  describe "#validated_data_for" do
    it "validates the data" do
      info = Shipcloud::Request::Info.new(:get, "random", OpenStruct.new(id: 1))
      validator = Shipcloud::Request::Validator.new info
      response = OpenStruct.new(body: '{"response":"ok"}', code: 200)

      validator.validated_data_for(response).should eq "response" => "ok"
    end

    it 'raises an APIError if the response contains errors' do
      info = Shipcloud::Request::Info.new(:get, 'random', {})
      validator = Shipcloud::Request::Validator.new info
      response = OpenStruct.new(body: '{"errors":["some error"]}', code: 200)

      expect { validator.validated_data_for(response) }.to raise_error(
        Shipcloud::APIError,
        ['some error'].to_s
      )
    end
  end
end
