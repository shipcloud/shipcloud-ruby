# frozen_string_literal: true

module Shipcloud
  class Carrier < Base
    include Shipcloud::Operations::All

    attr_reader :name, :display_name, :services
  end
end
