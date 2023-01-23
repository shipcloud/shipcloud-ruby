# frozen_string_literal: true
require "spec_helper"

describe Shipcloud::Operations::Nested do
  describe "#all" do
    it "executes a correct GET request to the nested resource's index route" do
      allow(Shipcloud).to receive(:request).and_return([])
      build_params = { foo: "bar" }
      nested_operation = described_class.new(
        nested_class, "parent/parent-id/nested", build_params
      )

      nested_operation.all({ filter_param: :foo }, api_key: "api-key", affiliate_id: "affiliate-id")

      expect(Shipcloud).to have_received(:request).with(
        :get,
        "parent/parent-id/nested",
        { filter_param: :foo },
        api_key: "api-key",
        affiliate_id: "affiliate-id",
      )
    end

    it "builds a ruby object for each nested resource, applying build params" do
      allow(Shipcloud).to receive(:request).and_return([{ id: "nested-resource-id" }])
      build_params = { foo: "bar" }
      nested_operation = described_class.new(
        nested_class, "parent/parent-id/nested", build_params
      )

      nested_resources = nested_operation.all

      expect(nested_resources.length).to eq 1
      expect(nested_resources.first.attributes).to eq(id: "nested-resource-id", foo: "bar")
    end
  end

  describe "#find" do
    it "executes a correct GET request to the nested resource's show route" do
      allow(Shipcloud).to receive(:request).and_return(id: "nested-resource-id")
      build_params = { foo: "bar" }
      nested_operation = described_class.new(
        nested_class, "parent/parent-id/nested", build_params
      )

      nested_operation.find("nested-resource-id", api_key: "api-key", affiliate_id: "affiliate-id")

      expect(Shipcloud).to have_received(:request).with(
        :get,
        "parent/parent-id/nested/nested-resource-id",
        {},
        api_key: "api-key",
        affiliate_id: "affiliate-id",
      )
    end

    it "builds a ruby object for the nested resource, applying build params" do
      allow(Shipcloud).to receive(:request).and_return(id: "nested-resource-id")
      build_params = { foo: "bar" }
      nested_operation = described_class.new(
        nested_class, "parent/parent-id/nested", build_params
      )

      nested_resource = nested_operation.find("nested-resource-id")

      expect(nested_resource.attributes).to eq(id: "nested-resource-id", foo: "bar")
    end
  end

  describe "#create" do
    it "executes a correct POST request to the nested resource's route" do
      allow(Shipcloud).to receive(:request).and_return(id: "nested-resource-id")
      build_params = { foo: "bar" }
      nested_operation = described_class.new(
        nested_class, "parent/parent-id/nested", build_params
      )
      create_params = { bar: "baz" }

      nested_operation.create(create_params, api_key: "api-key", affiliate_id: "affiliate-id")

      expect(Shipcloud).to have_received(:request).with(
        :post,
        "parent/parent-id/nested",
        { bar: "baz" },
        api_key: "api-key",
        affiliate_id: "affiliate-id",
      )
    end

    it "builds a ruby object for the nested resource, applying build params" do
      allow(Shipcloud).to receive(:request).and_return({ id: "nested-resource-id", bar: "baz" })
      build_params = { foo: "bar" }
      nested_operation = described_class.new(
        nested_class, "parent/parent-id/nested", build_params
      )
      create_params = { bar: "baz" }

      nested_resource = nested_operation.create(create_params)

      expect(nested_resource.attributes).to eq(id: "nested-resource-id", foo: "bar", bar: "baz")
    end
  end

  def nested_class
    Class.new do
      attr_reader :attributes

      def initialize(attributes)
        @attributes = attributes
      end
    end
  end
end
