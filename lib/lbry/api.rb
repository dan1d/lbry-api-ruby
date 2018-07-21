require 'httparty'
require 'json'

module Lbry
  class Api
    include HTTParty
    attr_accessor :auth, :default_options

    headers 'Content-Type' => 'application/json'

    def parse_response(raw_response)
      struct = JSON.parse(raw_response.body, object_class: OpenStruct)
      error = struct.error
      return struct unless error && error.code && error.message
      binding.pry
      raise Lbry::ApiError.new(error)
    end

    def initialize(auth: {})
      @auth = { username: auth["user"], password: auth["password"] }
      @default_options = {}
    end

    def request(http_verb, lbry_command, lbry_params, headers: {})
      params = { body: { method: lbry_command, params: lbry_params }.to_json }
      params[:headers] = headers if headers.keys.any?
      response = self.class.send(http_verb, '', params)
      parse_response(response)
    end

    def post(lbry_command, *lbry_params)
      headers = { "Content-Type" => "application/x-www-form-urlencoded" }
      params = { body: { method: lbry_command, params: lbry_params }.to_json }
      params[:headers] = headers if headers.keys.any?
      if auth[:username] && auth[:password]
        params[:basic_auth] = auth
      end
      response = self.class.post('', params)
      parse_response(response)
    end
  end
end
