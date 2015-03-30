module Shipcloud
  class Carrier < Base
    include Shipcloud::Operations::All

    attr_reader :name, :display_name
  end
end

