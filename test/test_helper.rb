$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'lbry'

require 'minitest/autorun'
require 'webmock/minitest'
require 'vcr'
require 'pry'

VCR.configure do |c|
  c.cassette_library_dir = "test/fixtures"
  c.hook_into :webmock
end
