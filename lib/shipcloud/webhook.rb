module Shipcloud
  class Webhook < Base
    include Shipcloud::Operations::All

    attr_reader :url, :event_types
  end
end
