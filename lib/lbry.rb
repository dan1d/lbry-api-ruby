require "lbry/version"
require "lbry/api"
require "lbry/api_error"
require "lbry/client"

module Lbry
  def initialize(auth: {})
    Client.new(auth: auth)
  end
end
