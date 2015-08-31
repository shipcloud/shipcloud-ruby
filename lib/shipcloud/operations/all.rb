module Shipcloud
  module Operations
    module All
      module ClassMethods
        # Loads all Objects of the resource
        def all
          response = Shipcloud.request(:get, base_url, {})
          response.map {|hash| self.new(hash) }
        end
      end

      def self.included(base)
        base.extend(ClassMethods)
      end
    end
  end
end
