module Shipcloud
  class Address < Base
    include Shipcloud::Operations::Update
    include Shipcloud::Operations::All

    attr_accessor :company, :first_name, :last_name, :care_of, :street,
                  :street_no, :zip_code, :city, :state, :country, :phone

    def self.base_url
      "#{class_name.downcase}es"
    end
  end
end
