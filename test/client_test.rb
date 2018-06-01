require 'test_helper'
require './test/support/uses_api_client_test.rb'

class ApiTest < Minitest::Test
  include UsesApiClientTest

   def test_it_returns_a_claim_list
    VCR.use_cassette('claims/claim_list_empty') do
      response = client.claim_list({name: "ruby"})
      claims = response.result.claims
      assert claims.is_a?(Array)
      assert_empty claims
    end
  end

  def test_it_returns_a_claim_list_with_results
    VCR.use_cassette('claims/claim_list_with_results') do
      response = client.claim_list({name: "lbry"})
      claims = response.result.claims
      assert claims.is_a?(Array)
      refute_empty claims
    end
  end

  def test_it_shows_a_claim
    VCR.use_cassette('claims/claim_list_with_results') do
      response = client.claim_list({name: "lbry"})
      first_claim = response.result.claims.first
      VCR.use_cassette('claims/show_a_claim') do
        response = client.claim_show({claim_id: first_claim.claim_id})
        claim = response.result
        assert_equal first_claim.claim_id, claim.claim_id
      end
    end
  end
end
