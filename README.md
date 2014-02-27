# Notsofast

Rate limiting rails rack gem.  Add to gem file to start limiting based on IP

## Installation

Add this line to your application's Gemfile:

    gem 'notsofast'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install notsofast

## Usage

By default starts limiting on 100 requests per minute.  This is on an IP address basis. 

## Configuration

Create a rails initializer (config/initializers/notsofast.rb) with the following as required

### whitelist
Set an array of string values containing whitelisted ip addresses eg ["127.0.0.1"]

  Notsofast::Config.whitelist=[]

### blacklist
Set an array of string values containing blacklisted ip addresses eg ["127.0.0.1"]

  Notsofast::Config.blacklist=[]

### request_limit
Specifies the number of permitted request per limit_exipry period

  Notsofast::Config.request_limit=100

### response_types
Specifies the response types that the limit applies to (eg ignore images and other assets)

  Notsofast::Config.response_types=["text/html"]

### limit_expiry
Sets the time before limits are reset and within which the limit is reached

  Notsofast::Config.limit_expiry=60



## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
