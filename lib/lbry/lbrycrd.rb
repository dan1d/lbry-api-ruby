require 'httparty'
require 'json'

module Lbry
  class Lbrycrd < Api
    base_uri 'http://localhost:9245'
  end
end
