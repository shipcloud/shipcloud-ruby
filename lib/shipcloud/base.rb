# frozen_string_literal: true

module Shipcloud
  class Base
    include Shipcloud::Operations::Create
    include Shipcloud::Operations::Find

    # Initializes an object using the given attributes
    #
    # @param [Hash] attributes The attributes to use for initialization
    def initialize(attributes = {})
      set_attributes(attributes)
    end

    # Sets the attributes
    #
    # @param [Hash] attributes The attributes to initialize
    def set_attributes(attributes)
      attributes.each_pair do |key, value|
        instance_variable_set("@#{key}", value)
      end
    end

    def self.camel_to_snakecase(string)
      string.gsub(/::/, "/").
        gsub(/([A-Z]+)([A-Z][a-z])/, '\1_\2').
        gsub(/([a-z\d])([A-Z])/, '\1_\2').
        tr("-", "_").
        downcase
    end

    def self.class_name
      name.split("::").last
    end

    def self.base_url
      "#{class_name.downcase}s"
    end

    def self.create_response_root; end

    def self.index_response_root; end
  end
end
