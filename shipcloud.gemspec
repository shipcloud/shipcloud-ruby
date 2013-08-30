# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'shipcloud/version'

Gem::Specification.new do |spec|
  spec.name          = "shipcloud"
  spec.version       = Shipcloud::VERSION
  spec.authors       = ["sthollmann"]
  spec.email         = ["stefan@webionate.de"]
  spec.description   = %q{A wrapper for the shipcloud API}
  spec.summary       = %q{A wrapper for the shipcloud API}
  spec.homepage      = "https://github.com/webionate/shipcloud-ruby"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "json"
  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
end
