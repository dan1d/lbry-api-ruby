require 'test_helper'
require './test/support/uses_api_client_test.rb'

class ApiTest < Minitest::Test
  include UsesApiClientTest

  #  def test_it_raises_exception_on_root_path
  #   VCR.use_cassette('root_path_exception') do
  #     # Make sure we got the correct exception
  #     assert_raises Lbry::ApiError do
  #       result = client.get({})
  #       assert_equal result.class, ApiError
  #       assert_equal result.message, "Parse Error. Data is not valid JSON."
  #       assert_equal result.code, "-32700"
  #     end
  #   end
  # end
end
