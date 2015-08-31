module Shipcloud
  module Operations
    module Find
      module ClassMethods
        # Finds a given object
        #
        # @param [String] id The id of the object that should be found
        # @return [Shipcloud::Base] The found object
        def find(id)
          response = Shipcloud.request(:get, "#{base_url}/#{id}", {})
          self.new(response)
        end
      end

      def self.included(base)
        base.extend(ClassMethods)
      end
    end
  end
end
