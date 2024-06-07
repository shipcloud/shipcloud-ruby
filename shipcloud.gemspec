# coding: utf-8
# frozen_string_literal: true

lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "shipcloud/version"

Gem::Specification.new do |spec|
  spec.name          = "shipcloud"
  spec.version       = Shipcloud::VERSION
  spec.authors       = ["sthollmann"]
  spec.email         = ["stefan@shipcloud.io"]
  spec.summary       = "A wrapper for the shipcloud API"
  spec.description   = "A wrapper for the shipcloud API. " \
    "Fore more details visit https://developers.shipcloud.io/"
  spec.homepage      = "https://github.com/shipcloud/shipcloud-ruby"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.required_ruby_version = ">= 2.6"

  spec.add_runtime_dependency "json", ">= 1.8.0"
  spec.add_development_dependency "pry", "~> 0.10"
  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "rspec", "~> 3.6"
  spec.add_development_dependency "rubocop", "~> 1.64.1"
  spec.add_development_dependency "rubocop-performance", "~> 1.7.0"
  spec.add_development_dependency "simplecov", "~> 0.21.0"
  spec.add_development_dependency "webmock", "~> 3.0"
end
