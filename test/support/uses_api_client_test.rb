require 'test_helper'

module UsesApiClientTest

  def client(auth = {})
    client = Lbry::Client.new(auth)
  end
end
