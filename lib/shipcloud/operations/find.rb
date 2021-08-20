# frozen_string_literal: true

module Shipcloud
  module Operations
    module Find
      module ClassMethods
        # Finds a given object
        #
        # @param [String] id The id of the object that should be found
        # @param \[String\] optional api_key The api key. If no api key is given, Shipcloud.api_key
        # will be used for the request
        # @return [Shipcloud::Base] The found object
        def find(id, api_key: nil, affiliate_id: nil)
          response = Shipcloud.request(
            :get,
            "#{base_url}/#{id}",
            {},
            api_key: api_key,
            affiliate_id: affiliate_id,
          )
          new(response)
        end
      end

      def self.included(base)
        base.extend(ClassMethods)
      end
    end
  end
end
