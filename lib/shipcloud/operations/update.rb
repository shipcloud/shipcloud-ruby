module Shipcloud
  module Operations
    module Update

      module ClassMethods
        # Updates a object
        # @param [String] id The id of the object that should be updated
        # @param [Hash] attributes The attributes that should be updated
        def update(id, attributes)
          response = Shipcloud.request(:put, "#{base_url}/#{id}", attributes)
          self.new(response)
        end
      end

      def self.included(base)
        base.extend(ClassMethods)
      end

      # Updates a object
      #
      # @param [Hash] attributes The attributes that should be updated
      def update(attributes)
        response = Shipcloud.request(:put, "#{base_url}/#{id}", attributes)
        set_attributes(response)
      end
    end
  end
end
