# frozen_string_literal: true

module Shipcloud
  class Tracker < Base
    include Shipcloud::Operations::All

    attr_accessor :carrier, :carrier_tracking_no
    attr_reader :id

    def self.index_response_root
      "#{class_name.downcase}s"
    end
  end
end
