# frozen_string_literal: true
require "spec_helper"

describe Shipcloud::ShipcloudError do
  describe ".from_response" do
    context "with a response with status code 400" do
      it "returns a Shipcloud::InvalidRequestError" do
        expect(Shipcloud::ShipcloudError.from_response(build_response(status_code: 400))).to be_a(
          Shipcloud::InvalidRequestError,
        )
      end
    end

    context "with a response with status code 422" do
      it "returns a Shipcloud::InvalidRequestError" do
        expect(Shipcloud::ShipcloudError.from_response(build_response(status_code: 422))).to be_a(
          Shipcloud::InvalidRequestError,
        )
      end
    end

    context "with a response with status code 401" do
      it "returns a Shipcloud::AuthenticationError" do
        expect(Shipcloud::ShipcloudError.from_response(build_response(status_code: 401))).to be_a(
          Shipcloud::AuthenticationError,
        )
      end
    end

    context "with a response with status code 402" do
      it "returns a Shipcloud::TooManyRequests" do
        expect(Shipcloud::ShipcloudError.from_response(build_response(status_code: 402))).to be_a(
          Shipcloud::TooManyRequests,
        )
      end
    end

    context "with a response with status code 404" do
      it "returns a Shipcloud::NotFoundError" do
        expect(Shipcloud::ShipcloudError.from_response(build_response(status_code: 404))).to be_a(
          Shipcloud::NotFoundError,
        )
      end
    end

    context "with a response with a 4xx status code" do
      it "returns a Shipcloud::ClientError" do
        expect(Shipcloud::ShipcloudError.from_response(build_response(status_code: 400))).to be_a(
          Shipcloud::ClientError,
        )
      end
    end

    context "with a response with a 5xx status code" do
      it "returns a Shipcloud::ClientError" do
        expect(Shipcloud::ShipcloudError.from_response(build_response(status_code: 500))).to be_a(
          Shipcloud::ServerError,
        )
      end
    end

    context "with a 200 response" do
      it "returns nil" do
        expect(Shipcloud::ShipcloudError.from_response(build_response(status_code: 200))).to be_nil
      end
    end
  end

  describe "#message" do
    context "with an errors node in the response body" do
      it "returns the errors formated as one string" do
        errors = ["error 1", "error 2"]
        response = build_response(body: { errors: errors }.to_json)
        error = Shipcloud::ShipcloudError.new(response)

        expect(error.message).to eq '["error 1", "error 2"]'
      end
    end
    context "without an errors node in the response body" do
      it "returns the body of the response" do
        error = Shipcloud::ShipcloudError.new(build_response(body: "test"))

        expect(error.message).to eq "test"
      end
    end
  end

  describe "#errors" do
    it "returns the errors node of the response" do
      errors = ["error 1", "error 2"]
      response = build_response(body: { errors: errors }.to_json)
      error = Shipcloud::ShipcloudError.new(response)

      expect(error.errors).to eq errors
    end
    context "with a response that has no errors node" do
      it "returns an empty list" do
        response = build_response(body: {}.to_json)
        error = Shipcloud::ShipcloudError.new(response)

        expect(error.errors).to eq []
      end
    end
    context "with a response that has no JSON formated body" do
      it "returns an empty list" do
        response = build_response(body: "error")
        error = Shipcloud::ShipcloudError.new(response)

        expect(error.errors).to eq []
      end
    end
  end

  describe "#response" do
    it "returns the response" do
      response = build_response
      error = Shipcloud::ShipcloudError.new(response)

      expect(error.response).to eq response
    end
  end

  def build_response(status_code: 400, body: nil)
    double(code: status_code.to_s, body: body)
  end
end
