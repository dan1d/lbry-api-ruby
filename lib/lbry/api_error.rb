
module Lbry
  class ApiError < StandardError
    def initialize(attributes)
      @error = attributes.error
      @code = attributes.code
      @message = attributes.message
      @data = attributes.data
      @jsonrpc = attributes.jsonrpc
    end
  end
end
