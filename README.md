[![CircleCI](https://circleci.com/gh/shipcloud/shipcloud-ruby/tree/master.svg?style=svg)](https://circleci.com/gh/shipcloud/shipcloud-ruby/tree/master)
[![Maintainability](https://api.codeclimate.com/v1/badges/c8c3cba2068e5d649567/maintainability)](https://codeclimate.com/github/shipcloud/shipcloud-ruby/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/c8c3cba2068e5d649567/test_coverage)](https://codeclimate.com/github/shipcloud/shipcloud-ruby/test_coverage)

**NOTE**: _This repository is no longer supported or updated._

# shipcloud

A Ruby wrapper for the shipcloud API

We have dropped the support of jruby-9, because there is an issue with mixing hash and keyword arguments (https://github.com/jruby/jruby/issues/3138). When this issue is fixed, we will support jruby-9 again.

## Installation

Add this line to your application's Gemfile:

    gem 'shipcloud'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install shipcloud

## Usage

Before using the shipcloud API, you may want to set the API access key.

```ruby
Shipcloud.api_key = 'your-api-key-goes-here'
```

Since Version 0.4.0, you can also do this via a configuration block, e.g. in an initializer:

```ruby
Shipcloud.configure do |config|
  config.api_key = 'your-api-key-goes-here'
end
```

You can also pass the API key with each request:
```ruby
 Shipcloud::Shipment.create(
   {
     carrier: 'ups',
     from: from-address-params,
     to: to-address-params,
     package: package-params,
     create_shipping_label: true
   },
  api_key: "your-api-key"
 )
```
If you pass in the ```api_key``` option, the value will be used as API key for the current request, even if you have set the ```Shipcloud.api_key``` before.

You can sign up for a developer account at *[shipcloud.io](http://www.shipcloud.io)*

### Create a new shipment

To create a new Shipment on the shipcloud platform, you need to provide the name of the carrier, to- and from-address, and the package dimensions.
For details, see *[shipcloud API documentation on Shipments](http://developers.shipcloud.io/reference/#shipments)*
```ruby
Shipcloud::Shipment.create(
    carrier: 'ups',
    from: from-address-params,
    to: to-address-params,
    package: package-params,
    create_shipping_label: true
)
```

`Shipment#create` will return shipping label and tracking information, encapsulated in a `Shipcloud::Shipment` object:

```ruby
shipment = Shipcloud::Shipment.create(...) # parameters ommitted
shipment.tracking_url # -> http://track.shipcloud.io/uzdgu22z3ed12
```

### Get a list of shipments

You can get a list of all shipments from the shipcloud platform. Shipments can be filtered by providing optional parameters. For more information and a list of valid parameters see *[shipcloud API documentation on Shipments Index](https://developers.shipcloud.io/reference/#getting-a-list-of-shipments)*

```ruby
Shipcloud::Shipment.all({
  carrier: 'ups',
  per_page: 25,
  page: 2
})
```

`Shipment#all` will return an array of `Shipcloud::Shipment` objects, matching the given parameters.

### Get a shipment quote

To get a shipment qoute from the shipcloud platform, you need to provide the name of the carrier, the service, to- and from-address, and the package dimensions.
For details, see *[shipcloud API documentation on shipment quotes](https://developers.shipcloud.io/reference/#shipment-quotes)*

```ruby
shipment_quote = Shipcloud::ShipmentQuote.create(
  carrier: 'ups',
  service: 'standard',
  to: {
    street: "Receiver street",
    street_no: "123",
    zip_code: "12345",
    city: "Receiver town",
    country: "DE"
  },
  from: {
    street: "Sender street",
    street_no: "321",
    zip_code: "54321",
    city: "Sender town",
    country: "DE"
  },
  package: {
    weight: 8,
    width: 15,
    length: 32,
    height: 46,
  },
)

shipment_quote.price # => 6.2
```

### Create a pickup request

To request parcels being picked up, you need to provide the carrier name and the time (earliest and latest) your shipments shall be fetched.

```ruby
pickup_request = Shipcloud::PickupRequest.create(
  carrier: 'dpd',
  pickup_time: {
    earliest: "2016-04-04T09:00:00+02:00",
    latest: "2016-04-04T18:00:00+02:00"
  }
)

pickup_request.id # => "dje892dj20d2odj20"
pickup_request.carrier_pickup_number # => "12345"
```

You may also provide a list of shipment ids to specify only certain shipments to be included in the pickup request.

```ruby
pickup_request = Shipcloud::PickupRequest.create(
  carrier: 'dpd',
  pickup_time: {
    earliest: "2016-04-04T09:00:00+02:00",
    latest: "2016-04-04T18:00:00+02:00"
  },
  shipments: [
    { id: "abc_123"}
  ]
)

pickup_request.id # => "dje892dj20d2odj20"
pickup_request.carrier_pickup_number # => "12345"
```



## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Update the "Unreleased" section of the [CHANGELOG.md](CHANGELOG.md) ([Keep a CHANGELOG](http://keepachangelog.com/))
5. Push to the branch (`git push origin my-new-feature`)
6. Create new Pull Request
