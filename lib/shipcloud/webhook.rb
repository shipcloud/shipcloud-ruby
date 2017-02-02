module Shipcloud
  class Webhook < Base
    include Shipcloud::Operations::All
    include Shipcloud::Operations::Delete

    attr_reader :url, :event_types

    def self.index_response_root
      "webhooks"
    end
  end
end
