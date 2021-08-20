# frozen_string_literal: true

module Shipcloud
  class Webhook < Base
    include Shipcloud::Operations::All
    include Shipcloud::Operations::Delete

    attr_reader :id, :url, :event_types, :deactivated

    def self.index_response_root
      "webhooks"
    end
  end
end
