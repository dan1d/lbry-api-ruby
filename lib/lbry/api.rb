require 'httparty'
require 'json'

module Lbry
  class Api
    include HTTParty
    attr_accessor :auth, :default_options

    base_uri 'http://localhost:5279'
    headers 'Content-Type' => 'application/json'

    def parse_response(raw_response)
      # binding.pry
      struct = JSON.parse(raw_response.body, object_class: OpenStruct)
      error = struct.error
      return struct unless error && error.code && error.message
      # binding.pry
      raise Lbry::ApiError.new(error)
    end

    def initialize(auth: {})
      @auth = { username: auth["user"], password: auth["password"] }
      @default_options = {}
      default_options[:basic_auth] = auth if auth.values.any?
    end

    def request(http_method, lbry_method, lbry_params, headers: {})
      params = { body: { method: lbry_method, params: lbry_params }.to_json }
      params.merge!({headers: headers}) if headers.keys.any?
      response = self.class.send(http_method, '', params)
      parse_response(response)
    end

    def get(lbry_method, lbry_params = {})
      request(:get, lbry_method, lbry_params)
    end

    def post(lbry_method, lbry_params = {})
      headers = { "Content-Type" => "application/x-www-form-urlencoded" }
      request(:post, lbry_method, lbry_params, headers: headers)
    end

    def put(lbry_method, lbry_params = {})
      request(:put, lbry_method, lbry_params)
    end
    
  end
end
