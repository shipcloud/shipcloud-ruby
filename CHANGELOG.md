## [Unreleased]
### Added
- Add attr_accessor for `service` to class `Shipcloud::Shipment` to be able to access the service attribute at the shipment object.

### Changed

### Deprecated

### Removed

### Fixed

### Security

## [0.11.0] - 2020-07-28
### Added
- Support shipments with pickup requests as required for [TNT](https://developers.shipcloud.io/carriers/tnt.html).
- Add attr_accessor for `email` to class `Shipcloud::Address` to be able to access the email attribute at the address object.

### Changed

### Deprecated

### Removed

### Fixed

### Security

## [0.10.0] - 2019-08-07
### Added
- Add the possibility to specify custom affiliate_id on every request

### Removed
- Removed support for ruby < 2.3. Target ruby version is 2.6

## [0.9.0] - 2019-01-09
### Added
- Add attr_reader for `id` to class `Shipcloud::Address` to be able to get the id of a created address
- Add attr_reader for `id` to class `Shipcloud::Webhook` to be able to get the id of a created webhook
- Add attr_reader for `customs_declaration` to class `Shipcloud::Shipment` to be able to get the `customs_declaration` of a created shipment

## [0.8.0] - 2017-07-03
### Added
- Add attribute ```metadata``` to class ```Shipcloud::Shipment``` in order to transmit JSON data (#16).
- Add resource pickup_request in order to submit pickup request to shipcloud
- Add attribute ```pickup_address``` to class ```Shipcloud::PickupRequest``` to submit an alternative address for pickup request to shipcloud
- Add ```delete``` operation for ```webhook``` resource
- Add attribute ```deactivated``` to class ```Shipcloud::Webhook```
- Add ```affiliate_id``` to ```Shipcloud::Configuration``` and submit it (or a default affiliate id) via API headers to shipcloud
- Add class ```Shipcloud::Tracker``` with create, find, and index operations

### Fixed
- Parse response only when it is not empty

## [0.7.0] - 2016-01-21
### Added
- Add the possibility to specify the api key on every request. (#8)
- Add some more specific error classes ```Shipcloud::ClientError```,```Shipcloud::ServerError```,
  ```Shipcloud::InvalidRequestError```, ```Shipcloud::TooManyRequests``` and ```Shipcloud::NotFoundError``` (#11).
- Access to the entire response and error descriptions from the error object (#11).

### Removed
- Removed the following ruby versions from travis-ci test runs:
  - jruby-9.0.0.0
- Removed ```Shipcloud::APIError```  in preference to more granular error classes (#11).

### Changed

### Fixed

## [0.6.0] - 2016-01-21
### Added
- This CHANGELOG file (Following "[Keep a CHANGELOG](http://keepachangelog.com/)")
- Create, find, update and index operations for address resource. (#4)
- Services attribute to carriers call (#5)
- Index operation for shipment resources with optional filter parameters. (#6)
- Create, find and index operations for webhook resource. (#7)
- Added the following ruby versions to travis-ci test runs:
  - 2.1.7
  - 2.2.4
  - 2.3.0
- Add ShipmentQuotes class returning the price for a certain shipment (#9)

### Removed
- Dropped support for ruby 1.9.x in order to use the new language features of ruby 2.x. The official support of ruby 1.9.3 already ended on February 23, 2015 (https://www.ruby-lang.org/en/news/2014/01/10/ruby-1-9-3-will-end-on-2015/)
- Removed the following ruby versions from travis-ci test runs:
  - 2.1.5
  - 2.2.1
  - 2.2.2
  - 2.2.3

### Changed
- Start following [SemVer](http://semver.org) properly.
- The link to the developer documenation for the Shipment ressource still pointed at Apiary; it now correctly points to the shipcloud Developer Portal's API section on Shipments.

## [0.5.0] - 2015-04-02
### Added
- Call to list carriers (from @axelerator - #1)

### Fixed
- Fixed bug in error handling and array responses

## [0.4.0] - 2014-06-27
## Added
- Added a console task to the rakefile to provide an easy accessible
playground for the gem (15c5719)- http://erniemiller.org/2014/02/05/7-lines-every-gems-rakefile-should-have/
- Added debug option to configuration to control debug output (4fd9dc529cb3862c2c7091007f39b54bbc91c14e)

## Changed
- Updated Gemfile and shipcloud.gemspec
  - bundler version 1.6.0
  - rake version ~> 10.3.0
  - rspec version ~> 2.99.0'
  - webmock version ~> 1.18.0
  - pry version ~> 0.10.0

## [0.3.0] - 2013-09-12
## Added
- Added shipment usage info to Readme
- Added DELETE request for shipment resource
- Added configuration via config block
- Added possibility to configure http mode

## [0.2.0] - 2013-08-30
## Added
- Added find operation
- Added shipments attributes to allow easier access to response data

## [0.1.0] - 2013-08-30
## Added
- Added basic request handling
- Added Shipment class
- Added user agent

## Removed
- Removed ssl certificate reference
- Removed debug code

## Fixed
- Fixed request content-type and response validation


-----------------------------------------------------------------------------------------

Template:
## [0.0.0] - 2014-05-31
### Added
- something was added

### Changed
- something changed

### Deprecated
- something is depricated

### Removed
- something was removed

### Fixed
- something was fixed

### Security
- a security fix

Following "[Keep a CHANGELOG](http://keepachangelog.com/)"
