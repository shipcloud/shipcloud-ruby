module Shipcloud
  class Webhook < Base
    include Shipcloud::Operations::All

    attr_reader :url, :event_types, :deactivated

    def self.index_response_root
      "webhooks"
    end
  end
end
