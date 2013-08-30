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
  end
end