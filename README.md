# Lbry


LBRY is an open-source protocol providing distribution, discovery, and purchase of digital content (data) via a decentralized network.
Ruby wrapper for LBRY and LBRYcrd APIs

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'lbry'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install lbry

## Usage

```
client = Lbry::Client.new
response = client.claim_list({name: "lbry"})
claims = response.result.claims # array of claims
claims.first => #<OpenStruct address="bTzDhXE4vK6fLqU9LSVgrBGYhxuSj8spH8", amount=1.0, claim_id="2c63bcc26eb26d60e91fe99cd972e38bb64b3401", claim_sequence=15, decoded_claim=true, depth=232551, effective_amount=1.0, has_signature=false, height=147432, hex="080110011adc010801129401080410011a0d57686174206973204c4252593f223057686174206973204c4252593f20416e20696e74726f64756374696f6e207769746820416c6578205461626172726f6b2a0c53616d75656c20427279616e32084c42525920696e6338004a2f68747470733a2f2f73332e616d617a6f6e6177732e636f6d2f66696c65732e6c6272792e696f2f6c6f676f2e706e6752005a001a41080110011a30e3bcfb59a97efd76d5ce7533ff9aae8ad565df4b8d10db32b7296b07d2a3fbd41ba99c439cc972b567323fc97132041d2209766964656f2f6d7034", name="lbry", nout=0, permanent_url="lbry#2c63bcc26eb26d60e91fe99cd972e38bb64b3401", supports=[], txid="32b2c71eb1edb47dfa1b9b645c35fa5a4fdc77b4d4eada08d747e21f3f0871a7", valid_at_height=150075, value=#<OpenStruct claimType="streamType", stream=#<OpenStruct metadata=#<OpenStruct author="Samuel Bryan", description="What is LBRY? An introduction with Alex Tabarrok", language="en", license="LBRY inc", licenseUrl="", nsfw=false, preview="", thumbnail="https://s3.amazonaws.com/files.lbry.io/logo.png", title="What is LBRY?", version="_0_1_0">, source=#<OpenStruct contentType="video/mp4", source="e3bcfb59a97efd76d5ce7533ff9aae8ad565df4b8d10db32b7296b07d2a3fbd41ba99c439cc972b567323fc97132041d", sourceType="lbry_sd_hash", version="_0_0_1">, version="_0_0_1">, version="_0_0_1">> 
```

You can get the list of supported methods [here](https://github.com/dan1d/lbry-api-ruby/blob/master/lib/lbry/client.rb#L6) and the API doc [here](https://lbryio.github.io/lbry)


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/dan1d/lbry.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
