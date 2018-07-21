require 'test_helper'
class ClientLbrycrdTest < Minitest::Test

  def client(auth = {})
    client = Lbry::Client.new(auth: auth, api: :crd)
  end

   def test_it_returns_a_claim_list
    VCR.use_cassette('brycrd/claims/claim_list_empty') do
      response = client.claim_list({name: "ruby"})
      claims = response.result.claims
      assert claims.is_a?(Array)
      assert_empty claims
    end
  end

  def test_it_returns_a_claim_list_with_results
    VCR.use_cassette('brycrd/claims/claim_list_with_results') do
      response = client.claim_list({name: "lbry"})
      claims = response.result.claims
      assert claims.is_a?(Array)
      refute_empty claims
    end
  end

  def test_it_shows_a_claim
    VCR.use_cassette('brycrd/claims/claim_list_with_results') do
      response = client.claim_list({name: "lbry"})
      first_claim = response.result.claims.first
      VCR.use_cassette('claims/show_a_claim') do
        response = client.claim_show({claim_id: first_claim.claim_id})
        claim = response.result
        assert_equal first_claim.claim_id, claim.claim_id
      end
    end
  end

  def test_it_shows_help
    VCR.use_cassette('brycrd/help/help_success') do
      response = client.help
      refute_empty response.result.command_help
    end
  end

  def test_it_shows_help
    VCR.use_cassette('brycrd/help/help_with_command_success') do
      response = client.help(command: "resolve")
      refute_empty response.result.help
    end
  end

  def test_it_resolve_uri
    VCR.use_cassette('brycrd/resolve/uri_success') do
      response = client.resolve(uri: "what")
      metadata = response.result.what.claim.value.stream.metadata
      assert_equal metadata.author, "Samuel Bryan"
      assert_equal metadata.title, "What is LBRY?"
    end
  end

  def test_it_download_file
    VCR.use_cassette('brycrd/get/download_file_success') do
      response = client.get(uri: "what")
      refute_empty response.result.claim_id
    end
  end

end
