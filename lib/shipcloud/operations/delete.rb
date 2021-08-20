# frozen_string_literal: true

module Shipcloud
  module Operations
    module Delete
      module ClassMethods
        # Deletes the given object
        #
        # @param [String] id The id of the object that gets deleted
        # @param \[String\] optional api_key The api key. If no api key is given, Shipcloud.api_key
        # will be used for the request
        def delete(id, api_key: nil, affiliate_id: nil)
          Shipcloud.request(
            :delete,
            "#{base_url}/#{id}",
            {},
            api_key: api_key,
            affiliate_id: affiliate_id,
          )
          true
        end
      end

      def self.included(base)
        base.extend(ClassMethods)
      end
    end
  end
end
