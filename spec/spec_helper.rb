require "codeclimate-test-reporter"
CodeClimate::TestReporter.start

$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), "..", "lib"))
require 'shipcloud'
require 'rspec'
require "webmock/rspec"
require "pry"

WebMock.disable_net_connect!(allow_localhost: true, allow: "codeclimate.com")

RSpec.configure do |config|
  config.after(:each) do
    Shipcloud.api_key = nil
  end
end
