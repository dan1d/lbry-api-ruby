require 'httparty'
require 'json'

module Lbry
  class Daemon < Api
    base_uri 'http://localhost:5279'
  end
end
