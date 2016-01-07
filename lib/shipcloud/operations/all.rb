module Shipcloud
  module Operations
    module All
      module ClassMethods
        # Loads all Objects of the resource
        def all(filter = {})
          response = Shipcloud.request(:get, base_url, filter)
          if index_response_root
            response = response.fetch(index_response_root, [])
          end
          response.map { |hash| new(hash) }
        end
      end

      def self.included(base)
        base.extend(ClassMethods)
      end
    end
  end
end
