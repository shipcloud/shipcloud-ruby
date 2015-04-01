$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), "..", "lib"))
require 'shipcloud'
require 'rspec'
require "webmock/rspec"
require "pry"

RSpec.configure do |config|
  config.after(:each) do
    Shipcloud.api_key = nil
  end
end
