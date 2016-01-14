[![Code Climate](https://codeclimate.com/github/shipcloud/shipcloud-ruby.png)](https://codeclimate.com/github/shipcloud/shipcloud-ruby) [![Build Status](https://travis-ci.org/shipcloud/shipcloud-ruby.png?branch=master)](https://travis-ci.org/shipcloud/shipcloud-ruby)
# shipcloud

A Ruby wrapper for the shipcloud API

## Installation

Add this line to your application's Gemfile:

    gem 'shipcloud'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install shipcloud

## Usage

Before using the shipcloud API, you need to set the API access key:

```
Shipcloud.api_key = 'your-api-key-goes-here'
```

Since Version 0.4.0, you can also do this via a configuration block, e.g. in an initializer:

```
Shipcloud.configure do |config|
  config.api_key = 'your-api-key-goes-here'
end
```

You can sign up for a developer account at *[shipcloud.io](http://www.shipcloud.io)*

### Create a new shipment

To create a new Shipment on the shipclod platform, you need to provide the name of the carrier, to- and from-address, and the package dimensions.
For details, see *[shipcloud API documentation on Shipments](http://developers.shipcloud.io/reference/#shipments)*
```
Shipcloud::Shipment.create(
    carrier: 'ups',
    from: from-address-params,
    to: to-address-params,
    package: package-params,
    create_shipping_label: true
)
```

`Shipment#create` will return shipping label and tracking information, encapsulated in a `Shipcloud::Shipment` object:

```
shipment = Shipcloud::Shipment.create(...) # parameters ommitted
shipment.tracking_url # -> http://track.shipcloud.io/uzdgu22z3ed12
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Update the "Unreleased" section of the [CHANGELOG.md](CHANGELOG.md) ([Keep a CHANGELOG](http://keepachangelog.com/))
5. Push to the branch (`git push origin my-new-feature`)
6. Create new Pull Request
